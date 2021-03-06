# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/vcsh/vcsh-1.20141026.ebuild,v 1.1 2014/11/11 23:38:35 tamiko Exp $

EAPI=5

inherit git-2

DESCRIPTION='Manage config files in $HOME via fake bare git repositories'
HOMEPAGE="https://github.com/RichiH/vcsh/"
EGIT_REPO_URI="https://github.com/RichiH/vcsh/"
LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git"
DEPEND="app-text/ronn"

DOCS=( changelog README.md CONTRIBUTORS )

S=${S}-manpage-static

src_prepare() {
	default
	sed -i \
		-e 's,vendor-completions,site-functions,' \
		-e "s,\(\$(DOCDIR_PREFIX)\)/\$(self),\1/${PF}," \
		-e 's,all=test manpages,all=manpages,' \
		Makefile || die
}

src_install() {
	default
	dodoc -r doc/sample_hooks
}
