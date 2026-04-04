#!/bin/bash

# 移除要替换的包
rm -rf feeds/packages/lang/golang
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/kernel/{r8168,r8101,r8125,r8126,r8127}
rm -rf feeds/packages/utils/{docker,dockerd,containerd,runc}
rm -rf feeds/luci/applications/{luci-app-dae,luci-app-daed,luci-app-dockerman,luci-app-homeproxy,luci-app-openclash,luci-app-passwall}
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

# Realtek 以太网驱动程序 - R8168 & R8125 & R8126 & R8152 & R8101 & r8127
git clone --depth=1 https://github.com/sbwml/package_kernel_r8168 package/kernel/r8168
git clone --depth=1 https://github.com/sbwml/package_kernel_r8152 package/kernel/r8152
git clone --depth=1 https://github.com/sbwml/package_kernel_r8101 package/kernel/r8101
git clone --depth=1 https://github.com/sbwml/package_kernel_r8125 package/kernel/r8125
git clone --depth=1 https://github.com/sbwml/package_kernel_r8126 package/kernel/r8126
git clone --depth=1 https://github.com/sbwml/package_kernel_r8127 package/kernel/r8127
# Realtek 无线驱动程序 - RTL8822CS & RTL8852AU
git clone --depth=1 https://github.com/sbwml/package_kernel_rtl8822cs package/kernel/rtl8822cs
git clone --depth=1 https://github.com/sbwml/package_kernel_rtl8852au package/kernel/rtl8852au

# 替换 Docker
git clone --depth=1 https://github.com/sbwml/luci-app-dockerman -b openwrt-25.12 feeds/luci/applications/luci-app-dockerman
git clone --depth=1 https://github.com/sbwml/packages_utils_docker feeds/packages/utils/docker
git clone --depth=1 https://github.com/sbwml/packages_utils_dockerd feeds/packages/utils/dockerd
git clone --depth=1 https://github.com/sbwml/packages_utils_containerd feeds/packages/utils/containerd
git clone --depth=1 https://github.com/sbwml/packages_utils_runc feeds/packages/utils/runc

# frpc 翻译
sed -i 's,frp 服务器,Frp 服务器,g' feeds/luci/applications/luci-app-frps/po/zh_Hans/frps.po
sed -i 's,frp 客户端,Frp 客户端,g' feeds/luci/applications/luci-app-frpc/po/zh_Hans/frpc.po

# 版本号
sed -i 's/VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),ImmortalWrt)/VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),ZeroWrt)/g' include/version.mk
sed -i 's/VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),ImmortalWrt)/VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),ZeroWrt)/g' include/version.mk

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
