#!/bin/sh

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/design'
uci commit luci

exit 0
