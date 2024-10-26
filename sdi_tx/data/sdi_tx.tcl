#
# (C) Copyright 2020-2022 Xilinx, Inc.
# (C) Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
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
proc sdi_tx_generate {drv_handle} {
	set node [get_node $drv_handle]
	set dts_file [set_drv_def_dts $drv_handle]
	if {$node == 0} {
		return
	}

        set dtsi_file [set_drv_def_dts $drv_handle]
        set compatible [get_comp_str $drv_handle]
	set sdiline_rate [hsi get_property CONFIG.C_LINE_RATE [hsi get_cells -hier $drv_handle]]
	switch $sdiline_rate {
		"3G_SDI" {
			add_prop "${node}" "xlnx,sdiline-rate" 0 int $dts_file 1
		}
		"6G_SDI" {
			add_prop "${node}" "xlnx,sdiline-rate" 1 int $dts_file 1
		}
		"12G_SDI_8DS" {
			add_prop "${node}" "xlnx,sdiline-rate" 2 int $dts_file 1
		}
		"12G_SDI_16DS" {
			add_prop "${node}" "xlnx,sdiline-rate" 3 int $dts_file 1
		}
		default {
			add_prop "${node}" "xlnx,sdiline-rate" 4 int $dts_file 1
		}
	}
        set line_rate [hsi get_property CONFIG.C_LINE_RATE [hsi get_cells -hier $drv_handle]]
        add_prop "${node}" "xlnx,line-rate"  $line_rate string $dts_file 1
	set Isstd_352 [hsi get_property CONFIG.C_TX_INSERT_C_STR_ST352 [hsi get_cells -hier $drv_handle]]
	if {$Isstd_352 == "flase"} {
		add_prop "${node}" "xlnx,Isstd_352" 0 int $dts_file 1
	} else {
		add_prop "${node}" "xlnx,Isstd_352" 1 int $dts_file 1
	}

	set edh [hsi get_property CONFIG.C_INCLUDE_RX_EDH_PROCESSOR [hsi get_cells -hier $drv_handle]]
	if {$edh == "true"} {
		add_prop "${node}" "xlnx,include-edh" 1 int $dts_file 1
	} else {
		add_prop "${node}" "xlnx,include-edh" 0 int $dts_file 1
	}

	set ports_node [create_node -n "ports" -l sditx_ports$drv_handle -p $node -d $dts_file]
	add_prop "$ports_node" "#address-cells" 1 int $dts_file
	add_prop "$ports_node" "#size-cells" 0 int $dts_file
	set audio_connected_ip [get_connected_stream_ip [hsi get_cells -hier $drv_handle] "SDI_TX_ANC_DS_OUT"]
	if {[llength $audio_connected_ip] != 0} {
		set audio_connected_ip_type [hsi get_property IP_NAME $audio_connected_ip]
		if {[string match -nocase $audio_connected_ip_type "v_uhdsdi_audio"]} {
			set sdi_audio_port [create_node -n "port" -l sdi_audio_port -u 1 -p $ports_node -d $dts_file]
			add_prop "$sdi_audio_port" "reg" 1 int $dts_file
			set sdi_audio_node [create_node -n "endpoint" -l sdi_audio_sink_port -p $sdi_audio_port -d $dts_file]
			add_prop "$sdi_audio_node" "remote-endpoint" sditx_audio_embed_src reference $dts_file
		}
	} else {
		dtg_warning "$drv_handle:connected ip for audio port pin SDI_TX_ANC_DS_OUT is NULL"
	}
}