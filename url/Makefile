# -----------------------------------------------------------------------------
#              M A K E   S C R I P T   S P E C I F I C A T I O N
# -----------------------------------------------------------------------------
# NAME
#
#  Makefile  - Main Makefile for building CPAM  packages.
#

# REVISION HISTORY
#     Aug 30 2005   by  TJ Yang original.
#     July 31 2005  update to MOTOpkg acronym.
#     08/17/2010   customized Makefile for creating test packages.
#     08/18/2010   customized Makefile for creating packages for NSN distribution.
#     01/04/2012   reognize build directories structure.
#
# USAGE
#       gmake [motodist=1|upload=1] [packagename-version|allpkgs]
#
# DESCRIPTION
# 
# 1. This makefile will find out its OS platform and include corresponded makefile
#    to make package for that platform.
# 2. It can create moto distribution beside the default tww one.
# 3. It is currently using very dirty way of updating pkg-db.xml on repository server
#    it use rsync to copy remote pkg-db.xml and do some processing to add in a package's
#    xml entry into pkg-db.xml and then rsync back to repository server.
#    This is need to be better handle perl XML or python XML script so we can check
#    if existing pkg entry is already in remote pkg-db.xml or not.
# 4. 
# 
# 

# ---------------------------- CONSTANT DECLARATION ---------------------------
# NOTE: DO NOT CHANGE UNLESS YOU KNOW WHAT YOU ARE DOING!!!
#
#

# what : a simple way to give option "gmake" to specify either to 
#        upload the package to repository server or not. also to
#       specify which TWW distribution to build. 



# Distribution 
PKG_DIST=moto9.1
SSB=/opt/TWWfsw/sbutils13/bin/sb 
#VER=9.1
VER=
# TWW dist 9.1 src path
#SOURCE_DIR=../9.1/src
LOCAL_SOURCE_DIR=../../9.1/src
#SOURCE_DIR=ftp://aspire1.example.com/tww/9.1/src
SOURCE_DIR=http://aspire1.example.com/cpam/9.1/src

# Xymon related src directory path.
#MOTOADDON_SRC=../$(VER)addon
MOTOADDON_SRC=../../9.0addon
MOTO81ADDON_SRC=../9.1addon
DIST_DIR=/opt/dist/moto$(VER)/cd
BUILD_DIR=/opt/build$(VER)
INSTALLBASE=/opt/moto$(VER)
SB_DB=$(INSTALLBASE)/.sb
MKDIR := mkdir -p

# $(call maybe-mkdir, directory-name-opt)
#   Create a directory if it doesn't exist.
#   If directory-name-opt is omitted use $@ for the directory-name.
file-exists = $(wildcard $1)
maybe-mkdir = $(if $(call file-exists,          \
                     $(if $1,$1,$(dir $@))),,   \
                $(MKDIR) $(if $1,$1,$(dir $@)))

.PHONY: remove-dir  create-dir

#  PACKAGE_BUILD=/opt/TWWfsw/bin/pb  --keep-temp-files
ifeq ($(motodist),1)
  SB=/opt/TWWfsw/bin/sb 
  PACKAGE_BUILD=/opt/TWWfsw/bin/pb 
  PACKAGE_UPLOAD_PATH=rsync://repository.example.conm/motopkgdist/cd
else
  GCCSB=/opt/TWWfsw/sbutils13/bin/sb 
  SB=/opt/TWWfsw/sbutils13/bin/sb 
  TWWSB=/opt/TWWfsw/sbutils13/bin/sb
  DIST_PREFIX=/opt/dist/moto$(VER)/cd
  PACKAGE_BUILD=/opt/TWWfsw/bin/pb -b /opt/moto$(VER) 
  GCCPACKAGE_BUILD=/opt/TWWfsw/bin/pb -b /opt/moto$(VER) 
  GPD=/opt/TWWfsw/bin/gen-pkg-db -b /opt/moto$(VER)
  PACKAGE_UPLOAD_PATH=rsync://repository.example.conm/motopkgdist/cd/dists/${PKG_DIST}/packages
  IPFX=$(INSTALLBASE)
  INSTALL_PREFIX=$(INSTALLBASE)
  DIST_PREFIX=$(DIST_DIR)
  M5S=/opt/TWWfsw/sbutils13/lib/aux/coreutils/bin/gmd5sum
  # unless repository.example.conm has rsync installed in /opt/moto
  RSYNC=/opt/moto/rsync26/bin/rsync -azpv
  ZIP=zip
endif


all: help

help: 
	@echo 
	@echo        help : to get this message.
	@echo list: a list of buildable packages.
	@echo motodist=1: to build moto dist.
	@echo upload=1: to create and upload package to app depot.
	@echo allpkgs: built package with both sb and pb
	@echo rebuild-all: start from scratch.
	@echo Example: gmake motodist=1 upload=1 xpm-3.4k


ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),sparc-sun-solaris2.6)
ARCHI=sparc-sun-solaris2.6
include Makefile.solaris.common
prework-utils: rsync-2.5.6  textutils-2.1 
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),sparc-sun-solaris2.8)
ARCHI=sparc-sun-solaris2.8
include Makefile.solaris.common
include Makefile.perl-modules
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),sparc-sun-solaris2.9)
ARCHI=sparc-sun-solaris2.9
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
include Makefile.solaris.common
include Makefile.perl-modules
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),sparc-sun-solaris2.10)
ARCHI=sparc-sun-solaris2.10
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
include Makefile.solaris.common
include Makefile.perl-modules
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),sparc-sun-solaris2.11)
ARCHI=sparc-sun-solaris2.10
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
include Makefile.solaris.common
include Makefile.perl-modules
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i386-pc-solaris2.10)
ARCHI=i386-pc-solaris2.10
PERLARCH=i86pc-solaris-thread-multi
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
include Makefile.solaris.common
include Makefile.perl-modules
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i386-pc-solaris2.11)
ARCHI=i386-pc-solaris2.11
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
include Makefile.solaris.common
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i686-redhat-linux7.3)
ARCHI=i686-redhat-linux7.3
CPU=i386
include Makefile.rhlinux.common
remove-autotool:

	rpm -e --nodeps automake-1.4p5-4  automake15-1.5-2
	rpm -e --nodeps libtool-1.4.2-7 libtool-libs13-1.3.5-2 libtool-libs-1.4.2-7
	rpm -e --nodeps autoconf253-2.53-3 autoconf-2.13-17 
prework-utils: rsync-2.5.6  textutils-2.1 
buildprework: 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i686-redhat-linux9)
ARCHI=i686-redhat-linux9
CPU=i386
include Makefile.rhlinux.common
remove-autotool:
	rpm -e --nodeps libtool-1.4.3-5  libtool-libs-1.4.3-5
	rpm -e --nodeps automake15-1.5-6 automake14-1.4p6-5.1 automake-1.6.3-5
	rpm -e --nodeps autoconf213-2.13-6 autoconf-2.57-3
prework-utils: rsync-2.5.6  textutils-2.1 
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf


else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i686-redhat-linuxe3)
RSYNC=/usr/bin/rsync -azpv
ARCHI=i686-redhat-linuxe3
CPU=i386
include Makefile.rhlinux.common
build-prework: remove-autotool  prework  tww2moto  rsync-2.5.6  textutils-2.1 
remove-autotool:
	rpm -e --nodeps libtool-1.4.3-6  libtool-libs-1.4.3-6
	rpm -e --nodeps automake15-1.5-7 automake14-1.4p6-6 automake-1.6.3-5
	rpm -e --nodeps autoconf213-2.13-6 autoconf-2.57-3
tww2moto:
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOT!'  {} \;
prework : 
	@mkdir -p /opt/dist /opt/build
	@mkdir -p /opt/dist/moto /opt/build
else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),x86_64-redhat-linuxe3)
ARCHI=x86_64-redhat-linuxe3
CPU=x86_64
include Makefile.rhlinux.common
prework-utils: rsync-2.5.6  textutils-2.1 

remove-autotool:
	rpm -e --nodeps libtool-1.4.3-6  
	rpm -e --nodeps automake15-1.5-7 automake14-1.4p6-6 automake-1.6.3-5
	rpm -e --nodeps autoconf213-2.13-6 autoconf-2.57-3
buildprework : 
	@mkdir -p $(DIST_DIR) $(BUILD_DIR) $(INSTALLBASE)
#	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
#	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
#	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
#	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
#	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOT!'  {} \;
prework : prework-utils
	@mkdir -p /opt/dist/moto/cd/i386 /opt/build

else

ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),x86_64-redhat-linuxe4)
ARCHI=x86_64-redhat-linuxe4
CPU=x86_64
#PACKAGE_BUILD=/opt/TWWfsw/bin/pb -b /opt/moto$(VER) --pkgdir==${DIST_DIR}/${CPU}
PACKAGE_BUILD=/opt/TWWfsw/bin/pb -b /opt/moto$(VER)
RSYNC=/usr/bin/rsync -azpv
include Makefile.rhlinux.common
prework-utils: rsync-2.5.6  textutils-2.1 

remove-autotool:
	rpm -e --nodeps libtool-1.4.3-6  libtool-libs-1.4.3-6
	rpm -e --nodeps automake15-1.5-7 automake14-1.4p6-6 automake-1.6.3-5
	rpm -e --nodeps autoconf213-2.13-6 autoconf-2.57-3
buildprework : 
	@mkdir -p /opt/dist/moto /opt/build
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOT!'  {} \;
prework : prework-utils
	@mkdir -p /opt/dist/moto/cd/i386 /opt/build

else

ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),x86_64-redhat-linuxe6)
ARCHI=x86_64-redhat-linuxe6
CPU=x86_64
RSYNC=/usr/bin/rsync -azpv
include Makefile.rhlinux.common.64
prework-utils: rsync-2.5.6  textutils-2.1 

remove-autotool:
	rpm -e --nodeps libtool-1.4.3-6  libtool-libs-1.4.3-6
	rpm -e --nodeps automake15-1.5-7 automake14-1.4p6-6 automake-1.6.3-5
	rpm -e --nodeps autoconf213-2.13-6 autoconf-2.57-3
buildprework : 
	@mkdir -p /opt/dist/moto /opt/build
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOT!'  {} \;
prework : prework-utils
	@mkdir -p /opt/dist/moto/cd/i386 /opt/build

else


ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i686-redhat-linuxe4)
ARCHI=i686-redhat-linuxe4
CPU=i386
RSYNC=/usr/bin/rsync -azpv
include Makefile.rhlinux.common
prework-utils:  rsync-2.5.6  textutils-2.1 

remove-autotool:
	rpm -e --nodeps libtool-1.5.6-4 libtool-libs-1.5.6-4
	rpm -e --nodeps automake-1.9.2-3 automake14-1.4p6-12  automake16-1.6.3-5  automake15-1.5-13
	rpm -e --nodeps autoconf213-2.13-9 autoconf-2.59-5
buildprework: 
	@mkdir -p /opt/dist/moto/i386 /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOTO!'  {} \;
prework : prework-utils
	@mkdir -p /opt/moto


else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i686-redhat-linuxe4)
ARCHI=i686-redhat-linuxe4
CPU=i386
RSYNC=/usr/bin/rsync -azpv
include Makefile.rhlinux.common
prework-utils:  rsync-2.5.6  textutils-2.1 

remove-autotool:
	rpm -e --nodeps libtool-1.5.6-4 libtool-libs-1.5.6-4
	rpm -e --nodeps automake-1.9.2-3 automake14-1.4p6-12  automake16-1.6.3-5  automake15-1.5-13
	rpm -e --nodeps autoconf213-2.13-9 autoconf-2.59-5
buildprework: 
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe4/pkgutils-1.5.24-1.rpm.pkg-inst
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe4/sbutils-1.2.7-1.rpm.pkg-inst
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe4/pbutils-1.1.14-1.rpm.pkg-inst
	@mkdir -p /opt/dist/moto/i386 /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOTO!'  {} \;
prework : prework-utils
	@mkdir -p /opt/moto


else

ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),hppa1.1-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
include Makefile.hp-ux.common
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i686-redhat-linuxe5)
ARCHI=i686-redhat-linuxe5
CPU=i386
RSYNC=/usr/bin/rsync -azpv
include Makefile.rhlinux.common
prework-utils:  rsync-2.5.6  textutils-2.1 

remove-autotool:
	rpm -e --nodeps libtool-1.5.6-4 libtool-libs-1.5.6-4
	rpm -e --nodeps automake-1.9.2-3 automake14-1.4p6-12  automake16-1.6.3-5  automake15-1.5-13
	rpm -e --nodeps autoconf213-2.13-9 autoconf-2.59-5
buildprework: 
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe5/pkgutils-1.5.24-1.rpm.pkg-inst
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe5/sbutils-1.2.7-1.rpm.pkg-inst
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe5/pbutils-1.1.14-1.rpm.pkg-inst
	@mkdir -p /opt/dist/moto/i386 /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOTO!'  {} \;
prework : prework-utils
	@mkdir -p /opt/moto


else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),i686-redhat-linuxe5)
ARCHI=i686-redhat-linuxe5
CPU=i386
RSYNC=/usr/bin/rsync -azpv
include Makefile.rhlinux.common
prework-utils:  rsync-2.5.6  textutils-2.1 

remove-autotool:
	rpm -e --nodeps libtool-1.5.6-4 libtool-libs-1.5.6-4
	rpm -e --nodeps automake-1.9.2-3 automake14-1.4p6-12  automake16-1.6.3-5  automake15-1.5-13
	rpm -e --nodeps autoconf213-2.13-9 autoconf-2.59-5
buildprework: 
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe5/pkgutils-1.5.24-1.rpm.pkg-inst
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe5/sbutils-1.2.7-1.rpm.pkg-inst
#	pkg-inst /net/repository.example.conm/monitorvms_data/netinstall/dist/tww/7.1/support/i686-redhat-linuxe5/pbutils-1.1.14-1.rpm.pkg-inst
	@mkdir -p /opt/dist/moto/i386 /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
twwprework : 
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	perl -pi -e 's!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!/net/ilad2141/monitorvms_data/netinstall/dist/tww/7.1/src!' Makefile*	
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!"rpm"!"rpm4"!'  {} \;
	find . -type f -name pb-db.xml.moto -exec perl -pi -e 's!>TWW!>MOTO!'  {} \;
prework : prework-utils
	@mkdir -p /opt/moto


else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),hppa1.1-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
include Makefile.hp-ux.common
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

else

ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),hppa1.1-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
ZIP=/opt/moto/zip/bin/zip
include Makefile.hp-ux.common
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),hppa2.0-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
include Makefile.hp-ux.common
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),hppa2.0w-hp-hpux11.11)
ARCHI=hppa1.1-hp-hpux11.11
ZIP=/opt/moto/zip/bin/zip
include Makefile.hp-ux.common
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf

else
ifeq ($(shell  /opt/TWWfsw/sbutils13/lib/systype),ia64-hp-hpux11.23)
ARCHI=ia64-hp-hpux11.23
include Makefile.hp-ux.common
buildprework : 
	@mkdir -p /opt/dist/moto/cd  /opt/build /opt/moto
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/build"!"/opt/build"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/dist/cd"!"/opt/dist/moto/cd"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/sbutils13/etc/sbutils.conf
	perl -pi -e 's!"/opt/TWWfsw"!"/opt/moto"!' /opt/TWWfsw/pbutils11/etc/pbutils.conf


else

cantbuild:
	@echo "Error:  $(shell  /opt/TWWfsw/sbutils13/lib/systype) target OS is not supported
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif


# Global functions 
# $(call update-depot-pkg-db,pkgname)
# $1 is the first argument.

#WHAT: for Xymon related pb-db.xml.moto
define update-xymon-depot-pkg-db
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	perl -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${MOTOADDON_SRC}/$1/pb-db.xml.moto > /tmp/tmp.xml
	perl -pi -e 's!^</packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef



#WHAT: for gcc that can't use /opt/build${VER}
define update-xymon-depot-pkg-db-gcc
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	perl -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${MOTOADDON_SRC}/$1/pb-db.xml.moto > /tmp/tmp.xml
	perl -pi -e 's!^</packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef




define update-depot-pkg-db
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	perl -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${SOURCE_DIR}/$1/pb-db.xml.moto > /tmp/tmp.xml
	perl -pi -e 's!^</packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef

#WHAT: for TWW 9.1 src related pb-db.xml.moto
define update-depot-pkg-db-moto
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	perl -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${SOURCE_DIR}/$1/pb-db.xml.moto > /tmp/tmp.xml
	perl -pi -e 's!^</packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef



define update-depot-pkg-db-motoaddon
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	perl -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${MOTOADDON_SRC}/$1/pb-db.xml.moto > /tmp/tmp.xml
	perl -pi -e 's!^</packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef


define update-depot-pkg-db-2.6
	${RSYNC} ${PACKAGE_UPLOAD_PATH}/${ARCHI}/pkg-db.xml /tmp;
	perl -pi -e 's!</packages>!!' /tmp/pkg-db.xml
	${GPD}  ${SOURCE_DIR}/$1/pb-db.xml.moto.2.6 > /tmp/tmp.xml
	perl -pi -e 's!^</packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<packages>!!' /tmp/tmp.xml
	perl -pi -e 's!^<\?xml version="1.0"\?>!!' /tmp/tmp.xml
	cat /tmp/tmp.xml  >> /tmp/pkg-db.xml;rm -f /tmp/tmp.xml
	echo "</packages>" >> /tmp/pkg-db.xml
	${RSYNC} /tmp/pkg-db.xml ${PACKAGE_UPLOAD_PATH}/${ARCHI}/
endef


list:
	@ls ${LOCAL_SOURCE_DIR}
	@echo "buildable packages in ${SOURCE_DIR}"
	@ls ${MOTOADDON_SRC}
	@echo "buildable packages in ${MOTOADDON_SRC}"

create-dir : 
	$(call maybe-mkdir,${SB_DB})
	$(call maybe-mkdir,${BUILD_DIR})
	$(call maybe-mkdir,${DIST_DIR})
remove-dir : 
	$(RM) -rf ${INSTALLBASE} ${BUILD_DIR} ${DIST_DIR}

rebuild-all: remove-dir create-dir allpkg

allpkgs: gcc-4.4.6 perl-5.8.8 sudosh2-1.0.2 hobbit-client-4.2.0 pkgutils-1.6.0

built:
	@ls -lrt ${SB_DB}
	@echo "built in ${SB_DB}"

clean-build:
	rm -f ${BUILD_DIR}/* 
	rm -rf ${SB_DB}/*

clean-dist:
	rm -rf ${DISTPFX}/*

