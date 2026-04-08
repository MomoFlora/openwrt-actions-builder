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

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/luci/bin/config_generate

# 修改主机名
sed -i 's/LEDE/ZeroWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/ZeroWrt/g' package/base-files/luci/bin/config_generate

# 修改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci-nginx/Makefile

# 更改默认 Shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 移除要替换的包
rm -rf feeds/packages/lang/golang
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/packages/net/{open-app-filter,mosdns,lucky}
rm -rf feeds/luci/applications/{luci-app-argon-config,luci-app-mosdns,luci-app-lucky}

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package/new
  cd .. && rm -rf $repodir
}

# 更新 Go 1.26
git clone --depth=1 -b 26.x https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# 添加额外插件
git clone --depth=1 https://github.com/MomoFlora/luci-app-adguardhome package/new/luci-app-adguardhome
git clone --depth=1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/new/luci-app-wechatpush
git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/new/luci-app-ikoolproxy
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/new/luci-app-poweroff
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/new/OpenAppFilter
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/new/luci-app-netdata
git clone --depth=1 -b v5-lua https://github.com/sbwml/luci-app-mosdns package/new/luci-app-mosdns
git clone --depth=1 https://github.com/MomoFlora/luci-app-lucky package/new/luci-app-lucky
git clone --depth=1 https://github.com/FUjr/QModem package/new/QModem
git_sparse_clone main https://github.com/Lienol/openwrt-package luci-app-filebrowser luci-app-ssr-mudb-server
git_sparse_clone openwrt-18.06 https://github.com/immortalwrt/luci applications/luci-app-eqos

# 科学上网插件
git clone --depth=1 -b master https://github.com/fw876/helloworld package/new/luci-app-ssr-plus
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/new/openwrt-passwall
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall package/new/luci-app-passwall
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall2 package/new/luci-app-passwall2
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# 主题
git clone --depth=1 -b 18.06 https://github.com/kiddin9/luci-theme-edge package/new/luci-theme-edge
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/new/luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config package/new/luci-app-argon-config
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/new/luci-theme-infinityfreedom
git_sparse_clone main https://github.com/haiibo/packages luci-theme-atmaterial luci-theme-opentomcat luci-theme-netgear

# 在线用户
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/General/bg1.jpg package/new/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 获取编译日期
date_version=$(date +"%y.%m.%d")

# 文件路径
zzz_file="package/lean/default-settings/files/zzz-default-settings"

# 原来的 DISTRIB_REVISION
orig_version=$(grep "DISTRIB_REVISION=" "$zzz_file" | awk -F"'" '{print $2}')

# 替换 DISTRIB_REVISION 为 ZeroWrt 和编译日期
sed -i "s/${orig_version}/R${date_version} by MomoFlora/g" "$zzz_file"

# 替换 DISTRIB_DESCRIPTION 中的 LEDE 为 ZeroWrt
sed -i "s/LEDE/ZeroWrt/g" "$zzz_file"

./scripts/feeds update -a
./scripts/feeds install -a
