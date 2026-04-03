#!/bin/bash

# 移除要替换的包
rm -rf feeds/packages/lang/golang
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/{luci-app-dae,luci-app-daed,luci-app-homeproxy,luci-app-openclash,luci-app-passwall}
rm -rf feeds/packages/net/{dae,daed,xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,mosdns,microsocks,naiveproxy,open-app-filter,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}

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
git clone --depth=1 https://github.com/timsaya/openwrt-bandix package/new/bandix
git clone --depth=1 https://github.com/timsaya/luci-app-bandix package/new/luci-app-bandix
git clone --depth=1 https://github.com/sbwml/luci-app-openlist2 package/new/openlist
git clone --depth=1 -b v5 https://github.com/sbwml/luci-app-mosdns package/new/mosdns
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/new/OpenAppFilter
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/new/luci-app-lucky
git clone --depth=1 https://github.com/sbwml/luci-app-mentohust package/new/mentohust

# 主题
git clone --depth=1 https://github.com/sbwml/luci-theme-argon -b openwrt-25.12 package/new/luci-theme-argon
git clone --depth=1 https://github.com/eamonxg/luci-theme-aurora package/new/luci-theme-aurora
git clone --depth=1 https://github.com/eamonxg/luci-app-aurora-config package/new/luci-app-aurora-config
rm -rf package/new/luci-theme-aurora/root/etc/uci-defaults
sed -i 's/100/85/g' package/new/luci-app-aurora-config/root/usr/share/luci/menu.d/luci-app-aurora.json
git clone --depth=1 https://github.com/sirpdboy/luci-theme-kucat package/new/luci-theme-kucat
git clone --depth=1 https://github.com/sirpdboy/luci-app-kucat-config package/new/luci-app-kucat-config

# 科学上网插件
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki package/new/OpenWrt-nikki
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-momo package/new/OpenWrt-momo
git clone --depth=1 https://github.com/immortalwrt/homeproxy package/new/homeproxy
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall package/new/openwrt-passwall
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall2 package/new/openwrt-passwall2
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/new/openwrt-passwall-packages
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# frpc 翻译
sed -i 's,frp 服务器,Frp 服务器,g' feeds/luci/applications/luci-app-frps/po/zh_Hans/frps.po
sed -i 's,frp 客户端,Frp 客户端,g' feeds/luci/applications/luci-app-frpc/po/zh_Hans/frpc.po

