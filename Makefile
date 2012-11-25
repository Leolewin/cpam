# -----------------------------------------------------------------------------
#     G N U    M A K E   S C R I P T   S P E C I F I C A T I O N
# -----------------------------------------------------------------------------
# NAME
#
#  Makefile  - Building OpenIndiana packages from TWW dist 9.0 package source
#
# REVISION HISTORY
#     04/09/2011   T.J. Yang init.
#
# USAGE
#       gmake [packagename-version|buildworlds|upload=1] 
#
#
# DESCRIPTION
# 
# 1. This makefile will find out its OS platform and include corresponded makefile
#    to make package for that OS platform.
# 2. It can create moto distribution beside the default tww one.
# 3. It is currently using very dirty way of updating pkg-db.xml on repository server
#    it use rsync to copy remote pkg-db.xml and do some processing to add in a package's
#    xml entry into pkg-db.xml and then rsync back to repository server.
#    This is need to be better handle perl XML or python XML script so we can check
#    if existing pkg entry is already in remote pkg-db.xml or not.
#
# 
# TODOs
#  1. Improve Makefile syntax.
# ---------------------------- CONSTANT DECLARATION ---------------------------

#
DIST_NAME=moto
# system type indetifcation
SYSTYPE=lib/systype
# Package Distribution Name
PKG_DIST=OpenIndiana
oiuser="oi"
SB_DB=/opt/${DIST_NAME}/.sb
BUILD_DIR=/opt/${DIST_NAME}
BUILD_DB=$(shell pwd)/build/.sb
# local TWW 9.0 dist src path
SOURCE_DIR=$(shell pwd)/9.1/src
# Xymon related src directory path.
XYMON_SOURCE_DIR=../${DIST_NAME}addon
# OIADDON related src directory path.
BUILD_DB=$(shell pwd)/build/.sb
OIADDON_DIR=$(shell pwd)/9.1addon
OIADDON_DIR2=$(shell pwd)
MKFILES=os
# 
PERL=/usr/bin/perl
SUDO=/usr/bin/sudo
GIT=/usr/bin/git
MKDIR=/bin/mkdir
CHOWN=/bin/chown
# what : a simple way to give option "gmake" to specify either to 
#        upload the package to repository server or not. also to
#       specify which TWW distribution to build. 

DISTNAME=moto
TWWSB=/opt/TWWfsw/sbutils13/bin/sb  --builddir=/opt/build  --install-base=/opt/TWWfsw
DIST_PREFIX=$(shell pwd)/dist/${DISTNAME}/cd
PACKAGE_BUILD=/opt/TWWfsw/bin/pb 
GPD=/opt/TWWfsw/bin/gen-pkg-db -b /opt/${DIST_NAME}
DIST_PREFIX=$(shell pwd)/dist/${DIST_NAME}/cd
PACKAGE_UPLOAD_PATH=$(DIST_PREFIX)/dists/${PKG_DIST}/packages
BPFX=/opt/build
IPFX=/opt/${DIST_NAME}
ISUFFIX="${DIST_NAME}"
INSTALL_PREFIX=/opt/$(ISUFFIX)
DIST_PREFIX=$(shell pwd)/dist/${DIST_NAME}/cd
OIADDON_SRC=$(shell pwd)/9.1addon
M5S=/opt/TWWfsw/sbutils13/lib/aux/coreutils/bin/gmd5sum
# 
RSYNC=/usr/bin/rsync -azpv
ZIP=zip
# without in .phony docs will not act
.PHONY: docs docs-clean
all: help

help: 
	@echo doc  : make cpam docs
	@echo list : list out buildables packages names.
	@echo help : this help message.
	@echo upload=1: to create and upload package to app depot.
	@echo buildworlds: built package with both sb and pb
	@echo prework: to  configure build needed directory and setting.
	@echo "Example: "
	@echo "      1. gmake hello-2.7-clean : to clean the current build"
	@echo "      2. gmake hello-2.7 : to build and package software"
	@echo "      3. gmake hello-2.7 upload=1 : to upload the package to package depot"

ifeq ($(shell  $(SYSTYPE)),sparc-sun-solaris2.11)
SB=pfexec /opt/TWWfsw/sbutils13/bin/sb
ARCHI=sparc-sun-solaris2.11
include ${MKFILES}/Makefile.solaris.common
include ${MKFILES}/Makefile.perl-modules
else

ifeq ($(shell  $(SYSTYPE)),i386-pc-solaris2.11)
ARCHI=i386-pc-solaris2.11
GIT=/usr/bin/git
include ${MKFILES}/Makefile.solaris.common
else

ifeq ($(shell  $(SYSTYPE)),x86_64-redhat-linuxe6)
ARCHI=x86_64-redhat-linuxe6
include ${MKFILES}/Makefile.${ARCHI}
else

ifeq ($(shell  $(SYSTYPE)),x86_64-centos-linuxe6)
ARCHI=x86_64-centos-linuxe6
include ${MKFILES}/Makefile.${ARCHI}
else

ifeq ($(shell  $(SYSTYPE)),i686-debian-6.0.5)
ARCHI=i686-debian-6.0.5
else

ifeq ($(shell  $(SYSTYPE)),x86_64-ubuntu-12.04)
SB=${SUDO} /opt/TWWfsw/sbutils13/bin/sb
ARCHI=x86_64-ubuntu-12.04
include ${MKFILES}/Makefile.${ARCHI}
docs:
	(cd docs/cpambook; $(MAKE) )
docs-clean:
	(cd docs/cpambook; $(MAKE) clean)

else

ifeq ($(shell  $(SYSTYPE)),i686-ubuntu-12.04)
SB=${SUDO} /opt/TWWfsw/sbutils13/bin/sb
ARCHI=i686-ubuntu-12.04
include ${MKFILES}/Makefile.${ARCHI}
docs:
	(cd docs/cpambook; $(MAKE) all)
docs-clean:
	(cd docs/cpambook; $(MAKE) clean)
else

ifeq ($(shell  $(SYSTYPE)),x86_64-apple-darwin11.4.0)
SB=${SUDO} /opt/bd/sbutils128/bin/sb
ARCHI=x86_64-apple-darwin11.4.0
include ${MKFILES}/Makefile.${ARCHI}
else

cantbuild:
	@echo "Error:  $(shell  $(SYSTYPE)) target OS is not supported."

endif # end of sparc-sun-solaris2.11
endif # end of i386-pc-solaris2.11
endif # end of x86_64-redhat-linuxe6
endif # end of x86_64-centos-linuxe6
endif # end of i686-debian-6.0.5
endif # end of x86_64-ubuntu-12.04
endif # end of i686-ubuntu-12.04
endif # end of x86_64-apple-darwin11.4.0



list:
	@ls $(OIADDON_DIR)
tww2oi:
	echo "for i in 9.0/src/*/sb-db.xml  ; do cp  $i $i.${DIST_NAME} ; done"
	echo "for i in 9.0/src/*/pb-db.xml  ; do cp  $i $i.${DIST_NAME} ; done"
	echo "perl -pi -e 's!TWW!${DIST_NAME}!' 9.0/src/*/pb-db.xml.${DIST_NAME}"
	echo "perl -pi -e 's!\<\!DOCTYPE.*!!' 9.0/src/*/sb-db.xml.${DIST_NAME}"
prework : prework-utils twwprework ipsprework
	mkdir -p /opt/${DIST_NAME}

# Global functions 
# $(call update-depot-pkg-db,pkgname)
# $1 is the first argument.

#WHAT: for Xymon related pb-db.xml.oi
define update-xymon-depot-pkg-db
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	${PERL} -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${XYMON_SOURCE_DIR}/$1/pb-db.xml.${DIST_NAME} > /tmp/tmp.xml
	${PERL} -pi -e 's!^</packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef


#WHAT: for TWW 8.1 src related pb-db.xml.${DIST_NAME}
define update-depot-pkg-db
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	${PERL} -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${SOURCE_DIR}/$1/pb-db.xml.${DIST_NAME} > /tmp/tmp.xml
	${PERL} -pi -e 's!^</packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef


define update-depot-pkg-db-moto
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	${PERL} -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${SOURCE_DIR}/$1/pb-db.xml.${DIST_NAME} > /tmp/tmp.xml
	${PERL} -pi -e 's!^</packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef



define update-depot-pkg-db-${DIST_NAME}addon
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	${PERL} -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${${DIST_NAME}ADDON_SRC}/$1/pb-db.xml.${DIST_NAME} > /tmp/tmp.xml
	${PERL} -pi -e 's!^</packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef


define update-depot-pkg-db-2.6
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	${PERL} -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${SOURCE_DIR}/$1/pb-db.xml.${DIST_NAME}.2.6 > /tmp/tmp.xml
	${PERL} -pi -e 's!^</packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<packages>!!' /tmp/tmp.xml
	${PERL} -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef



#WHAT: 
uploadl:
	rsync -azpv . rsync://192.168.1.2/${DIST_NAME}pkg/

uploadr:
	rsync -azpv . rsync://c-71-57-114-187.hsd1.il.comcast.net/${DIST_NAME}pkg/

downloadr:
	rsync -azpv  rsync://192.168.1.2/${DIST_NAME}pkg .

# pkgdir = "/home/${DIST_NAME}/${DIST_NAME}pkg/dist/${DIST_NAME}/cd"
# install-base = "/opt/${DIST_NAME}"
#   PATH = "/opt/TWWfsw/sbutils13/lib/aux/bash/bin:\
# /opt/TWWfsw/sbutils13/lib/aux/bzip2/bin:\


twwprework: 
	${SUDO} ${MKDIR} -p $(shell pwd)/dist/${DIST_NAME}/cd \
        ./build /opt/${DIST_NAME} $(shell pwd)/dist/${DIST_NAME}/cd/dists \
        $(shell pwd)/dist/${DIST_NAME}/cd/dists/OpenIndiana/packages/i386-pc-solaris2.11 \
        $(shell pwd)/dist/${DIST_NAME}/cd/dists/OpenIndiana/packages/sparc-sun-solaris2.11
	${SUDO} ${CHOWN} -R `id -u`  ./dist ./build /opt/${DIST_NAME}
	${SUDO} ${PERL} -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	${SUDO} ${PERL} -pi -e 's!"/opt/TWWfsw"!"/opt/${DIST_NAME}"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	${SUDO} ${PERL} -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
#	${SUDO} ${PERL} -pi -e 's!"./dist/cd"!"./dist/${DIST_NAME}/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	${SUDO} ${PERL} -pi -e 's!"/opt/TWWfsw"!"/opt/${DIST_NAME}"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf


ipsprework: 
	pfexec pkg install  lftp git gnu-make wget rsync zip developer/object-file header-math imake makedepend

clean:
	rm -rf build/* *~ 

pull:
	${GIT} pull
push:
	${GIT} commit -a -m "updated by makefile"
