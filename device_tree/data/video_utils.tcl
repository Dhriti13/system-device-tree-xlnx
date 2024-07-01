#
# Copyright (C) 2024 Advanced Micro Devices, Inc.
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

package require Tcl 8.5.14

global set end_mappings [dict create]
global set remo_mappings [dict create]
global set port1_end_mappings [dict create]
global set port2_end_mappings [dict create]
global set port3_end_mappings [dict create]
global set port4_end_mappings [dict create]
global set axis_port1_remo_mappings [dict create]
global set axis_port2_remo_mappings [dict create]
global set axis_port3_remo_mappings [dict create]
global set axis_port4_remo_mappings [dict create]
global set port1_broad_end_mappings [dict create]
global set port2_broad_end_mappings [dict create]
global set port3_broad_end_mappings [dict create]
global set port4_broad_end_mappings [dict create]
global set port5_broad_end_mappings [dict create]
global set port6_broad_end_mappings [dict create]
global set broad_port1_remo_mappings [dict create]
global set broad_port2_remo_mappings [dict create]
global set broad_port3_remo_mappings [dict create]
global set broad_port4_remo_mappings [dict create]
global set broad_port5_remo_mappings [dict create]
global set broad_port6_remo_mappings [dict create]
global set axis_switch_in_end_mappings [dict create]
global set axis_switch_port1_end_mappings [dict create]
global set axis_switch_port2_end_mappings [dict create]
global set axis_switch_port3_end_mappings [dict create]
global set axis_switch_port4_end_mappings [dict create]
global set axis_switch_in_remo_mappings [dict create]
global set axis_switch_port1_remo_mappings [dict create]
global set axis_switch_port2_remo_mappings [dict create]
global set axis_switch_port3_remo_mappings [dict create]
global set axis_switch_port4_remo_mappings [dict create]

proc gen_endpoint {drv_handle value} {
        global end_mappings
        dict append end_mappings $drv_handle $value
        set val [dict get $end_mappings $drv_handle]
}

proc gen_axis_port1_endpoint {drv_handle value} {
       global port1_end_mappings
       dict append port1_end_mappings $drv_handle $value
       set val [dict get $port1_end_mappings $drv_handle]
}

proc gen_axis_port2_endpoint {drv_handle value} {
       global port2_end_mappings
       dict append port2_end_mappings $drv_handle $value
       set val [dict get $port2_end_mappings $drv_handle]
}

proc gen_axis_port3_endpoint {drv_handle value} {
       global port3_end_mappings
       dict append port3_end_mappings $drv_handle $value
       set val [dict get $port3_end_mappings $drv_handle]
}

proc gen_axis_port4_endpoint {drv_handle value} {
       global port4_end_mappings
       dict append port4_end_mappings $drv_handle $value
       set val [dict get $port4_end_mappings $drv_handle]
}

proc gen_axis_switch_in_endpoint {drv_handle value} {
       global axis_switch_in_end_mappings
       dict append axis_switch_in_end_mappings $drv_handle $value
       set val [dict get $axis_switch_in_end_mappings $drv_handle]
}

proc gen_axis_switch_in_remo_endpoint {drv_handle value} {
       global axis_switch_in_remo_mappings
       dict append axis_switch_in_remo_mappings $drv_handle $value
       set val [dict get $axis_switch_in_remo_mappings $drv_handle]
}

proc gen_axis_switch_port1_endpoint {drv_handle value} {
       global axis_switch_port1_end_mappings
       dict append axis_switch_port1_end_mappings $drv_handle $value
       set val [dict get $axis_switch_port1_end_mappings $drv_handle]
}

proc gen_axis_switch_port2_endpoint {drv_handle value} {
       global axis_switch_port2_end_mappings
       dict append axis_switch_port2_end_mappings $drv_handle $value
       set val [dict get $axis_switch_port2_end_mappings $drv_handle]
}

proc gen_axis_switch_port3_endpoint {drv_handle value} {
       global axis_switch_port3_end_mappings
       dict append axis_switch_port3_end_mappings $drv_handle $value
       set val [dict get $axis_switch_port3_end_mappings $drv_handle]
}

proc gen_axis_switch_port4_endpoint {drv_handle value} {
       global axis_switch_port4_end_mappings
       dict append axis_switch_port4_end_mappings $drv_handle $value
       set val [dict get $axis_switch_port4_end_mappings $drv_handle]
}

proc gen_axis_switch_port1_remote_endpoint {drv_handle value} {
       global axis_switch_port1_remo_mappings
       dict append axis_switch_port1_remo_mappings $drv_handle $value
       set val [dict get $axis_switch_port1_remo_mappings $drv_handle]
}

proc gen_axis_switch_port2_remote_endpoint {drv_handle value} {
       global axis_switch_port2_remo_mappings
       dict append axis_switch_port2_remo_mappings $drv_handle $value
       set val [dict get $axis_switch_port2_remo_mappings $drv_handle]
}

proc gen_axis_switch_port3_remote_endpoint {drv_handle value} {
       global axis_switch_port3_remo_mappings
       dict append axis_switch_port3_remo_mappings $drv_handle $value
       set val [dict get $axis_switch_port3_remo_mappings $drv_handle]
}

proc gen_axis_switch_port4_remote_endpoint {drv_handle value} {
       global axis_switch_port4_remo_mappings
       dict append axis_switch_port4_remo_mappings $drv_handle $value
       set val [dict get $axis_switch_port4_remo_mappings $drv_handle]
}

proc gen_broad_endpoint_port1 {drv_handle value} {
        global port1_broad_end_mappings
        dict append port1_broad_end_mappings $drv_handle $value
        set val [dict get $port1_broad_end_mappings $drv_handle]
}

proc gen_broad_endpoint_port2 {drv_handle value} {
        global port2_broad_end_mappings
        dict append port2_broad_end_mappings $drv_handle $value
        set val [dict get $port2_broad_end_mappings $drv_handle]
}

proc gen_broad_endpoint_port3 {drv_handle value} {
        global port3_broad_end_mappings
        dict append port3_broad_end_mappings $drv_handle $value
        set val [dict get $port3_broad_end_mappings $drv_handle]
}

proc gen_broad_endpoint_port4 {drv_handle value} {
        global port4_broad_end_mappings
        dict append port4_broad_end_mappings $drv_handle $value
        set val [dict get $port4_broad_end_mappings $drv_handle]
}

proc gen_broad_endpoint_port5 {drv_handle value} {
        global port5_broad_end_mappings
        dict append port5_broad_end_mappings $drv_handle $value
        set val [dict get $port5_broad_end_mappings $drv_handle]
}

proc gen_broad_endpoint_port6 {drv_handle value} {
        global port6_broad_end_mappings
        dict append port6_broad_end_mappings $drv_handle $value
        set val [dict get $port6_broad_end_mappings $drv_handle]
}

proc get_axis_switch_in_connect_ip {ip intfpins} {
       puts "get_axis_switch_in_connect_ip:$ip $intfpins"
       global connectip ""
       foreach intf $intfpins {
               set connectip [get_connected_stream_ip [hsi get_cells -hier $ip] $intf]
               puts "connectip:$connectip"
               foreach cip $connectip {
			if {[llength $cip]} {
				set ipname [hsi get_property IP_NAME $cip]
				puts "ipname:$ipname"
				set ip_mem_handles [get_ip_mem_ranges $cip]
				if {[llength $ip_mem_handles]} {
					break
				} else {
				set master_intf [::hsi::get_intf_pins -of_objects [hsi get_cells -hier $cip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
				get_axis_switch_in_connect_ip $cip $master_intf
				}
                       }
               }
       }
       return $connectip
}

proc gen_remoteendpoint {drv_handle value} {
        global remo_mappings
        dict append remo_mappings $drv_handle $value
        set val [dict get $remo_mappings $drv_handle]
}

proc gen_axis_port1_remoteendpoint {drv_handle value} {
       global axis_port1_remo_mappings
       dict append axis_port1_remo_mappings $drv_handle $value
       set val [dict get $axis_port1_remo_mappings $drv_handle]
}

proc gen_axis_port2_remoteendpoint {drv_handle value} {
       global axis_port2_remo_mappings
       dict append axis_port2_remo_mappings $drv_handle $value
       set val [dict get $axis_port2_remo_mappings $drv_handle]
}

proc gen_axis_port3_remoteendpoint {drv_handle value} {
       global axis_port3_remo_mappings
       dict append axis_port3_remo_mappings $drv_handle $value
       set val [dict get $axis_port3_remo_mappings $drv_handle]
}

proc gen_axis_port4_remoteendpoint {drv_handle value} {
       global axis_port4_remo_mappings
       dict append axis_port4_remo_mappings $drv_handle $value
       set val [dict get $axis_port4_remo_mappings $drv_handle]
}

proc gen_broad_remoteendpoint_port1 {drv_handle value} {
        global broad_port1_remo_mappings
        dict append broad_port1_remo_mappings $drv_handle $value
        set val [dict get $broad_port1_remo_mappings $drv_handle]
}

proc gen_broad_remoteendpoint_port2 {drv_handle value} {
        global broad_port2_remo_mappings
        dict append broad_port2_remo_mappings $drv_handle $value
        set val [dict get $broad_port2_remo_mappings $drv_handle]
}

proc gen_broad_remoteendpoint_port3 {drv_handle value} {
        global broad_port3_remo_mappings
        dict append broad_port3_remo_mappings $drv_handle $value
        set val [dict get $broad_port3_remo_mappings $drv_handle]
}

proc gen_broad_remoteendpoint_port4 {drv_handle value} {
        global broad_port4_remo_mappings
        dict append broad_port4_remo_mappings $drv_handle $value
        set val [dict get $broad_port4_remo_mappings $drv_handle]
}

proc gen_broad_remoteendpoint_port5 {drv_handle value} {
        global broad_port5_remo_mappings
        dict append broad_port5_remo_mappings $drv_handle $value
        set val [dict get $broad_port5_remo_mappings $drv_handle]
}

proc gen_broad_remoteendpoint_port6 {drv_handle value} {
        global broad_port6_remo_mappings
        dict append broad_port6_remo_mappings $drv_handle $value
        set val [dict get $broad_port6_remo_mappings $drv_handle]
}

    proc gen_broadcaster {ip dts_file} {
        global end_mappings
        global remo_mappings
        dtg_verbose "+++++++++gen_broadcaster:$ip"
        set count 0
        set inputip ""
        set outip ""
        set connectip ""
        set compatible [get_comp_str $ip]
        set intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $ip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
        set inip [get_connected_stream_ip [hsi::get_cells -hier $ip] $intf]
        set inip [get_in_connect_ip $ip $intf]
	set default_dts [set_drv_def_dts $ip]
	set bus_node [detect_bus_name $ip]
        set broad_node [create_node -n "axis_broadcaster$ip" -l $ip -u 0 -p $bus_node -d $dts_file]
        set ports_node [create_node -n "ports" -l axis_broadcaster_ports$ip -p $broad_node -d $dts_file]
        add_prop "$ports_node" "#address-cells" 1 int $dts_file
        add_prop "$ports_node" "#size-cells" 0 int $dts_file
        add_prop "$broad_node" "compatible" "$compatible" string $dts_file
        set master_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $ip] -filter {TYPE==MASTER || TYPE ==INITIATOR}]
        set broad 10
        foreach intf $master_intf {
            set connectip [get_connected_stream_ip [hsi::get_cells -hier $ip] $intf]
            if {[llength $connectip]} {
                set ip_mem_handles [hsi::get_mem_ranges $connectip]
                if {![llength $ip_mem_handles]} {
                    set master_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==MASTER || TYPE ==INITIATOR}]
                    set connectip [get_connected_stream_ip [hsi::get_cells -hier $connectip] $master_intf]
                    if {[llength $connectip]} {
                        set ip_mem_handles [hsi::get_mem_ranges $connectip]
                        if {![llength $ip_mem_handles]} {
                            set master2_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==MASTER || TYPE ==INITIATOR}]
                            set connectip [get_connected_stream_ip [hsi::get_cells -hier $connectip] $master2_intf]
                        }
                        if {[llength $connectip]} {
                            set ip_mem_handles [hsi::get_mem_ranges $connectip]
                            if {![llength $ip_mem_handles]} {
                                set master3_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==MASTER || TYPE ==INITIATOR}]
                                set connectip [get_connected_stream_ip [hsi::get_cells -hier $connectip] $master3_intf]
                            }
                        }
                    }
                }
                incr count
                set port_node [create_node -n "port" -l axis_broad_port$count$ip -u $count -p $ports_node -d $dts_file]
                add_prop "$port_node" "reg" $count int $dts_file
                set axis_node [create_node -n "endpoint" -l axis_broad_out$count$ip -p $port_node -d $dts_file]
                if {$count <= $count-1} {
                    gen_broad_endpoint_port$count $ip "axis_broad_out$count$ip"
                }
                add_prop "$axis_node" "remote-endpoint" $connectip$ip reference $dts_file
                if {$count <= $count-1} {
                    gen_broad_remoteendpoint_port$count $ip $connectip$ip
                }
                append inputip " " $connectip
                append outip " " $connectip$ip
            }
        }
        if {[string match -nocase [hsi::get_property IP_NAME $connectip] "v_frmbuf_wr"]} {
            gen_broad_frmbuf_wr_node $inputip $outip $ip $count $dts_file
        }

        if {[llength $ip]} {
            set axis_broad_ip [hsi::get_property IP_NAME $ip]
            # broad_ip means broadcaster input ip is connected to another ip
            set broad_ip [get_broad_in_ip $ip]
            set validate_ip 1
            if {[llength $broad_ip]} {
                if { [hsi get_property IP_NAME $broad_ip] in { "v_proc_ss" "ISPPipeline_accel" } } {
            # set validate ip is 0 when axis_broadcaster input ip is
            # connect to v_proc_ss or ISPPipeline_accel to skip the below checks
                    set validate_ip 0
                }
            }
            # add unit_addr and ip_type check when axis_broadcaster input ip is connected with other ips
            if {$validate_ip} {
                set unit_addr [get_baseaddr ${ip} no_prefix]
                if { ![string equal $unit_addr "-1"] } {
                    break
                }
                set ip_type [get_property IP_TYPE $ip]
                if {[string match -nocase $ip_type "BUS"]} {
                    break
                }
            }
            set label $ip
            set bus_node [detect_bus_name $ip]
            set dts_file [set_drv_def_dts $ip]
            set rt_node [create_node -n "axis_broadcaster$ip" -l ${label} -u 0 -d ${dts_file} -p $bus_node]
            if {[llength $axis_broad_ip]} {
                set intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $ip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
                set inip [get_in_connect_ip $ip $intf]
                if {[llength $inip]} {
                    set inipname [hsi get_property IP_NAME $inip]
                    set valid_mmip_list "mipi_csi2_rx_subsystem v_tpg v_hdmi_rx_ss v_smpte_uhdsdi_rx_ss v_smpte_uhdsdi_tx_ss v_demosaic v_gamma_lut v_proc_ss v_frmbuf_rd v_frmbuf_wr v_hdmi_tx_ss v_uhdsdi_audio audio_formatter i2s_receiver i2s_transmitter mipi_dsi_tx_subsystem v_mix v_multi_scaler v_scenechange"
                    if {[lsearch  -nocase $valid_mmip_list $inipname] >= 0} {
                        set ports_node [create_node -n "ports" -l axis_broadcaster_ports$ip -p $rt_node -d $dts_file]
                        add_prop "$ports_node" "#address-cells" 1 int $dts_file 1
                        add_prop "$ports_node" "#size-cells" 0 int $dts_file 1
                        set port_node [create_node -n "port" -l axis_broad_port0$ip -u 0 -p $ports_node -d $dts_file]
                        add_prop "$port_node" "reg" 0 int $dts_file
                        if {[llength $inip]} {
                            set axis_broad_in_end ""
                            set axis_broad_remo_in_end ""
                            if {[dict exists $end_mappings $inip]} {
                                set axis_broad_in_end [dict get $end_mappings $inip]
                                dtg_verbose "drv:$ip inend:$axis_broad_in_end"
                            }
                            if {[dict exists $remo_mappings $inip]} {
                                set axis_broad_remo_in_end [dict get $remo_mappings $inip]
                                dtg_verbose "drv:$ip inremoend:$axis_broad_remo_in_end"
                            }
                            if {[llength $axis_broad_remo_in_end]} {
                                set axisinnode [create_node -n "endpoint" -l $axis_broad_remo_in_end -p $port_node -d $dts_file]
                            }
                            if {[llength $axis_broad_in_end]} {
                                add_prop "$axisinnode" "remote-endpoint" $axis_broad_in_end reference $dts_file 1
                            }
                        }
                    }
                }
            }
        }
    }

    proc gen_broad_frmbuf_wr_node {inputip outip drv_handle count dts_file} {
        set bus_node [detect_bus_name $drv_handle]
        set vcap [create_node -n "vcapaxis_broad_out1$drv_handle" -p $bus_node -d $dts_file]
        add_prop $vcap "compatible" "xlnx,video" string $dts_file
        set inputip [split $inputip " "]
        set j 0
        foreach ip $inputip {
            if {[llength $ip]} {
                if {$j < $count} {
                    append dmasip "<&$ip 0>," " "
                }
            }
            incr j
        }
        append dmasip "<&$ip 0>"
        add_prop $vcap "dmas" "$dmasip" string $dts_file
        set prt ""
        for {set i 0} {$i < $count} {incr i} {
            append prt " " "port$i"
        }
        add_prop $vcap "dma-names" $prt stringlist $dts_file
        set vcap_ports_node [create_node -n "ports" -l "vcap_portsaxis_broad_out1$drv_handle" -p $vcap -d $dts_file]
        add_prop "$vcap_ports_node" "#address-cells" 1 int $dts_file
        add_prop "$vcap_ports_node" "#size-cells" 0 int $dts_file
        set outip [split $outip " "]
        set b 0
        for {set a 1} {$a <= $count} {incr a} {
            set vcap_port_node [create_node -n "port" -l "vcap_portaxis_broad_out$a$drv_handle" -u "$b" -p "$vcap_ports_node" -d $dts_file]
            add_prop "$vcap_port_node" "reg" $b int $dts_file
            add_prop "$vcap_port_node" "direction" input string $dts_file
            set vcap_in_node [create_node -n "endpoint" -l [lindex $outip $a] -p "$vcap_port_node" -d $dts_file]
            add_prop "$vcap_in_node" "remote-endpoint" axis_broad_out$a$drv_handle reference $dts_file
            incr b
        }
    }

    proc get_connect_ip {ip intfpins dts_file} {
        dtg_verbose "get_con_ip:$ip pins:$intfpins"
        if {[llength $intfpins]== 0} {
            return
        }
        if {[llength $ip]== 0} {
            return
        }
        if {[string match -nocase [hsi get_property IP_NAME [hsi::get_cells -hier $ip]] "axis_broadcaster"]} {
            gen_broadcaster $ip $dts_file
            return
        }
        global connectip ""
        foreach intf $intfpins {
            set connectip [get_connected_stream_ip [hsi::get_cells -hier $ip] $intf]
            if {[llength $connectip]} {
                if {[string match -nocase [hsi get_property IP_NAME [hsi::get_cells -hier $connectip]] "axis_broadcaster"]} {
                    gen_broadcaster $connectip
                    break
                }
                if {[string match -nocase [hsi get_property IP_NAME [hsi::get_cells -hier $connectip]] "axis_switch"]} {
                    gen_axis_switch $connectip
                    break
                }
            }
            set len [llength $connectip]
            if {$len > 1} {
                for {set i 0 } {$i < $len} {incr i} {
                    set ip [lindex $connectip $i]
                    if {[regexp -nocase "ila" $ip match]} {
                        continue
                    }
                    set connectip "$ip"
                }
            }
            if {[llength $connectip]} {
                set ip_mem_handles [hsi::get_mem_ranges $connectip]
                if {[llength $ip_mem_handles]} {
                    break
                } else {
                    set master_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==MASTER || TYPE ==INITIATOR}]
                    get_connect_ip $connectip $master_intf $dts_file
                }
            }
        }
        return $connectip
    }

    proc get_in_connect_ip {ip intfpins} {
        dtg_verbose "get_in_con_ip:$ip pins:$intfpins"
        if {[llength $intfpins]== 0} {
            return
        }
        if {[llength $ip]== 0} {
            return
        }
        global connectip ""
        foreach intf $intfpins {
            set connectip [get_connected_stream_ip [hsi::get_cells -hier $ip] $intf]
            if {[llength $connectip]} {
                set extip [hsi get_property IP_NAME $connectip]
                if {[string match -nocase $extip "dfe_glitch_protect"] || [string match -nocase $extip "axi_interconnect"] || [string match -nocase $extip "axi_crossbar"]} {
                    return
                }
            }
            set len [llength $connectip]
            if {$len > 1} {
                for {set i 0 } {$i < $len} {incr i} {
                    set ip [lindex $connectip $i]
                    if {[regexp -nocase "ila" $ip match]} {
                        continue
                    }
                    set connectip "$ip"
                }
            }
            if {[llength $connectip]} {
                set ip_mem_handles [hsi::get_mem_ranges $connectip]
                if {[llength $ip_mem_handles]} {
                    break
                } else {
                    if {[string match -nocase [hsi get_property IP_NAME $connectip] "system_ila"]} {
                        continue
                    }
                    set master_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
                    get_in_connect_ip $connectip $master_intf
                }
            }
        }
        return $connectip
    }

    proc gen_frmbuf_rd_node {ip drv_handle sdi_port_node dts_file} {
        set frmbuf_rd_node [create_node -n "endpoint" -l encoder$drv_handle -p $sdi_port_node -d $dts_file]
        add_prop "$frmbuf_rd_node" "remote-endpoint" $ip$drv_handle reference $dts_file
	set bus_node [detect_bus_name $drv_handle]
        set pl_display [create_node -n "drm-pl-disp-drv$drv_handle" -l "v_pl_disp$drv_handle" -p $bus_node -d $dts_file]
        add_prop $pl_display "compatible" "xlnx,pl-disp" string $dts_file
        add_prop $pl_display "dmas" "$ip 0" reference $dts_file
        add_prop $pl_display "dma-names" "dma0" string $dts_file
        add_prop $pl_display "xlnx,vformat" "YUYV" string $dts_file
        set pl_display_port_node [create_node -n "port" -l pl_display_port$drv_handle -u 0 -p $pl_display -d $dts_file]
        add_prop "$pl_display_port_node" "reg" 0 int $dts_file
        set pl_disp_crtc_node [create_node -n "endpoint" -l $ip$drv_handle -p $pl_display_port_node -d $dts_file]
        add_prop "$pl_disp_crtc_node" "remote-endpoint" encoder$drv_handle reference $dts_file
    }

proc gen_axis_switch {ip} {
	set compatible [get_comp_str $ip]
	dtg_verbose "+++++++++gen_axis_switch:$ip"
	set routing_mode [hsi get_property CONFIG.ROUTING_MODE [hsi get_cells -hier $ip]]
        if {$routing_mode == 1} {
                # Routing_mode is 1 means it is a memory mapped
                return
        }
	set intf [hsi::get_intf_pins -of_objects [hsi::get_cells -hier $ip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
	set inip [get_connected_stream_ip [hsi::get_cells -hier $ip] $intf]
	puts "connectinip:$inip"
	set intf1 [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $inip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
	set iip [get_connected_stream_ip [hsi::get_cells -hier $inip] $intf1]
	puts "iip:$iip"
	set inip [get_in_connect_ip $ip $intf]
	puts "inip:$inip"
	set bus_node [detect_bus_name $ip]
	set dts [set_drv_def_dts $ip]
	set switch_node [create_node -n "axis_switch_$ip" -l $ip -u 0 -p $bus_node -d $dts]
	set ports_node [create_node -n "ports" -l axis_switch_ports$ip -p $switch_node -d $dts]
	add_prop "$ports_node" "#address-cells" 1 int $dts
	add_prop "$ports_node" "#size-cells" 0 int $dts
	set master_intf [hsi::get_intf_pins -of_objects [hsi::get_cells -hier $ip] -filter {TYPE==MASTER || TYPE ==INITIATOR}]
	puts "intf:$master_intf"
	add_prop "$switch_node" "xlnx,routing-mode" $routing_mode int $dts
	set num_si [hsi get_property CONFIG.NUM_SI [hsi::get_cells -hier $ip]]

	add_prop "$switch_node" "xlnx,num-si-slots" $num_si int $dts
	set num_mi [hsi get_property CONFIG.NUM_MI [hsi::get_cells -hier $ip]]
	add_prop "$switch_node" "xlnx,num-mi-slots" $num_mi int $dts
	add_prop "$switch_node" "compatible" "$compatible" string $dts
	set count 0
	foreach intf $master_intf {
	       set connectip [get_connected_stream_ip [hsi::get_cells -hier $ip] $intf]
	       set len [llength $connectip]
               if {$len > 1} {
                       for {set i 0 } {$i < $len} {incr i} {
                              set temp_ip [lindex $connectip $i]
                              if {[regexp -nocase "ila" $temp_ip match]} {
                                      continue
                              }
                              set connectip "$temp_ip"
                      }
               }
	       puts "connectip:$connectip intf:$intf"
	       if {[llength $connectip]} {
		       incr count
	       }
	       if {$count == 1} {
		       set port_node [create_node -n "port" -l axis_switch_port1$ip -u 1 -p $ports_node -d $dts]
		       add_prop "$port_node" "reg" 1 int $dts
		       set axis_node [create_node -n "endpoint" -l axis_switch_out1$ip -p $port_node -d $dts]
		       gen_axis_port1_endpoint $ip "axis_switch_out1$ip"
		       add_prop "$axis_node" "remote-endpoint" $connectip$ip reference $dts
		       gen_axis_port1_remoteendpoint $ip $connectip$ip
	       }
	       if {$count == 2} {
		       set port_node [create_node -n "port" -l axis_switch_port2$ip -u 2 -p $ports_node -d $dts]
		       add_prop "$port_node" "reg" 2 int $dts
		       set axis_node [create_node -n "endpoint" -l axis_switch_out2$ip -p $port_node -d $dts]
		       gen_axis_port2_endpoint $ip "axis_switch_out2$ip"
		       add_prop "$axis_node" "remote-endpoint" $connectip$ip reference $dts
		       gen_axis_port2_remoteendpoint $ip $connectip$ip
	       }
	       if {$count == 3} {
		       set port_node [create_node -n "port" -l axis_switch_port3$ip -u 3 -p $ports_node -d $dts]
		       add_prop "$port_node" "reg" 3 int $dts
		       set axis_node [create_node -n "endpoint" -l axis_switch_out3$ip -p $port_node -d $dts]
		       gen_axis_port3_endpoint $ip "axis_switch_out3$ip" 
		       add_prop "$axis_node" "remote-endpoint" $connectip$ip reference $dts
		       gen_axis_port3_remoteendpoint $ip $connectip$ip
	       }
	       if {$count == 4} {
		       set port_node [create_node -n "port" -l axis_switch_port4$ip -u 4 -p $ports_node -d $dts]
		       add_prop "$port_node" "reg" 4 int $dts
		       set axis_node [create_node -n "endpoint" -l axis_switch_out4$ip -p $port_node -d $dts]
		       gen_axis_port4_endpoint $ip "axis_switch_out4$ip"
		       add_prop "$axis_node" "remote-endpoint" $connectip$ip reference $dts
		       gen_axis_port4_remoteendpoint $ip $connectip$ip
	       }
	}
}

    proc get_broad_in_ip {ip} {
        dtg_verbose "get_broad_in_ip:$ip"
        if {[llength $ip]== 0} {
            return
        }
        set master_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $ip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
        set connectip ""
        foreach intf $master_intf {
            set connect [get_connected_stream_ip [hsi::get_cells -hier $ip] $intf]
            set len [llength $connectip]
            if {$len > 1} {
                for {set i 0 } {$i < $len} {incr i} {
                    set ip [lindex $connectip $i]
                    if {[regexp -nocase "ila" $ip match]} {
                        continue
                    }
                    set connectip "$ip"
                }
            }
            foreach connectip $connect {
                if {[llength $connectip]} {
                    if {[string match -nocase [hsi get_property IP_NAME $connectip] "axis_broadcaster"]} {
                        return $connectip
                    }
                    set ip_mem_handles [hsi::get_mem_ranges $connectip]
                    if {![llength $ip_mem_handles]} {
                        set master_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
                        foreach intf $master_intf {
                            set connectip [get_connected_stream_ip [hsi::get_cells -hier $connectip] $intf]
                            foreach connect $connectip {
                                if {[string match -nocase [hsi get_property IP_NAME $connectip] "axis_broadcaster"]} {
                                    return $connectip
                                }
                            }
                        }
                        if {[llength $connectip]} {
                            set ip_mem_handles [hsi::get_mem_ranges $connectip]
                            if {![llength $ip_mem_handles]} {
                                set master2_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
                                foreach intf $master2_intf {
                                    set connectip [get_connected_stream_ip [hsi::get_cells -hier $connectip] $intf]
                                    if {[llength $connectip]} {
                                        if {[string match -nocase [hsi get_property IP_NAME $connectip] "axis_broadcaster"]} {
                                            return $connectip
                                        }
                                    }
                                }
                            }
                            if {[llength $connectip]} {
                                set ip_mem_handles [hsi::get_mem_ranges $connectip]
                                if {![llength $ip_mem_handles]} {
                                    set master3_intf [::hsi::get_intf_pins -of_objects [hsi::get_cells -hier $connectip] -filter {TYPE==SLAVE || TYPE ==TARGET}]
                                    set connectip [get_connected_stream_ip [hsi::get_cells -hier $connectip] $master3_intf]
                                }
                            }
                        }
                    }
                }
            }
        }
        return $connectip
    }
