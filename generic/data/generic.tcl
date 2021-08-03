#
# (C) Copyright 2014-2021 Xilinx, Inc.
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

proc generate {drv_handle} {
	set hsi_version [get_hsi_version]
	set ver [split $hsi_version "."]
	set value [lindex $ver 0]
	set dts_file [set_drv_def_dts $drv_handle]
	if {$value >= 2018} {
		set generic_node [get_node $drv_handle]
	}
}
