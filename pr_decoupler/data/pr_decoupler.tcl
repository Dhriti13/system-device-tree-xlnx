#
# (C) Copyright 2017-2022 Xilinx, Inc.
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

proc pr_decoupler_generate {drv_handle} {
        set node [gen_peripheral_nodes $drv_handle]
        if {$node == 0} {
            return
        }
        pldt append $node compatible "\ \, \"xlnx,pr-decoupler\""
}