<h1 align="center">✨ ZeroWrt 固件仓库 ✨</h1>

<p align="center">
  基于 <strong>ImmortalWrt</strong> 源码编译，适用于 <strong>Qualcommax</strong>、<strong>X86_64</strong>、<strong>Rockchip</strong>、<strong>Amlogic-S9xxx</strong> 平台。<br>
  <strong style="color:red; font-size:16px;">⚠ 仅限个人自用，严禁商业使用。</strong>
</p>

<!-- 技能图标 -->
<p align="center">
  <a href="https://skillicons.dev#gh-light-mode-only" target="_blank">
    <img align="center" src="https://skillicons.dev/icons?theme=light&perline=16&i=linux,c,cpp,bash,git,github,vim,lua,cmake,regex,nginx,docker,kubernetes,prometheus,grafana,md" alt="OpenWrt Skills" />
  </a>
  <a href="https://skillicons.dev#gh-dark-mode-only" target="_blank">
    <img align="center" src="https://skillicons.dev/icons?perline=16&i=linux,c,cpp,bash,git,github,vim,lua,cmake,regex,nginx,docker,kubernetes,prometheus,grafana,md" alt="OpenWrt Skills" />
  </a>
</p>

<p align="center">
  <img src="./images/zerowrt.png" alt="ZeroWrt" width="1000"/>
</p>

---

## 📱 支持的设备列表

本固件基于 **ImmortalWrt** 源码编译，致力于为多种硬件平台提供稳定、高效的开源路由器系统体验，覆盖从嵌入式盒子到软路由设备的广泛应用场景。

| 平台类别              | 平台代号 / 架构                    | 主要特点 / 适用场景                                      | 典型设备示例                          |
|-----------------------|-----------------------------------|-------------------------------------------------------|---------------------------------------|
| **x86_64**            | x86_64 (AMD64)                    | 性能强劲，适合软路由、虚拟机、服务器，扩展性极佳，支持 Docker、KVM 等           | 软路由整机、工控机、VMware、Proxmox、VirtualBox |
| **Rockchip**          | ARMv8 (Cortex‑A53/A72/A76 等)      | 低功耗高性能，适合 ARM 盒子 / 开发板，性价比高，主流 NPU 支持                  | FriendlyARM NanoPi R2S/R4S/R5C/R6C/R6S，Orange Pi 系列等 |
| **Qualcommax**        | ARMv7 / ARMv8 (IPQ60xx/IPQ80xx 等) | 原生支持 NSS 硬件加速，转发性能强悍，适合 Wi‑Fi 6/7 硬路由，高通系专用        | 京东云无线宝（雅典娜/亚瑟/百里等）、GL.iNet、小米 AX9000 等 |
| **Amlogic-S9xxx**     | ARMv8 (Cortex‑A53/A55/A73)         | 电视盒子刷机首选，多媒体性能强，适合一体化家用路由 & 轻 NAS & 影音服务器         | 晶晨 S905X3/S912/S922X 系列盒子（如 HK1、X96、Beelink） |

### 📋 典型功能

| 功能 | 说明 |
|------|------|
| 💻 驱动支持 | 支持 X86、Rockchip 平台，内置常用有线 / 无线 / 3G / 4G 网卡驱动，支持 Kmod 扩展 |
| 💾 轻量稳定 | 精简内核配置，优化存储与日志，提升系统稳定性并延长闪存寿命 |
| ⚡ NSS 硬件加速 | Qualcommax 平台支持，大幅降低 CPU 占用，提升小包转发性能 |
| 🐳 Docker 支持 | X86、Rockchip 平台集成 Docker 服务，可在 OpenWrt 内自由部署容器应用 |
| 🧩 软件生态 | 全平台软件包支持，预置 LuCI、Flow Offload、UPnP、SmartDNS、OpenClash、PassWall 等插件 |
| 📊 流量监控 | 集成新版 Bandix 流量监控插件，小白也能轻松查看流量状态 |
| 🔄 在线更新 | X86、Rockchip 平台支持固件在线更新，方便一键升级系统 |
| 🔄 自动构建 | 跟随 ImmortalWrt 上游更新，定期发布稳定版与快照版 |

> ⚠️ 说明：本固件为个人自用编译分享，**不包含任何商业用途授权**。不同平台固件之间互不通用，请根据设备 SoC 架构选择对应镜像。刷机前请务必了解恢复方法和原厂备份，部分 Amlogic 盒子需要先写入专用引导。

---

## 📥 固件下载
点击下表中 [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?style=flat&logo=hack-the-box)](https://github.com/haiibo/OpenWrt/releases) 即可跳转到该设备固件下载页面
| 平台+设备名称 | 固件编译状态 | 配置文件 | 固件下载 |
| :-------------: | :-------------: | :-------------: | :-------------: |
| [![](https://img.shields.io/badge/OpenWrt-X86_64位-32C955.svg?logo=openwrt)](https://github.com/haiibo/OpenWrt/blob/main/.github/workflows/X86_64-OpenWrt.yml) | [![](https://github.com/haiibo/OpenWrt/actions/workflows/X86_64-OpenWrt.yml/badge.svg)](https://github.com/haiibo/OpenWrt/actions/workflows/X86_64-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/haiibo/OpenWrt/blob/main/configs/x86_64.config) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/haiibo/OpenWrt/releases/tag/X86_64) |
| [![](https://img.shields.io/badge/OpenWrt-ARMv8_Mini-32C955.svg?logo=openwrt)](https://github.com/haiibo/OpenWrt/blob/main/.github/workflows/ARMv8-Mini-OpenWrt.yml) | [![](https://github.com/haiibo/OpenWrt/actions/workflows/ARMv8-Mini-OpenWrt.yml/badge.svg)](https://github.com/haiibo/OpenWrt/actions/workflows/ARMv8-Mini-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/haiibo/OpenWrt/blob/main/configs/armv8-mini.config) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/haiibo/OpenWrt/releases/tag/ARMv8_MINI) |
| [![](https://img.shields.io/badge/OpenWrt-ARMv8_Plus-32C955.svg?logo=openwrt)](https://github.com/haiibo/OpenWrt/blob/main/.github/workflows/ARMv8-Plus-OpenWrt.yml) | [![](https://github.com/haiibo/OpenWrt/actions/workflows/ARMv8-Plus-OpenWrt.yml/badge.svg)](https://github.com/haiibo/OpenWrt/actions/workflows/ARMv8-Plus-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/haiibo/OpenWrt/blob/main/configs/armv8-plus.config) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/haiibo/OpenWrt/releases/tag/ARMv8_PLUS) |
| [![](https://img.shields.io/badge/OpenWrt-Rockchip_平台-32C955.svg?logo=openwrt)](https://github.com/haiibo/OpenWrt/blob/main/.github/workflows/Rockchip-OpenWrt.yml) | [![](https://github.com/haiibo/OpenWrt/actions/workflows/Rockchip-OpenWrt.yml/badge.svg)](https://github.com/haiibo/OpenWrt/actions/workflows/Rockchip-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/haiibo/OpenWrt/blob/main/configs/rockchip.config) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/haiibo/OpenWrt/releases/tag/Rockchip) |
| [![](https://img.shields.io/badge/OpenWrt-树莓派_4B-32C955.svg?logo=openwrt)](https://github.com/haiibo/OpenWrt/blob/main/.github/workflows/RaspberryPi4-OpenWrt.yml) | [![](https://github.com/haiibo/OpenWrt/actions/workflows/RaspberryPi4-OpenWrt.yml/badge.svg)](https://github.com/haiibo/OpenWrt/actions/workflows/RaspberryPi4-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/haiibo/OpenWrt/blob/main/configs/rpi4.config) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/haiibo/OpenWrt/releases/tag/RaspberryPi4) |
| [![](https://img.shields.io/badge/OpenWrt-树莓派_3B/3B+-32C955.svg?logo=openwrt)](https://github.com/haiibo/OpenWrt/blob/main/.github/workflows/RaspberryPi3-OpenWrt.yml) | [![](https://github.com/haiibo/OpenWrt/actions/workflows/RaspberryPi3-OpenWrt.yml/badge.svg)](https://github.com/haiibo/OpenWrt/actions/workflows/RaspberryPi3-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/haiibo/OpenWrt/blob/main/configs/rpi3.config) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/haiibo/OpenWrt/releases/tag/RaspberryPi3) |
