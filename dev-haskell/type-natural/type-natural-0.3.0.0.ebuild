# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Type-level natural and proofs of their properties"
HOMEPAGE="https://github.com/konn/type-natural"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/constraints-0.3:=[profile?] <dev-haskell/constraints-0.5:=[profile?]
	>=dev-haskell/equational-reasoning-0.2:=[profile?] <dev-haskell/equational-reasoning-0.3:=[profile?]
	>=dev-haskell/monomorphic-0.0.3:=[profile?]
	( >=dev-haskell/singletons-2.0:=[profile?] <dev-haskell/singletons-2.1:=[profile?] )
	>=dev-lang/ghc-7.10:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
"
