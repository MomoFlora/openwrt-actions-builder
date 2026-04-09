#!/bin/bash
# openwrt-actions-builder
# Copyright (C) 2026 MomoFlora
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License v2 as published
# by the Free Software Foundation.
#
# This program is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.

# 设置作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='ZeroWrt-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By MomoFlora'/g" package/base-files/files/etc/openwrt_release
sed -i "s|^OPENWRT_RELEASE=\".*\"|OPENWRT_RELEASE=\"ZeroWrt 标准版 @R$(date +%Y%m%d) BY MomoFlora\"|" package/base-files/files/usr/lib/os-release

./scripts/feeds update -a
./scripts/feeds install -a
