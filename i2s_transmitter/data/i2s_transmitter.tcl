    proc i2s_transmitter_generate {drv_handle} {
        set node [get_node $drv_handle]
        set dts_file [set_drv_def_dts $drv_handle]
        if {$node == 0} {
                return
        }
        pldt append $node compatible "\ \, \"xlnx,i2s-transmitter-1.0\""
        set dwidth [hsi get_property CONFIG.C_DWIDTH [hsi::get_cells -hier $drv_handle]]
        add_prop "$node" "xlnx,dwidth" $dwidth hexint $dts_file 1
        set num_channels [hsi get_property CONFIG.C_NUM_CHANNELS [hsi::get_cells -hier $drv_handle]]
        add_prop "$node" "xlnx,num-channels" $num_channels hexint $dts_file 1
        set depth [hsi get_property CONFIG.C_DEPTH [hsi::get_cells -hier $drv_handle]]
        add_prop "$node" "xlnx,depth" $depth hexint $dts_file 1
        set ip [hsi::get_cells -hier $drv_handle]
        set freq ""
        set clk [hsi::get_pins -of_objects $ip "aud_mclk"]
        if {[llength $clk] } {
                set freq [hsi get_property CLK_FREQ $clk]
                add_prop $node "aud_mclk" "$freq" int $dts_file
        }
        set connect_ip [get_connected_stream_ip [hsi::get_cells -hier $drv_handle] "S_AXIS_AUD"]
        if {![llength $connect_ip]} {
                dtg_warning "$drv_handle pin S_AXIS_AUD is not connected... check your design"
        }
        if {[llength $connect_ip]} {
                set connect_ip_type [hsi get_property IP_NAME $connect_ip]
                if {[string match -nocase $connect_ip_type "axis_switch"]} {
                        set connected_ip [get_connected_stream_ip $connect_ip "S00_AXIS"]
                        if {![llength $connected_ip]} {
                                dtg_warning "$connect_ip pin S00_AXIS is not connected... check your design"
                        }
                        if {[llength $connected_ip] != 0} {
                                add_prop "$node" "xlnx,snd-pcm" $connected_ip reference $dts_file
                        }
                } elseif {[string match -nocase $connect_ip_type "audio_formatter"]} {
                        add_prop "$node" "xlnx,snd-pcm" $connect_ip reference $dts_file 1
                }
        }
        set dwidth [hsi get_property CONFIG.C_DWIDTH [hsi::get_cells -hier $drv_handle]]
        if {[llength $dwidth]} {
                add_prop "$node" "xlnx,dwidth" $dwidth hexint $dts_file 1
        }
        set num_channels [hsi get_property CONFIG.C_NUM_CHANNELS [hsi::get_cells -hier $drv_handle]]
        if {[llength $num_channels]} {
                add_prop "$node" "xlnx,num-channels" $num_channels hexint $dts_file 1
        }
        set depth [hsi get_property CONFIG.C_DEPTH [hsi::get_cells -hier $drv_handle]]
        if {[llength $depth]} {
                add_prop "$node" "xlnx,depth" $depth hexint $dts_file 1
        }
    }


