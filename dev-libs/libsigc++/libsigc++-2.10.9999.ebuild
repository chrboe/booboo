# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2 flag-o-matic multilib-minimal
if [[ ${PV} == *9999* ]]; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://git.gnome.org/browse/libsigcplusplus"
	EGIT_BRANCH="libsigc++-2-10"
	SRC_URI=''
else
	KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
fi

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="http://libsigc.sourceforge.net/"

LICENSE="LGPL-2.1+"
SLOT="2"
IUSE="doc static-libs test"

RDEPEND=""
DEPEND="sys-devel/m4
	doc? ( app-doc/doxygen )
	test? ( dev-libs/boost[${MULTILIB_USEDEP}] )"
# Needs mm-common for eautoreconf
if [[ ${PV} == *9999* ]]; then
	DEPEND="$DEPEND dev-cpp/mm-common"
fi

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		# eautoreconf won't work
		NOCONFIGURE=yeah ./autogen.sh
	fi

	# don't waste time building examples
	sed -i 's|^\(SUBDIRS =.*\)examples\(.*\)$|\1\2|' \
		Makefile.am Makefile.in || die "sed examples failed"

	# don't waste time building tests unless USE=test
	if ! use test ; then
		sed -i 's|^\(SUBDIRS =.*\)tests\(.*\)$|\1\2|' \
			Makefile.am Makefile.in || die "sed tests failed"
	fi

	gnome2_src_prepare

	if [[ ${PV} == *9999* ]]; then
		multilib_copy_sources
	fi
}

multilib_src_configure() {
	filter-flags -fno-exceptions #84263

	ECONF_SOURCE="${S}" gnome2_src_configure \
		$(multilib_native_use_enable doc documentation) \
		$(use_enable static-libs static) \
		$(use_enable test benchmark) \
		--enable-maintainer-mode
}

multilib_src_install() {
	gnome2_src_install
}

multilib_src_install_all() {
	einstalldocs

	# Note: html docs are installed into /usr/share/doc/libsigc++-2.0
	# We can't use /usr/share/doc/${PF} because of links from glibmm etc. docs
	use doc && dodoc -r examples
}
