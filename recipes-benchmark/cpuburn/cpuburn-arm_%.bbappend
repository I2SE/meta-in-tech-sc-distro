# split out cpuburn-arm-a7
PACKAGES =+ "${@bb.utils.contains('TUNE_FEATURES', 'aarch64', '', '${PN}-a7', d)}"

do_install:append() {
    # compatibility symlink for the previous binary name
    if ${@bb.utils.contains('TUNE_FEATURES', 'aarch64', 'false', 'true', d)}; then
        ln -s burn-a7 ${D}/${bindir}/cpuburn-a7
    fi
}

FILES:${PN}-a7 = "${@bb.utils.contains('TUNE_FEATURES', 'aarch64', '', '${bindir}/burn-a7 ${bindir}/cpuburn-a7', d)}"
FILES:${PN}:remove = "${@bb.utils.contains('TUNE_FEATURES', 'aarch64', '', '${bindir}/burn-a7 ${bindir}/cpuburn-a7', d)}"
