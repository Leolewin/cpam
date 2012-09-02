# -----------------------------------------------------------------------------
#                     S C R I P T   S P E C I F I C A T I O N
# -----------------------------------------------------------------------------
# NAME
#       postinstall - actions after installations.
#
#
# REVISION HISTORY
#     March 19 2004  by  T.J. Yang original
#
#
#
# USAGE
#       postinstall
#
# DESCRIPTION
#       This script does any work needed after a package has been installed.
#       This includes checking to make sure everything got installed
#       properly, changing startup scripts, customization of configuration
#       files, stopping/starting of daemons,etc.
#
#SB=/opt/TWWfsw/sbutils12/bin/sb
#PB=/opt/TWWfsw/bin/pb
ZIP=zip
M5S=/opt/TWWfsw/bin/gmd5sum
GPD=/opt/TWWfsw/bin/gen-pkg-db
RSYNC=/opt/TWWfsw/rsync25/bin/rsync
ifeq ($(shell  /opt/TWWfsw/pkgutils15/lib/systype),sparc-sun-solaris2.6)
include Makefile.sparc-sun-solaris2.6
include Makefile.sparc-sun-solaris.common
else
ifeq ($(shell  /opt/TWWfsw/pkgutils15/lib/systype),sparc-sun-solaris2.8)
include Makefile.sparc-sun-solaris2.8
include Makefile.sparc-sun-solaris.common
else
ifeq ($(shell  /opt/TWWfsw/pkgutils15/lib/systype),sparc-sun-solaris2.9)
include Makefile.sparc-sun-solaris2.9
include Makefile.sparc-sun-solaris.common
else
ifeq ($(shell  /opt/TWWfsw/pkgutils15/lib/systype),i686-redhat-linux7.3)
include Makefile.i686-redhat-linux7.3
include Makefile.i686-pc-linux-gnu.common
else
ifeq ($(shell  /opt/TWWfsw/pkgutils15/lib/systype),i686-redhat-linux9)
include Makefile.i686-redhat-linux9
include Makefile.i686-pc-linux-gnu.common
else
ifeq ($(shell  /opt/TWWfsw/pkgutils15/lib/systype),hppa1.1-hp-hpux10.20)
include Makefile.hppa1.1-hp-hpux10.20
include Makefile.hppa1.1-hp-hpux.common
else
ifeq ($(shell  /opt/TWWfsw/pkgutils15/lib/systype),hppa1.1-hp-hpux11.11)
include Makefile.hppa1.1-hp-hpux11.11
include Makefile.hppa1.1-hp-hpux.common
else
cantbuild:
	@echo "Error:  $(shell  /opt/TWWfsw/pkgutils15/lib/systype) target OS is not supported
endif
endif
endif
endif
endif
endif
endif
