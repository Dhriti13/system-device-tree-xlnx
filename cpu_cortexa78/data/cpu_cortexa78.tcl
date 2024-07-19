#
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

proc cpu_cortexa78_generate {drv_handle} {
	global dtsi_fname
	global is_versal_net_platform
	global is_versal_gen2_platform
	global platform_filename ""
	if { $is_versal_net_platform } {
		if {$is_versal_gen2_platform} {
			set platform_filename "versal2"
			update_system_dts_include [file tail "${platform_filename}-scmi.dtsi"]
		} else {
			set platform_filename "versal-net"
			update_system_dts_include [file tail "${platform_filename}-clk-ccf.dtsi"]
		}
		set dtsi_fname "${platform_filename}/${platform_filename}.dtsi"
		update_system_dts_include [file tail ${dtsi_fname}]
	}
	if {[string_is_empty $platform_filename]} {
		error "Invalid board family for A78. Only Versal-Net and Versal-Gen2 are supported."
	}

	set bus_name "amba"
	set fields [split [get_ip_property $drv_handle NAME] "_"]
	set cpu_nr [lindex $fields end]
	set cpu_node [create_node -n "&psx_cortexa78_${cpu_nr}" -d "pcw.dtsi" -p root -h $drv_handle]
	set ip_name [get_ip_property $drv_handle IP_NAME]
	add_prop $cpu_node "xlnx,ip-name" $ip_name string "pcw.dtsi"
	add_prop $cpu_node "bus-handle" $bus_name reference "pcw.dtsi"
	add_prop $cpu_node "cpu-frequency" [hsi get_property CONFIG.C_CPU_CLK_FREQ_HZ $drv_handle] int "pcw.dtsi"
	add_prop $cpu_node "stamp-frequency" [hsi get_property CONFIG.C_TIMESTAMP_CLK_FREQ $drv_handle] int "pcw.dtsi"
	gen_drv_prop_from_ip $drv_handle
	gen_pss_ref_clk_freq $drv_handle $cpu_node $ip_name
	set amba_node [create_node -n "&${bus_name}" -d "pcw.dtsi" -p root]
}
