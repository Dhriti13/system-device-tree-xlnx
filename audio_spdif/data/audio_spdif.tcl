#
# (C) Copyright 2018 Xilinx, Inc.
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
namespace eval audio_spdif {
	proc generate {drv_handle} {
		global env
		global dtsi_fname
		set path $env(REPO)

		set node [get_node $drv_handle]
		if {$node == 0} {
			return
		}
		set node [get_node $drv_handle]
		if {$node == 0} {
			return
		}
		pldt append compatible $node compatible "\ \, \"xlnx,spdif-2.0\""
		
		set spdif_mode [get_property CONFIG.SPDIF_Mode [get_cells -hier $drv_handle]]
		add_prop $node "xlnx,spdif-mode" $spdif_mode int "pl.dtsi"
		set cstatus_reg [get_property CONFIG.CSTATUS_REG [get_cells -hier $drv_handle]]
		add_prop $node "xlnx,chstatus-reg" $cstatus_reg int "pl.dtsi"
		set userdata_reg [get_property CONFIG.USERDATA_REG [get_cells -hier $drv_handle]]
		add_prop $node "xlnx,userdata-reg" $userdata_reg int "pl.dtsi"
		set axi_buffer_size [get_property CONFIG.AXI_BUFFER_Size [get_cells -hier $drv_handle]]
		add_prop $node "xlnx,fifo-depth" $axi_buffer_size int "pl.dtsi"
		set clk_freq [get_clock_frequency [get_cells -hier $drv_handle] "aud_clk_i"]
		if {[llength $clk_freq] != 0} {
			add_prop $node "${node}" "clock-frequency" $clk_freq int "pl.dtsi"
		}
	}
}
