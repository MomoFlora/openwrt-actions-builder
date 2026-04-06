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
| ⚡ NSS 加速 | Qualcommax 平台支持，大幅降低 CPU 占用，提升小包转发性能 |
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

## 🛠️ 定制固件
1. 首先要登录 Gihub 账号，然后 Fork 此项目到你自己的 Github 仓库
2. 修改 `configs` 目录对应文件添加或删除插件，或者上传自己的 `xx.config` 配置文件
3. 插件对应名称及功能请参考恩山网友帖子：[Applications 添加插件应用说明](https://www.right.com.cn/forum/thread-3682029-1-1.html)
4. 如需修改默认 IP、添加或删除插件包以及一些其他设置请在 `diy-script.sh` 文件内修改
5. 添加或修改 `xx.yml` 文件，最后点击 `Actions` 运行要编译的 `workflow` 即可开始编译
6. 编译大概需要3-5小时，编译完成后在仓库主页 [Releases](https://github.com/MomoFlora/openwrt-actions-builder/releases) 对应 Tag 标签内下载固件
<details>
<summary><b>&nbsp;如果你觉得修改 config 文件麻烦，那么你可以点击此处尝试本地提取</b></summary>

1. 首先装好 Linux 系统，推荐 Debian 11 或 Ubuntu LTS

2. 安装编译依赖环境

   ```bash
    sudo apt update -y
    sudo apt full-upgrade -y
    sudo apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
    bzip2 ccache clang cmake cpio curl device-tree-compiler flex gawk gcc-multilib g++-multilib gettext \
    genisoimage git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev \
    libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev \
    libreadline-dev libssl-dev libtool llvm lrzsz libnsl-dev ninja-build p7zip p7zip-full patch pkgconf \
    python3 python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion \
    swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev
   ```

3. 下载源代码，更新 feeds 并安装到本地

   ```bash
   git clone -b openwrt-25.12 --single-branch --filter=blob:none https://github.com/immortalwrt/immortalwrt
   cd lede
   ./scripts/feeds update -a
   ./scripts/feeds install -a
   ```

4. 复制 diy-script.sh 文件内所有内容到命令行，添加自定义插件和自定义设置

5. 命令行输入 `make menuconfig` 选择配置，选好配置后导出差异部分到 seed.config 文件

   ```bash
   make defconfig
   ./scripts/diffconfig.sh > seed.config
   ```

7. 命令行输入 `cat seed.config` 查看这个文件，也可以用文本编辑器打开

8. 复制 seed.config 文件内所有内容到 configs 目录对应文件中覆盖就可以了

   **如果看不懂编译界面可以参考 YouTube 视频：[软路由固件 OpenWrt 编译界面设置](https://www.youtube.com/watch?v=jEE_J6-4E3Y&list=WL&index=7)**
</details>
