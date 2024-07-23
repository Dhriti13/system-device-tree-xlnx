#
# (C) Copyright 2014-2021 Xilinx, Inc.
# (C) Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#

    proc psu_ocm_gen_reg_prop {drv_handle} {
        global ddr_baseaddr
        global is_64_bit_mb
        set overall_addr_list ""
        set proc_addr_list ""
        global apu_proc_ip
        set a53 0
        set name [hsi::get_cells -hier ${drv_handle}]
        set proclist [hsi::get_cells -hier -filter {IP_TYPE==PROCESSOR}]
        set platform [get_hw_family]
        set 32_bit_format 0
        foreach procc $proclist {
                set proc_ip_name [get_ip_property $procc IP_NAME]
                if { $proc_ip_name == $apu_proc_ip} {
                        if {$a53 == 1} {
                                continue
                        }
                        set a53 1
                }
                set proc_mem_map [hsi::get_mem_ranges -of_objects $procc]
                set index [lsearch $proc_mem_map $name]

                # Check if there is any memory bank is mapped to the current processor
                if {$index == "-1"} {
                        continue
                }

                while {1} {
                        set index [lsearch -start $index $proc_mem_map $name]
                        if {$index == "-1"} {
                                break
                        }
                        set base [hsi get_property BASE_VALUE [lindex $proc_mem_map $index]]
                        set high [hsi get_property HIGH_VALUE [lindex $proc_mem_map $index]]
                        lappend overall_addr_list "$base $high"
                        lappend proc_addr_list "$base $high"
                        incr index
                }
                if {$proc_ip_name in {"psu_cortexr5" "psv_cortexr5" "psx_cortexr52" "cortexr52" microblaze" "microblaze_riscv"}} {
                        set_memmap "${drv_handle}_memory" $procc [psu_ocm_get_union_reg_prop $proc_addr_list $name $32_bit_format]
                }
                if {$proc_ip_name in {"psu_cortexa53" "psv_cortexa72" "psx_cortexa78" "cortexa78"}} {
                        set_memmap "${drv_handle}_memory" a53 [psu_ocm_get_union_reg_prop $proc_addr_list $name $32_bit_format]
                }
                if {[string match -nocase ${proc_ip_name} "psu_pmu"]} {
                        set_memmap "${drv_handle}_memory" pmu [psu_ocm_get_union_reg_prop $proc_addr_list $name $32_bit_format]
                }
                if {$proc_ip_name in {"psv_pmc" "psx_pmc" "pmc"}} {
                        set_memmap "${drv_handle}_memory" pmc [psu_ocm_get_union_reg_prop $proc_addr_list $name $32_bit_format]
                }
                if {$proc_ip_name in {"psv_psm" "psx_psm" "psm"}} {
                        set_memmap "${drv_handle}_memory" psm [psu_ocm_get_union_reg_prop $proc_addr_list $name $32_bit_format]
                }
        }

        # get_baseaddr gives the address of the first memory bank mapped. In case of ZU+MB designs
        # first bank can be mapped to mb whose mapped base address may not be same as the overall
        # base address among all the banks. Thus, sorting the overall addr list to get the global
        # lowest addr.

        set overall_addr_list [lsort -real -index 0 $overall_addr_list]
        set ddr_baseaddr [lindex [lindex $overall_addr_list 0] 0]
        regsub -all {^0x} $ddr_baseaddr {} ddr_baseaddr
        if {[string equal -nocase $platform "microblaze"] && !$is_64_bit_mb} {
                set 32_bit_format 1
        }
        return [psu_ocm_get_union_reg_prop $overall_addr_list $name $32_bit_format]
}


proc psu_ocm_generate {drv_handle} {
        set reg_prop [psu_ocm_gen_reg_prop $drv_handle]
        if {![string_is_empty $reg_prop]} {
                global ddr_baseaddr
                set dts_file "system-top.dts"
                set system_node [create_node -l "${drv_handle}_memory" -n "memory" -u $ddr_baseaddr -p root -d $dts_file]
                add_prop $system_node reg $reg_prop hexlist $dts_file
                add_prop $system_node "device_type" "memory" string $dts_file
                add_prop $system_node "compatible" "[gen_compatible_string $drv_handle] mmio-sram" stringlist $dts_file
                add_prop $system_node "xlnx,ip-name" [get_ip_property $drv_handle IP_NAME] string $dts_file
                add_prop $system_node "memory_type" "memory" string $dts_file
        }
}


proc psu_ocm_get_reg_format {base high name 32_bit_format} {
        # Converts the base and high addresses into device tree reg format base and size
        # Makes proper adjustements for 32 bit and 64 bit address and size formats

        set reg ""
        set addr_64 "0"
        set size_64 "0"
        set mem_size [format 0x%X [expr {${high} - ${base} + 1}]]
        if {[regexp -nocase {0x([0-9a-f]{9})} "$base" match]} {
                set addr_64 "1"
                set temp $base
                set temp [string trimleft [string trimleft $temp 0] x]
                set len [string length $temp]
                set rem [expr {${len} - 8}]
                set high_base "0x[string range $temp $rem $len]"
                set low_base "0x[string range $temp 0 [expr {${rem} - 1}]]"
                set low_base [format 0x%08X $low_base]

        }
        if {[regexp -nocase {0x([0-9a-f]{9})} "$mem_size" match]} {
                set size_64 "1"
                set temp $mem_size
                set temp [string trimleft [string trimleft $temp 0] x]
                set len [string length $temp]
                set rem [expr {${len} - 8}]
                set high_size "0x[string range $temp $rem $len]"
                set low_size "0x[string range $temp 0 [expr {${rem} - 1}]]"
                set low_size [format 0x%08X $low_size]
        }

        if {[string match $addr_64 "1"] && [string match $size_64 "1"]} {
                set reg "$low_base $high_base $low_size $high_size"
        } elseif {[string match $addr_64 "1"] && [string match $size_64 "0"]} {
                set reg "${low_base} ${high_base} 0x0 ${mem_size}"
        } elseif {[string match $addr_64 "0"] && [string match $size_64 "1"]} {
                set reg "0x0 ${base} ${low_size} ${high_size}"
        } elseif { $32_bit_format } {
                # For Microblaze where address and size cells are 1, memory node at the top
                # should be in below format
                set reg "${base} ${mem_size}"
        } else {
                set reg "0x0 ${base} 0x0 ${mem_size}"
        }
        return $reg
}

proc psu_ocm_get_union_reg_prop {complete_addr_list name 32_bit_format} {
        # Gets the list of all the (base_addr high_addr), figures out the unified address range.
        #
        # Sample Input: {0x20000000 0x3FFFFFFF} {0x20000000 0x3FFFFFFF} {0x20000000 0x3FFFFFFF}
        # {0x20000000 0x3FFFFFFF} {0x20000000 0x3FFFFFFF} {0x20000000 0x3FFFFFFF} {0x20000000 0x3FFFFFFF}
        # {0x20000000 0x3FFFFFFF} {0x0 0x7FEFFFFF} {0x7FF00000 0x7FFFFFFF} {0x0 0x7FEFFFFF} {0x7FF00000 0x7FFFFFFF}
        #
        # Output: <0x0 0x0 0x0 0x7ff00000>, <0x0 0x7FF00000 0x0 0x100000>

        set regprop ""
        set updated_addr_list [list]

        # Pseudo code for below logic:
        # a = [list of (base_addr_x high_addr_x)]
        # b = []
        # for begin,end in sorted(a):
        #     if b and b[-1][1] >= begin:
        #         b[-1][1] = max(b[-1][1], end)
        #     else:
        #         b.append([begin, end])
        #

        set complete_addr_list [lsort -real -index 0 $complete_addr_list]
        foreach addr_set $complete_addr_list {
                lassign $addr_set curr_base_addr curr_high_addr
                if {[llength $updated_addr_list] > 0 && [lindex [lindex $updated_addr_list end] end] >= $curr_base_addr} {
                        set new_end [lindex [lindex $updated_addr_list end] end]
                        if {$new_end < $curr_high_addr} {
                                set updated_addr_list [list [lreplace [lindex $updated_addr_list end] end end $curr_high_addr]]
                        }
                } else {
                        lappend updated_addr_list "$curr_base_addr $curr_high_addr"
                }
        }

        # updated_addr_list at this point : {0x0 0x7FEFFFFF} {0x7FF00000 0x7FFFFFFF}

        foreach addr_set $updated_addr_list {
                lassign $addr_set curr_base_addr curr_high_addr
                set reg_to_add [psu_ocm_get_reg_format $curr_base_addr $curr_high_addr $name $32_bit_format]
                if {[string_is_empty $regprop]} {
                        set regprop $reg_to_add
                } else {
                        append regprop ">, " "<$reg_to_add"
                }
        }
        return $regprop
}