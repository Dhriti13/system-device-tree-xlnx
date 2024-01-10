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

proc dp_txss12_generate {drv_handle} {
	set node [get_node $drv_handle]
	if {$node == 0} {
		return
	}

	dp_tx_12_add_hier_instances $drv_handle
	set dts_file [set_drv_def_dts $drv_handle]

	set vtcip [hsi get_cells -hier -filter {IP_NAME == "v_tc"}]
        if {[llength $vtcip]} {
                set baseaddr [hsi get_property CONFIG.C_BASEADDR [hsi get_cells -hier $vtcip]]
                if {[llength $baseaddr]} {
                        add_prop "${node}" "xlnx,vtc-offset" "$baseaddr" int $dts_file
                }
        }
	set freq [get_clk_pin_freq  $drv_handle "S_AXI_ACLK"]
	if {[llength $freq] == 0} {
		set freq "100000000"
		puts "WARNING: Clock frequency information is not available in the design, \
		for peripheral $drv_handle. Assuming a default frequency of 100MHz. \
		If this is incorrect, the peripheral $drv_handle will be non-functional"
	}
        add_prop "${node}" "xlnx,axi-aclk-freq-mhz" $freq hexint $dts_file 1
}



proc dp_tx_12_add_hier_instances {drv_handle} {

	set node [get_node $drv_handle]
	set dts_file [set_drv_def_dts $drv_handle]
	hsi::current_hw_instance $drv_handle

	set ip_subcores [dict create]
	dict set ip_subcores "v_dual_splitter" "dual-splitter"
	dict set ip_subcores "displayport" "dp12"
	dict set ip_subcores "hdcp" "hdcp14"

	foreach ip [dict keys $ip_subcores] {
		set ip_handle [hsi::get_cells -filter "IP_NAME==$ip"]
		set ip_prefix [dict get $ip_subcores $ip]
		if {![string_is_empty $ip_handle]} {
			add_prop "$node" "${ip_prefix}-present" 1 int $dts_file
			add_prop "$node" "${ip_prefix}-connected" $ip_handle reference $dts_file
		} else {
			add_prop "$node" "${ip_prefix}-present" 0 int $dts_file
		}
	}

	set timers [hsi::get_cells -hier -filter {IP_NAME==axi_timer}]
	#hsi::get_cells -hier -filter {IP_NAME==axi_timer}
	#processor_hier_0_axi_timer_0 dp_rx_hier_0_v_dp_rxss1_0_timer dp_tx_hier_0_v_dp_txss1_0_timer

	if {[string_is_empty $timers]} {
		add_prop "$node" "hdcptimer-present" 0 int $dts_file
	} else {
		foreach timer $timers {
			set name [hsi get_property NAME [hsi::get_cells -hier $timer]]
			if {[regexp "tx" $name match]} {
				add_prop "$node" "hdcptimer-present" 1 int $dts_file
				add_prop "$node" "hdcptimer-connected" $timer reference $dts_file
			} else {
				add_prop "$node" "hdcptimer-present" 0 int $dts_file
			}
		}
	}
	set vtcs [hsi::get_cells -hier -filter {IP_NAME==v_tc}]
	#hsi::get_cells -hier -filter {IP_NAME==axi_time_tcr}
	#dp_tx_hier_0_v_dp_txss1_0_vtc1 dp_tx_hier_0_v_dp_txss1_0_vtc2 dp_tx_hier_0_v_dp_txss1_0_vtc3 dp_tx_hier_0_v_dp_txss1_0_vtc4

	if {[string_is_empty $vtcs]} {
		add_prop "$node" "vtc1-present" 0 int $dts_file
		add_prop "$node" "vtc2-present" 0 int $dts_file
		add_prop "$node" "vtc3-present" 0 int $dts_file
		add_prop "$node" "vtc4-present" 0 int $dts_file
	} else {
		foreach vtc $vtcs {
			if {[regexp "_vtc1" $vtc match]} {
				add_prop "$node" "vtc1-present" 1 int $dts_file
				add_prop "$node" "vtc1-connected" $vtc reference $dts_file
			}
			if {[regexp "_vtc2" $vtc match]} {
				add_prop "$node" "vtc2-present" 1 int $dts_file
				add_prop "$node" "vtc2-connected" $vtc reference $dts_file
			}
			if {[regexp "_vtc3" $vtc match]} {
				add_prop "$node" "vtc3-present" 1 int $dts_file
				add_prop "$node" "vtc3-connected" $vtc reference $dts_file
			}
			if {[regexp "_vtc4" $vtc match]} {
				add_prop "$node" "vtc4-present" 1 int $dts_file
				add_prop "$node" "vtc4-connected" $vtc reference $dts_file
			}
		}
	}

	hsi::current_hw_instance

}
