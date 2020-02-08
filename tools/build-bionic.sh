#!/bin/bash

curl 'https://raw.githubusercontent.com/AmanoTeam/gha-free-space/refs/heads/master/main.sh' -sSf | bash 

dpkg --add-architecture i386
apt update

apt install libc6:i386 libstdc++6:i386
apt install binutils openjdk-8-jdk-headless 2to3

curl \
	--url 'https://storage.googleapis.com/git-repo-downloads/repo' \
	--retry '30' \
	--retry-all-errors \
	--retry-delay '0' \
	--retry-max-time '0' \
	--show-error \
	--location \
	--silent \
	--output '/usr/bin/repo'

chmod +x '/usr/bin/repo'

git config --global user.email "android@users.noreply.github.com"
git config --global user.name "android"

repo \
	init \
	--partial-clone \
	--no-use-superproject \
	-b 'android-8.1.0_r81' \
	-u 'https://android.googlesource.com/platform/manifest'

repo sync -c

ln \
	--symbolic \
	--relative \
	--force \
	'/usr/bin/ld.gold' \
	"${HOME}/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/bin/ld"

ln \
	--symbolic \
	--relative \
	--force \
	"${HOME}/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/sysroot/usr/lib/lib"{tinfo,ncurses}".so.5" \
	'/usr/lib/x86_64-linux-gnu'

2to3 -w "${HOME}/external/clang"
2to3 -w "${HOME}/bionic"

sed \
	--in-place \
	's|any(lower <= value <= upper for (lower, upper) in ranges)|any(int(lower) <= int(value) <= int(upper) for (lower, upper) in ranges)|' \
	"${HOME}/bionic/libc/fs_config_generator.py"

source "${HOME}/build/envsetup.sh"

lunch aosp_mips64-eng

cd "${HOME}/bionic"
mm

cd "${HOME}/system/core/toolbox"
mm

cd "${HOME}/system/core/logcat"
mm

cd "${HOME}/external/toybox"
mm

cd "${HOME}/external/dnsmasq"
mm

cd "${HOME}/external/mksh"
mm

cd "${HOME}/frameworks/native/cmds"
mm

cd "${HOME}/external/iproute2"
mm

cd "${HOME}/external/iptables"
mm

cd "${HOME}/external/e2fsprogs"
mm

cd "${HOME}/external/f2fs-tools"
mm

cd "${HOME}/external/sqlite/dist"
mm
