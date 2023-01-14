    proc axi_xadc_generate {drv_handle} {
        axi_xadc_gen_xadc_driver_prop $drv_handle
    }

    proc axi_xadc_gen_xadc_driver_prop {drv_handle} {
        set node [get_node $drv_handle]
        set dts_file [set_drv_def_dts $drv_handle]
        gen_drv_prop_from_ip $drv_handle
        gen_dev_ccf_binding $drv_handle "s_axi_aclk"

        pldt append $node compatible "\ \, \"xlnx,axi-xadc-1.00.a\""
        set adc_ip [hsi::get_cells -hier $drv_handle]
        set has_dma [hsi get_property CONFIG.C_HAS_EXTERNAL_MUX $adc_ip]
        if {$has_dma == 0} {
                set has_dma_str "none"
        } elseif {$has_dma == 1} {
                set has_dma_str "single"
        }
        add_prop $node "xlnx,external-mux" $has_dma_str string $dts_file
        if {$has_dma != 0} {
                set ext_mux_chan [hsi get_property CONFIG.EXTERNAL_MUX_CHANNEL $adc_ip]
                if {[string match -nocase $ext_mux_chan "VP_VN"] } {
                        set chan_nr 0
                } else {
                        for {set i 0} { $i < 16 } { incr i} {
                                if {[string match -nocase $ext_mux_chan "VAUXP${i}_VAUXN${i}"]} {
                                        set chan_nr [expr $i + 1]
                                }
                        }
                }
                add_prop $node "xlnx,external-mux-channel" $chan_nr int $dts_file
        }
    }


