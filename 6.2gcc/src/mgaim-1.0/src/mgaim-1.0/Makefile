#
# top-level Makefile for expmake of an exptools package
#

# ------------- Start of customization
# The beginning of this Makefile is the part that varies per-package
PKG = gaim
PKGBALL = $(PKG)cpiogz
SRCDIR = src
PREFIX = /opt/exp

# Uncomment WORLDWIDE on the next line if this package should go into 
# "Worldwide Exptools" - these tools are made available on the public
# (external) internet, so only non-proprietary tools with open-source 
# licenses should set this.  In addition, the Exptools central 
# administrator (exptools@lucent.com) needs to mark the package as
# worldwide.
WORLDWIDE=-worldwide

# VERSION is only really needed when building a package "worldwide" 
# This doesn't do anything except put the version the exptools webpage
VERSION=`grep VERSION= src/configure | sed -e 's/VERSION=//'`

# DIR_SUFFIX is normally blank, but is set if the tools are installed
# somewhere other than /opt/exp.  For example, /gnu, /ast, or /perl
DIR_SUFFIX=

# for all types use TYPES = `machines gnutypes|xargs|tr ' ' ','`
TYPES=sparc-sun-solaris,i686-pc-linux-gnu,hppa1.1-hp-hpux,mips-sgi-irix,i386-pc-solaris,powerpc-apple-darwin

# PORTYPE is the machine type from which portables files are taken
PORTTYPE = sparc-sun-solaris
# ------------- End of customization

OUTDIR = ins

# TYPE and ANSICC are overridden on remote machine
TYPE = unspecified
ANSICC = cc

# PRIVATE_PREFIX is only used when building for a local installation.  It
# must be supplied by the user on the make command line.
PRIVATE_PREFIX = unspecified

# PREFIX specifies what prefix is used when building the tools
# (which is also directory where tools will be found when they are actually
# installed under exptools).  This defaults to the /opt/exp directory, but
# is overridden by the "local" target if the tool is being built for
# local installation.
PREFIX = unspecified

# INSTALL_SHARE_PREFIX and INSTALL_EXEC_PREFIX specify where portable and
# non-portable files are installed.  They default to directories under
# the remote build node, but are overridden by the "local" target if the
# tool is being built for local installation
INSTALL_SHARE_PREFIX = unspecified
INSTALL_EXEC_PREFIX = unspecified

# MAKE_ARGS are passed to recursive sub-makes.  (This is not needed if
# Gnu make is used, but to be as portable as possible, it's a good idea)
MAKE_ARGS = PKG=$(PKG) SRCDIR=$(SRCDIR) ANSICC="$(ANSICC)" TYPE=$(TYPE)

# TYPE and ANSICC are overridden on remote machine
TYPE = unspecified
ANSICC = cc

default: help

# rule to configure, make, and "install"
# portable files should be installed into $(INSTALL_SHARE_PREFIX) and
#   non-portable files should be installed into $(INSTALL_EXEC_PREFIX)
#   in a mirror of where they will ultimately go under /opt/exp.  For
#   remote builds via expmake, $(INSTALL_SHARE_PREFIX) will be set to
#   $(OUTDIR)/share and $(INSTALL_EXEC_PREFIX) will be $(OUTDIR)/$(TYPE).
#   When building for a local installation, both will be set to
#   the user supplied value for $(PRIVATE_PREFIX).
# (Also note that hand-generated portable files, those not generated
#   by this rule but also to be installed under /opt/exp, go under
#   the "misc" directory on the source machine)

commonbuild:
	@set -ex; HERE=`pwd`; OUT=$$HERE/$(OUTDIR); \
	cd $(SRCDIR); \
	: make sure automake, aclocal, autoheader, and autoconf do not run; \
	touch aclocal.m4; \
	find * -name "Makefile.in" -print|xargs touch; \
	touch stamp-h.in configure; \
	rm -f config.cache; \
	CC="$(ANSICC)"; export CC; \
	SED=sed; export SED; \
	: Sometimes a machine type needs special setup; \
	case $(TYPE) in  \
	powerpc-apple-darwin ) \
		EXTRACONFIG=--disable-perl; \
		export LDFLAGS; LDFLAGS="-L/opt/exp/gnu/lib -liconv"; \
		export CFLAGS; CFLAGS="-I/opt/exp/gnu/include -DEILSEQ=-1"; \
		;; \
	hppa* ) \
		export CFLAGS; \
		CFLAGS="-D_XOPEN_SOURCE_EXTENDED -I/opt/exp/gnu/include -I/opt/exp/gnu/include/glib-1.2"; \
		export LDFLAGS; LDFLAGS="-L/opt/exp/gnu/lib -liconv -Wl,+b:"; \
		CC="gcc -g"; \
		sed -e s'/libtmp$$@.so\* $$@/libtmp$$@.sl* $$@/' plugins/Makefile.in > Makefile.in.tmp; \
		cp Makefile.in.tmp plugins/Makefile.in; \
		EXTRACONFIG=--disable-perl; \
		;; \
	i386-pc-solaris ) \
		export SED; SED=/opt/exp/gnu/bin/sed; \
		export CFLAGS; \
		CFLAGS="-I/opt/exp/gnu/include -I/opt/exp/gnu/include/glib-1.2"; \
		export LDFLAGS; \
		LDFLAGS="-L/opt/exp/gnu/lib -liconv -Wl,-R/opt/exp/gnu/lib"; \
		CC="gcc -g"; \
		if [ -f ../solaris.patches ] ; then \
			/opt/exp/bin/patch -p1 < ../solaris.patches; \
			mv ../solaris.patches ../solaris.patches.done; \
		fi; \
		EXTRACONFIG=--disable-perl; \
		;; \
	sparc-sun-solaris ) \
		export SED; SED=/opt/exp/gnu/bin/sed; \
		export CFLAGS; \
		CFLAGS="-I/opt/exp/gnu/include -I/opt/exp/gnu/include/glib-1.2"; \
		if [ `uname -r` = "5.5.1" ] ; then \
			CFLAGS="$$CFLAGS -DNEED_XPRIVDISPLAY"; \
		fi; \
		export LD; \
		LD=/opt/exp/gnu/bin/ld; \
		export LDFLAGS; \
		LDFLAGS="-Wl,-R/opt/exp/gnu/lib"; \
		CC="gcc -g"; \
		if [ -f ../solaris.patches ] ; then \
			/opt/exp/bin/patch -p1 < ../solaris.patches; \
			mv ../solaris.patches ../solaris.patches.done; \
		fi; \
		EXTRACONFIG=--disable-perl; \
		;; \
	mips-sgi-irix ) \
		export LDFLAGS; \
		LDFLAGS="-Wl,-rpath -Wl,/opt/exp/gnu/lib"; \
		CC=gcc; \
		EXTRAMAKE="DEBUG_LIBS='-lgtk -lglib -liconv'"; \
		;; \
	*linux* ) \
		export SED; SED=/opt/exp/gnu/bin/sed; \
		CC="gcc -g"; \
		export CFLAGS; \
		CFLAGS="-I/opt/exp/gnu/include/glib-1.2 -I/opt/exp/gnu/include"; \
		export LDFLAGS; \
		LDFLAGS="-L/opt/exp/gnu/lib -liconv -lcrypt -Wl,-R/opt/exp/gnu/lib"; \
		EXTRACONFIG=--disable-perl; \
		;; \
	esac; \
	./configure --with-static-prpls="oscar toc rvp" --with-gtk-prefix=/opt/exp/gnu --with-esd-prefix=/opt/exp/gnu --disable-nls --with-glib-prefix=/opt/exp/gnu --prefix=$(PREFIX) $$EXTRACONFIG; \
	case $(TYPE) in  \
	*linux* ) \
		sed -e 's/-ldb1/-ldb/' src/Makefile > src/Makefile.tmp; \
		cp src/Makefile.tmp src/Makefile; \
		;; \
	esac; \
	unset LDFLAGS || :; unset CFLAGS || :; \
	gmake all $${EXTRAMAKE+"$$EXTRAMAKE"}; \
	: strip src/gaim; \
	gmake prefix=$(INSTALL_SHARE_PREFIX) exec_prefix=$(INSTALL_EXEC_PREFIX) install

# the remainder of this file should pretty much be able to be common
#  to most packages

help:
	@echo "No default target; choose one of"
	@echo "   build, preview, provide, or clean"
	@echo "clean is made up of cleanlocal and cleanremote"

build: saveold prepareremote buildremote unpack
	getdate +$(TYPES)" %a %h %l  %T  %z  %Y" >> lastbuild

saveold:
	@set -ex; \
       COMMATYPES=$(TYPES); \
       for TYPE in `echo $$COMMATYPES|tr ',' ' '`; do \
         if [ -d $(OUTDIR)/$$TYPE ]; then \
           rm -rf $(OUTDIR)/$$TYPE.old; \
           mv $(OUTDIR)/$$TYPE $(OUTDIR)/$$TYPE.old; \
         fi; \
	 if [ "$$TYPE" = "$(PORTTYPE)" ] && [ -d $(OUTDIR)/share ]; then \
	   rm -rf $(OUTDIR)/share.old; \
	   mv $(OUTDIR)/share $(OUTDIR)/share.old; \
	 fi; \
       done

prepareremote: cleanlocal
	@set -ex; \
       expmake $(WORLDWIDE) version="$(VERSION)" -prepareOnly updateParameters="targets $(PKGBALL)" $(PKG)

buildremote:
	@set -ex; \
       expmake $(WORLDWIDE) version="$(VERSION)" -skipPrepare -parallel executableTypes=$(TYPES) $(PKG)

unpack:
	@set -ex; \
	PATH=/opt/exp/gnu/bin:$$PATH; \
       for file in $(PKGBALL).*; do \
	     gzcat <$$file | cpio -ivdum; \
         rm -f $$file; \
       done

# this is the target on the remote machine
# $(PKGBALL) will be returned to the local machine by expmake
# $OUTDIR is removed following the build to save space on the build machine
$(PKGBALL): precleanoutdir always
	@set -ex; HERE=`pwd`; \
	$(MAKE) commonbuild $(MAKE_ARGS) \
		INSTALL_SHARE_PREFIX=$$HERE/$(OUTDIR)/share$(DIR_SUFFIX) \
		INSTALL_EXEC_PREFIX=$$HERE/$(OUTDIR)/$(TYPE)$(DIR_SUFFIX) \
		PREFIX=/opt/exp$(DIR_SUFFIX)
	@set -ex; DIRS="$(OUTDIR)/$(TYPE)"; \
		if [ "$(TYPE)" = "$(PORTTYPE)" ]; then \
			DIRS="$$DIRS $(OUTDIR)/share"; \
		fi; \
		find $$DIRS -print | cpio -ocv | gzip >$(PKGBALL); \
		rm -rf $(OUTDIR)

# Make sure installation directory is clean before starting the new build
precleanoutdir:
		rm -rf $(OUTDIR)

# "make private" is used when you want to use the exptools source package
# to build a non-exptools package on the local machine.  In this case,
# both the build and installation prefixes are set to the directory
# where the package should be installed.

private: always
	@if [ $(TYPE) = unspecified ] ; then \
		echo 'Machine type must be specified.  (Use TYPE=xxx)' ; \
		exit 1; \
	fi
	@if [ $(PRIVATE_PREFIX) = unspecified ] ; then \
		echo 'Local installation prefix must be specified.';  \
		echo '(Use PRIVATE_PREFIX=/xxx/yyy/zzz)' ; \
		exit 1; \
	fi
	@if [ "$$CDPATH" != "" ] ; then \
		echo 'Make sure CDPATH is not set!'; \
		exit 1 ; \
	fi
	$(MAKE) commonbuild $(MAKE_ARGS) INSTALL_SHARE_PREFIX=$(PRIVATE_PREFIX) \
		INSTALL_EXEC_PREFIX=$(PRIVATE_PREFIX) \
		PREFIX=$(PRIVATE_PREFIX)

# "make preview" allows you to see which files will be installed or deleted
#   without actually making the changes.  This can help prevent
#   accidental deletions of something important
preview:
	@set -ex; expprovide $(WORLDWIDE) -askreason version="$(VERSION)" -preview executableTypes=$(TYPES) $(PKG)

# "make provide" installs the package on all client machines.  This typically
#   happend during the night, so changes made one day will be visible
#   to users the next day.
provide: preview
	@set -ex; expprovide $(WORLDWIDE) version="$(VERSION)" -skipPrepare -saveout $(PKG)


clean: cleanremote cleanlocal

cleanlocal:
	@set -ex; cd $(SRCDIR); \
       if [ -f Makefile ]; then \
         if grep "^distclean:" Makefile >/dev/null; then \
           make distclean; \
         else \
           make clean; \
         fi; \
       fi

cleanremote:
	@set -ex; \
       if [ -f $(PKG)src.nsb ]; then \
         expmake $(WORLDWIDE) version="$(VERSION)" -skipPrepare -clean executableTypes=$(TYPES) $(PKG); \
         rm -f $(PKG)src.nsb; \
       fi

distclean: clean
	rm -rf expmakeout* $(PKGBALL)* $(OUTDIR) 

always:
