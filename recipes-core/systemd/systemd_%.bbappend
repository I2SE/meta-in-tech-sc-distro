FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-cgroup-downgrade-warning-if-we-can-t-get-ID-off-cgro.patch \
"

PACKAGECONFIG:remove = " acl backlight binfmt hibernate ima machined polkit smack vconsole nss-mymachines utmp"
PACKAGECONFIG:append = " polkit_hostnamed_fallback"

RDEPENDS:${PN}:remove = "volatile-binds systemd-compat-units systemd-extra-utils udev-hwdb"

RRECOMMENDS:${PN}:remove = "udev-hwdb"

PACKAGECONFIG[ldconfig] = "-Dldconfig=true,-Dldconfig=false"

do_install:append() {
    # move /sbin/init away since we install our own for first run
    mv ${D}/sbin/init ${D}/sbin/init.orig

    # don't use this
    rm -f ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf

    # we don't need a getty on VT
    rm -f ${D}${sysconfdir}/systemd/system/getty.target.wants/getty@tty1.service
    rm -f ${D}${systemd_system_unitdir}/getty@.service

    # we don't use containers
    rm -f ${D}/lib/systemd/network/80-container*

    # create an empty machine-id
    touch ${D}${sysconfdir}/machine-id

    # REVIEW: disable systemd persistant journal for now
    rm -rf ${D}/${localstatedir}/log/journal

    # do not install .network.example files
    rm -rf ${D}${systemd_unitdir}/network
}

FILES:${PN}:append = " ${sysconfdir}/machine-id /sbin/init.orig"
FILES:${PN}:remove = "${systemd_unitdir}/network/"
