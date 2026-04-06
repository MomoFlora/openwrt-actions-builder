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

# 通用补丁
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0001-tools-add-upx-tools.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0002-rootfs-add-upx-compression-support.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0003-rootfs-add-r-w-permissions-for-UCI-configuration-fil.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0004-build-kernel-add-out-of-tree-kernel-config.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0005-meson-add-platform-variable-to-cross-compilation-fil.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0006-tools-squashfs4-enable-lz4-zstd-compression-support.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0007-config-include-image-add-support-for-squashfs-zstd-c.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0008-include-kernel-Always-collect-module-symvers.patch
patch -p1 <$GITHUB_WORKSPACE/doc/generic-25.12/0009-include-netfilter-update-kernel-config-options-for-l.patch

# 移除要替换的包
rm -rf feeds/packages/lang/golang
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/kernel/{r8168,r8101,r8125,r8126,r8127,r8152}
rm -rf feeds/packages/utils/{docker,dockerd,containerd,runc}
rm -rf feeds/luci/applications/{luci-app-argon-config,luci-app-autoreboot,luci-app-airplay2,luci-app-dae,luci-app-daed,luci-app-dockerman,luci-app-eqos,luci-app-homeproxy,luci-app-openclash,luci-app-passwall}
rm -rf feeds/packages/net/{dae,daed,xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,mosdns,microsocks,naiveproxy,nginx,open-app-filter,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}

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
git clone --depth=1 https://github.com/sbwml/luci-app-quickfile package/new/luci-app-quickfile
git clone --depth=1 https://github.com/sbwml/luci-app-airconnect package/new/airconnect
git clone --depth=1 https://github.com/sbwml/luci-app-airplay2 package/new/luci-app-airplay2
git clone --depth=1 https://github.com/sbwml/luci-app-qbittorrent package/new/luci-app-qbittorrent
git_sparse_clone main https://github.com/sbwml/openwrt_pkgs bash-completion luci-app-autoreboot luci-app-eqos luci-app-ota luci-app-rtp2httpd luci-app-socat luci-app-wolplus otahelper rtp2httpd 

# 主题
git clone --depth=1 https://github.com/sbwml/luci-theme-argon -b openwrt-25.12 package/new/luci-theme-argon
cp -f $GITHUB_WORKSPACE/images/bg.webp package/new/luci-theme-argon/luci-theme-argon/htdocs/luci-static/argon/img/bg.webp
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
git_sparse_clone v5 https://github.com/sbwml/openwrt_helloworld dae daed luci-app-dae luci-app-daed vmlinux-btf

# Realtek 以太网驱动程序 - R8168 & R8125 & R8126 & R8152 & R8101 & r8127
git clone --depth=1 https://github.com/sbwml/package_kernel_r8168 package/kernel/r8168
git clone --depth=1 https://github.com/sbwml/package_kernel_r8152 package/kernel/r8152
git clone --depth=1 https://github.com/sbwml/package_kernel_r8101 package/kernel/r8101
git clone --depth=1 https://github.com/sbwml/package_kernel_r8125 package/kernel/r8125
git clone --depth=1 https://github.com/sbwml/package_kernel_r8126 package/kernel/r8126
git clone --depth=1 https://github.com/sbwml/package_kernel_r8127 package/kernel/r8127

# 替换 Docker
git clone --depth=1 https://github.com/sbwml/luci-app-dockerman -b openwrt-25.12 feeds/luci/applications/luci-app-dockerman
git clone --depth=1 https://github.com/sbwml/packages_utils_docker feeds/packages/utils/docker
git clone --depth=1 https://github.com/sbwml/packages_utils_dockerd feeds/packages/utils/dockerd
git clone --depth=1 https://github.com/sbwml/packages_utils_containerd feeds/packages/utils/containerd
git clone --depth=1 https://github.com/sbwml/packages_utils_runc feeds/packages/utils/runc

# 关闭 CPU 安全缓解
sed -i 's,rootwait,rootwait mitigations=off,g' target/linux/rockchip/image/default.bootscript
sed -i 's,@CMDLINE@ noinitrd,noinitrd mitigations=off,g' target/linux/x86/image/grub-efi.cfg
sed -i 's,@CMDLINE@ noinitrd,noinitrd mitigations=off,g' target/linux/x86/image/grub-iso.cfg
sed -i 's,@CMDLINE@ noinitrd,noinitrd mitigations=off,g' target/linux/x86/image/grub-pc.cfg

# 设置默认 LAN 口 IP
sed -i "s/192.168.1.1/10.0.0.1/g" package/base-files/files/bin/config_generate

# 设置默认主机名
sed -i "s/hostname='.*'/hostname='ZeroWrt'/g" package/base-files/files/bin/config_generate

# 默认 WIFI 名称
sed -i "s/\(set \${si}\.ssid='\${defaults?.ssid || \"\)[^\"]*\(\"}'\)/\1ZeroWrt\2/" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 设置默认密码
default_password=$(openssl passwd -5 password)
sed -i "s|^root:[^:]*:|root:${default_password}:|" package/base-files/files/etc/shadow

# banner
cp -f $GITHUB_WORKSPACE/doc/banner package/base-files/files/etc/banner

# key
cp -f $GITHUB_WORKSPACE/doc/key.tar.gz key.tar.gz && tar zxf key.tar.gz && rm -f key.tar.gz

# profile
sed -i 's#\\u@\\h:\\w\\\$#\\[\\e[32;1m\\][\\u@\\h\\[\\e[0m\\] \\[\\033[01;34m\\]\\W\\[\\033[00m\\]\\[\\e[32;1m\\]]\\[\\e[0m\\]\\\$#g' package/base-files/files/etc/profile
sed -ri 's/(export PATH=")[^"]*/\1%PATH%:\/opt\/bin:\/opt\/sbin:\/opt\/usr\/bin:\/opt\/usr\/sbin/' package/base-files/files/etc/profile
sed -i '/ENV/i\export TERM=xterm-color' package/base-files/files/etc/profile

# bash
sed -i 's#ash#bash#g' package/base-files/files/etc/passwd
sed -i '\#export ENV=/etc/shinit#a export HISTCONTROL=ignoredups' package/base-files/files/etc/profile
mkdir -p files/root
cp -f $GITHUB_WORKSPACE/doc/bash/.bash_profile files/root/.bash_profile
cp -f $GITHUB_WORKSPACE/doc/bash/.bashrc files/root/.bashrc

# kenrel Vermagic
sed -ie 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk
grep HASH target/linux/generic/kernel-6.12 | awk -F'HASH-' '{print $2}' | awk '{print $1}' | md5sum | awk '{print $1}' > .vermagic

# 使用 nginx 替换 uhttpd
sed -i 's/+uhttpd /+luci-nginx /g' feeds/luci/collections/luci/Makefile
sed -i 's/+uhttpd-mod-ubus //' feeds/luci/collections/luci/Makefile
sed -i 's/+uhttpd /+luci-nginx /g' feeds/luci/collections/luci-light/Makefile
sed -i "s/+luci /+luci-nginx /g" feeds/luci/collections/luci-ssl-openssl/Makefile
sed -i "s/+luci /+luci-nginx /g" feeds/luci/collections/luci-ssl/Makefile
sed -i 's/+uhttpd +uhttpd-mod-ubus /+luci-nginx /g' feeds/packages/net/wg-installer/Makefile
sed -i '/uhttpd-mod-ubus/d' feeds/luci/collections/luci-light/Makefile
sed -i 's/+luci-nginx \\$/+luci-nginx/' feeds/luci/collections/luci-light/Makefile

# libubox -O2
sed -i '/TARGET_CFLAGS/ s/$/ -O2/' package/libs/libubox/Makefile

# openssl urandom
sed -i "/-openwrt/iOPENSSL_OPTIONS += enable-ktls '-DDEVRANDOM=\"\\\\\"/dev/urandom\\\\\"\"\'\n" package/libs/openssl/Makefile

# openssl - lto
sed -i "s/ no-lto//g" package/libs/openssl/Makefile
sed -i "/TARGET_CFLAGS +=/ s/\$/ -ffat-lto-objects/" package/libs/openssl/Makefile

# TTYD
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i '3 a\\t\t"order": 50,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/procd_set_param stdout 1/procd_set_param stdout 0/g' feeds/packages/utils/ttyd/files/ttyd.init
sed -i 's/procd_set_param stderr 1/procd_set_param stderr 0/g' feeds/packages/utils/ttyd/files/ttyd.init

# nginx - latest version
git clone --depth=1 -b openwrt-25.12 https://github.com/sbwml/feeds_packages_net_nginx feeds/packages/net/nginx
sed -i 's/procd_set_param stdout 1/procd_set_param stdout 0/g;s/procd_set_param stderr 1/procd_set_param stderr 0/g' feeds/packages/net/nginx/files/nginx.init

# nginx - ubus
sed -i 's/ubus_parallel_req 2/ubus_parallel_req 6/g' feeds/packages/net/nginx/files-luci-support/60_nginx-luci-support
sed -i '/ubus_parallel_req/a\        ubus_script_timeout 300;' feeds/packages/net/nginx/files-luci-support/60_nginx-luci-support

# nginx - config
cp -f $GITHUB_WORKSPACE/doc/nginx/luci.locations feeds/packages/net/nginx/files-luci-support/luci.locations
cp -f $GITHUB_WORKSPACE/doc/nginx/uci.conf.template feeds/packages/net/nginx-util/files/uci.conf.template

# frpc 翻译
sed -i 's,frp 服务器,Frp 服务器,g' feeds/luci/applications/luci-app-frps/po/zh_Hans/frps.po
sed -i 's,frp 客户端,Frp 客户端,g' feeds/luci/applications/luci-app-frpc/po/zh_Hans/frpc.po

# nlbwmon
sed -i 's/services/network/g' feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json
sed -i 's/services/network/g' feeds/luci/applications/luci-app-nlbwmon/htdocs/luci-static/resources/view/nlbw/config.js

# 版本号
sed -i 's/VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),ImmortalWrt)/VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),ZeroWrt)/g' include/version.mk
sed -i 's/VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),ImmortalWrt)/VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),ZeroWrt)/g' include/version.mk

# uwsgi - 修复超时问题
sed -i '$a cgi-timeout = 600' feeds/packages/net/uwsgi/files-luci-support/luci-*.ini
sed -i '/limit-as/c\limit-as = 5000' feeds/packages/net/uwsgi/files-luci-support/luci-webui.ini
# 关闭错误日志
sed -i "s/procd_set_param stderr 1/procd_set_param stderr 0/g" feeds/packages/net/uwsgi/files/uwsgi.init

# uwsgi - performance
sed -i 's/threads = 1/threads = 2/g' feeds/packages/net/uwsgi/files-luci-support/luci-webui.ini
sed -i 's/processes = 3/processes = 4/g' feeds/packages/net/uwsgi/files-luci-support/luci-webui.ini
sed -i 's/cheaper = 1/cheaper = 2/g' feeds/packages/net/uwsgi/files-luci-support/luci-webui.ini

# rpcd - 修复超时问题
sed -i 's/option timeout 30/option timeout 60/g' package/system/rpcd/files/rpcd.config
sed -i 's#20) \* 1000#60) \* 1000#g' feeds/luci/modules/luci-base/htdocs/luci-static/resources/rpc.js

# luci-mod 额外
pushd feeds/luci
patch -p1 <$GITHUB_WORKSPACE/doc/luci/0001-luci-mod-system-add-modal-overlay-dialog-to-reboot.patch
patch -p1 <$GITHUB_WORKSPACE/doc/luci/0002-luci-mod-status-displays-actual-process-memory-usage.patch
patch -p1 <$GITHUB_WORKSPACE/doc/luci/0003-luci-mod-status-storage-index-applicable-only-to-val.patch
patch -p1 <$GITHUB_WORKSPACE/doc/luci/0004-luci-mod-status-firewall-disable-legacy-firewall-rul.patch
patch -p1 <$GITHUB_WORKSPACE/doc/luci/0005-luci-mod-system-add-refresh-interval-setting.patch
patch -p1 <$GITHUB_WORKSPACE/doc/luci/0006-luci-mod-system-mounts-add-docker-directory-mount-po.patch
patch -p1 <$GITHUB_WORKSPACE/doc/luci/0007-luci-mod-system-add-ucitrack-luci-mod-system-zram.js.patch
popd

# LRNG
cp -f $GITHUB_WORKSPACE/doc/lrng/* target/linux/generic/hack-6.12

# BBRv3
cp -f $GITHUB_WORKSPACE/doc/bbr3/* target/linux/generic/backport-6.12

# BTF
cp -f $GITHUB_WORKSPACE/doc/btf/* target/linux/generic/hack-6.12

# 增加汉化
cat << 'EOF' >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

msgid "Confirm Reboot"
msgstr "确认重启"

msgid "Are you sure you want to reboot the system?"
msgstr "你确认要重启系统？"

msgid "Confirm"
msgstr "确认"

msgid "Use as docker root directory (/opt)"
msgstr "作为 docker 根目录使用（/opt）"

msgid "NFtables Firewall"
msgstr "NFtables 防火墙"

msgid "IPtables Firewall"
msgstr "IPtables 防火墙"

EOF

# 加入网卡驱动（ngbe / txgbe）
cat << 'EOF' >> package/kernel/linux/modules/netdevices.mk


define KernelPackage/ngbe
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=Wangxun(R) GbE PCI Express adapters support
  DEPENDS:=@PCI_SUPPORT +kmod-libwx kmod-mdio-devres
  KCONFIG:=CONFIG_NGBE
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/wangxun/ngbe/ngbe.ko
  AUTOLOAD:=$(call AutoProbe,ngbe)
endef

define KernelPackage/ngbe/description
 Kernel modules for Wangxun(R) GbE PCI Ethernet chipsets
endef

$(eval $(call KernelPackage,ngbe))


define KernelPackage/txgbe
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=Wangxun(R) 10GbE PCI Express adapters support
  DEPENDS:=@PCI_SUPPORT +kmod-libwx +kmod-pcs-xpcs +kmod-regmap-core
  KCONFIG:=CONFIG_TXGBE
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/wangxun/txgbe/txgbe.ko
  AUTOLOAD:=$(call AutoProbe,txgbe)
endef

define KernelPackage/txgbe/description
 Kernel modules for Wangxun(R) 10GbE PCI Ethernet chipsets
endef

$(eval $(call KernelPackage,txgbe))

EOF

# 支持网卡驱动（lib-parman / libwx / libie-fwlog / libie-adminq）
cat << 'EOF' >> package/kernel/linux/modules/lib.mk


define KernelPackage/libwx
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=Wangxun(R) Ethernet driver common library
  DEPENDS:=@PCI_SUPPORT +kmod-phylink +kmod-ptp
  KCONFIG:=CONFIG_LIBWX
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/wangxun/libwx/libwx.ko
  AUTOLOAD:=$(call AutoProbe,libwx)
endef

define KernelPackage/libwx/description
 Common library for Wangxun(R) Ethernet drivers
endef

$(eval $(call KernelPackage,libwx))


define KernelPackage/libie-fwlog
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=LIBIE_FWLOG
  KCONFIG:=CONFIG_LIBIE_FWLOG
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/intel/libie/libie_fwlog.ko
  AUTOLOAD:=$(call AutoLoad,15,libie_fwlog,1)
endef

$(eval $(call KernelPackage,libie-fwlog))


define KernelPackage/libie-adminq
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=LIBIE_ADMINQ
  KCONFIG:=CONFIG_LIBIE_ADMINQ
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/intel/libie/libie_adminq.ko
  AUTOLOAD:=$(call AutoLoad,15,libie_adminq,1)
endef

$(eval $(call KernelPackage,libie-adminq))

EOF

# 设置作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='ZeroWrt-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By MomoFlora'/g" package/base-files/files/etc/openwrt_release
sed -i "s|^OPENWRT_RELEASE=\".*\"|OPENWRT_RELEASE=\"ZeroWrt 标准版 @R$(date +%Y%m%d) BY MomoFlora\"|" package/base-files/files/usr/lib/os-release
