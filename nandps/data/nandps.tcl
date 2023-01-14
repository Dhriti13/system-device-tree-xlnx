    proc nandps_ns_to_cycle {drv_handle prop_name nand_cycle_time} {
        return [expr [hsi get_property CONFIG.$prop_name [hsi::get_cells -hier $drv_handle]]/${nand_cycle_time}]
    }

    proc nandps_generate {drv_handle} {
        set node [get_node $drv_handle]
        set dts_file [set_drv_def_dts $drv_handle]
        set hw_ver [get_hw_version]
        # Parameter name changed in 2014.4
        # TODO: check with 2014.3
        switch -exact $hw_ver {
        "2014.2" {
             set nand_par_prefix "C_NAND_CYCLE_"
             set nand_cycle_time 1
        } "2014.4" -
        default {
            set nand_par_prefix "NAND-CYCLE-"
            set nand_cycle_time [expr "1000000000/[hsi get_property CONFIG.C_NAND_CLK_FREQ_HZ [hsi::get_cells -hier $drv_handle]]"]
        }
        }
        if {![regexp -nocase "psu_nand*" $drv_handle match]} {
            set_drv_prop $drv_handle "arm,nand-cycle-t0" [nandps_ns_to_cycle $drv_handle "${nand_par_prefix}T0" $nand_cycle_time] $node
            set_drv_prop $drv_handle "arm,nand-cycle-t1" [nandps_ns_to_cycle $drv_handle "${nand_par_prefix}T1" $nand_cycle_time] $node
            set_drv_prop $drv_handle "arm,nand-cycle-t2" [nandps_ns_to_cycle $drv_handle "${nand_par_prefix}T2" $nand_cycle_time] $node
            set_drv_prop $drv_handle "arm,nand-cycle-t3" [nandps_ns_to_cycle $drv_handle "${nand_par_prefix}T3" $nand_cycle_time] $node
            set_drv_prop $drv_handle "arm,nand-cycle-t4" [nandps_ns_to_cycle $drv_handle "${nand_par_prefix}T4" $nand_cycle_time] $node
            set_drv_prop $drv_handle "arm,nand-cycle-t5" [nandps_ns_to_cycle $drv_handle "${nand_par_prefix}T5" $nand_cycle_time] $node
            set_drv_prop $drv_handle "arm,nand-cycle-t6" [nandps_ns_to_cycle $drv_handle "${nand_par_prefix}T6" $nand_cycle_time] $node
            set bus_width [hsi get_property CONFIG.C_NAND_WIDTH [hsi::get_cells -hier $drv_handle]]
            add_prop $node "nand-bus-width" int $bus_width $dts_file
        }
    }


