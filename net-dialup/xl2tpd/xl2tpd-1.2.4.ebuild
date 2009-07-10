# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xl2tpd/xl2tpd-1.2.3.ebuild,v 1.1 2009/01/11 12:56:17 mrness Exp $

inherit eutils flag-o-matic

DESCRIPTION="A modern version of the Layer 2 Tunneling Protocol (L2TP) daemon"
HOMEPAGE="http://www.xelerance.com/software/xl2tpd/"
SRC_URI="ftp://ftp.xelerance.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="kernel-l2tp"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}
	net-dialup/ppp"

src_compile() {
	use kernel-l2tp && (
		ewarn 'You are using in-kernel l2tp support.'
		emake OSFLAGS="-DLINUX -I/usr/src/linux/include/ -DUSE_KERNEL") ||
	emake
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install || die "emake install failed"

	dodoc CREDITS README.xl2tpd \
		doc/README.patents doc/rfc2661.txt doc/*.sample

	dodir /etc/xl2tpd
	head -n 2 doc/l2tp-secrets.sample > "${D}/etc/xl2tpd/l2tp-secrets"
	fperms 0600 /etc/xl2tpd/l2tp-secrets
	newinitd "${FILESDIR}"/xl2tpd-init xl2tpd

	keepdir /var/run/xl2tpd
}
