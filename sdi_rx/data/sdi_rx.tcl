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

namespace eval sdi_rx {
	proc generate {drv_handle} {
		set node [get_node $drv_handle]
		if {$node == 0} {
			return
		}
		pldt append $node compatible "\ \, \"xlnx,v-smpte-uhdsdi-rx-ss\""
	}
}
