#!/bin/bash

. /etc/os-release
. /lib/functions/uci-defaults.sh

[ $(uname -m) = "x86_64" ] && alias board_name="echo x86_64"
[ "$OPENWRT_BOARD" = "armsr/armv8" ] && alias board_name="echo armsr,armv8"

# OTA
OTA_URL="https://api.kejizero.xyz/ota/openwrt-25.12.json"

kernel_version=$(uname -r | sed 's/-.*//' | cut -d. -f1-2)

devices_setup()
{
    case "$(board_name)" in
    ariaboard,photonicat|\
    ariaboard,photonicat2|\
    armsom,sige3|\
    armsom,sige7|\
    friendlyarm,nanopc-t6|\
    friendlyarm,nanopi-r2c|\
    friendlyarm,nanopi-r2c-plus|\
    friendlyarm,nanopi-r2s|\
    friendlyarm,nanopi-r3s|\
    friendlyarm,nanopi-r4s|\
    friendlyarm,nanopi-r4se|\
    friendlyarm,nanopi-r5c|\
    friendlyarm,nanopi-r5s|\
    friendlyarm,nanopi-r6c|\
    friendlyarm,nanopi-r6s|\
    friendlyarm,nanopi-r76s|\
    huake,guangmiao-g4c|\
    linkease,easepi-r1|\
    lunzn,fastrhino-r66s|\
    lunzn,fastrhino-r68s)
        uci set irqbalance.irqbalance.enabled='0'
        uci commit irqbalance
        service irqbalance stop
        if [ "$kernel_version" = "6.12" ]; then
            [ ! -d "/usr/share/openwrt_core" ] && {
                sed -i '/targets/d' /etc/apk/repositories.d/distfeeds.list
                echo "https://raw.githubusercontent.com/MomoFlora/openwrt_core/aarch64_generic/$(grep kernel /etc/apk/world | awk -F= '{print $2}')/packages.adb" >> /etc/apk/repositories.d/distfeeds.list
            }
            uci set ota.config.api_url="$OTA_URL"
            uci commit ota
        fi
        ;;
    x86_64)
        if [ "$kernel_version" = "6.12" ]; then
            [ ! -d "/usr/share/openwrt_core" ] && {
                sed -i '/targets/d' /etc/apk/repositories.d/distfeeds.list
                echo "https://raw.githubusercontent.com/MomoFlora/openwrt_core/x86_64/$(grep kernel /etc/apk/world | awk -F= '{print $2}')/packages.adb" >> /etc/apk/repositories.d/distfeeds.list
            }
        fi
        uci set ota.config.api_url="$OTA_URL"
        uci commit ota
        ;;
    esac
}

# theme
if [ -d "/www/luci-static/argon" ] && [ -z "$(uci -q get luci.main.pollinterval)" ]; then
    uci set luci.main.mediaurlbase='/luci-static/argon'
    uci set luci.main.pollinterval='3'
    uci commit luci
fi

# timezone
uci set system.@system[0].timezone=CST-8
uci set system.@system[0].zonename=Asia/Shanghai
uci commit system

# log level
uci set system.@system[0].conloglevel='1'
uci set system.@system[0].cronloglevel='9'
uci commit system

# zram
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
zram_size=$(awk "BEGIN {print int($mem_total*0.25/1024)}")
uci set system.@system[0].zram_size_mb="$zram_size"
uci set system.@system[0].zram_comp_algo='lz4'
uci commit system

# apk mirror
distfeeds=/etc/apk/repositories.d/distfeeds.list
if [ $(grep -c SNAPSHOT "$distfeeds") -eq '0' ]; then
  sed -i 's,downloads.openwrt.org,mirrors.cloud.tencent.com/openwrt,g' "$distfeeds"
else
  sed -i 's,downloads.openwrt.org,mirror.sjtu.edu.cn/openwrt,g' "$distfeeds"
fi

# nginx
uci set nginx.global.uci_enable='true'
uci del nginx._lan
uci del nginx._redirect2ssl
uci add nginx server
uci rename nginx.@server[0]='_lan'
uci set nginx._lan.server_name='_lan'
uci add_list nginx._lan.listen='80 default_server'
uci add_list nginx._lan.listen='[::]:80 default_server'
#uci add_list nginx._lan.include='restrict_locally'
uci add_list nginx._lan.include='conf.d/*.locations'
uci set nginx._lan.access_log='off; # logd openwrt'
uci commit nginx
service nginx restart

# docker mirror
if [ -f /etc/config/dockerd ] && [ $(grep -c daocloud.io /etc/config/dockerd) -eq '0' ]; then
    uci add_list dockerd.globals.registry_mirrors="https://docker.m.daocloud.io"
    uci commit dockerd
fi

# firewall
[ $(grep -c shortcut_fe /etc/config/firewall) -eq '0' ] && uci set firewall.@defaults[0].flow_offloading='1'
uci set firewall.@defaults[0].input='ACCEPT'
uci commit firewall

# diagnostics
if [ $(uci -q get luci.diag.ping) = "openwrt.org" ]; then
    uci set luci.diag.dns='www.qq.com'
    uci set luci.diag.ping='www.qq.com'
    uci set luci.diag.route='www.qq.com'
    uci commit luci
fi

# disable coremark
sed -i '/coremark/d' /etc/crontabs/root
crontab /etc/crontabs/root

exit 0
