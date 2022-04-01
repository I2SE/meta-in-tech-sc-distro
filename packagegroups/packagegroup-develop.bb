SUMMARY = "Set of common distribution packages during development"
LICENSE = "CLOSED"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

RDEPENDS:${PN} = " \
    can-utils \
    can-utils-essentials \
    cmake \
    ${@bb.utils.contains("TUNE_FEATURES", "cortexa7", "cpuburn-arm-a7", "", d)} \
    fping \
    git \
    iperf2 \
    iptraf \
    iputils-ping \
    ldd \
    libiio \
    libiio-iiod \
    libiio-python3 \
    libiio-tests \
    lmsensors-pwmconfig \
    mc \
    memtester \
    nano \
    openssl-bin \
    python3 \
    python3-pip \
    python3-pyserial \
    python3-shell \
    screen \
    ser2net \
    socat \
    sqlite3 \
    strace \
    subversion \
    systemd-analyze \
    tmux \
"
