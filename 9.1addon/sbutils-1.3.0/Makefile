# -----------------------------------------------------------------------------
#     G N U    M A K E F I L E   S C R I P T   S P E C I F I C A T I O N
# -----------------------------------------------------------------------------
#
# NAME
#       Makefile   - a Makefile to bootstrap TWW HPMS toolsets.
#
# REVISION HISTORY
#       07/03/2003 T.J. Yang original.
#       04/16/2004 T.J. Yang enable distcc to improve the compilation time.
#       10/02/2011 T.J. Yang, migrate to 10.7.1 Lion OS X. 
#
# USAGE
#       make clean;make
#       make build
#       make pkg
#
# DESCRIPTION
#        
#       The purpose of this makefile script is to bootstrap TWW HPMS tools.
#       sbutils,pbutils and pkgutils will all be generated.
#  sb is a software build tool by parsing build receipts in xml file format.     
#       patch : for patching patch files in sb-db.xml
#       make  : for making software in <build></build> tag.
#       tar   : untar 
#       texinfo: why ?
# TO DOs
#  1. Generate Native pacakges on a platform.       
#  2. turn this script into a sh script instead of makefile.

# ---------------------------- CONSTANT DECLARATION ---------------------------
#

# WHAT: Define constant for sbutils build
INSTALL_PREFIX=/tmp/bd
PKGMKR=/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker
program_name=sbutils
version=1.3.0
revision="1"
TMP=./tmp

# WHAT: Define constant according to different OS type.
ifeq ($(shell ./systype),x86_64-redhat-linuxe6)
BuildDir=${TMP}/build
PKGNAME=${program_name}-${version}.pkg
build_name=${program_name}-${version}
install_name=${program_name}130
GMAKE=/usr/bin/make
# configure distcc 
SET_DISTCC_HOSTS=DISTCC_HOSTS='imac'
SETCC=CC='/usr/bin/distcc /usr/bin/gcc'
CC=/usr/bin/gcc
GPATCH=/usr/bin/patch
BZIP2=/usr/bin/bzip2
GZIP=/bin/gzip
CFLAGS="-O2"
CC_LD_RT="-Wl,-rpath," 
LDFLAGS=""
CONFIGURE=./configure 

else
ifeq ($(shell ./systype),sparc-sun-solaris2.8)
else
ifeq ($(shell ./systype),sparc-sun-solaris2.9)
ARCHI=sparc-sun-solaris2.9
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
else
ifeq ($(shell ./systype),sparc-sun-solaris2.10)
ARCHI=sparc-sun-solaris2.10
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
else
ifeq ($(shell ./systype),sparc-sun-solaris2.11)
ARCHI=sparc-sun-solaris2.10
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
else
ifeq ($(shell ./systype),i386-pc-solaris2.10)
ARCHI=i386-pc-solaris2.10
PERLARCH=i86pc-solaris-thread-multi
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
else
ifeq ($(shell ./systype),i386-pc-solaris2.11)
ARCHI=i386-pc-solaris2.11
RSYNC=/opt/moto/rsync26/bin/rsync -azpv 
else
ifeq ($(shell ./systype),i686-redhat-linux7.3)
ARCHI=i686-redhat-linux7.3
CPU=i386
else
ifeq ($(shell ./systype),i686-redhat-linux9)
ARCHI=i686-redhat-linux9
CPU=i386
else
ifeq ($(shell ./systype),i686-redhat-linuxe3)
RSYNC=/usr/bin/rsync -azpv
ARCHI=i686-redhat-linuxe3
CPU=i386
else
ifeq ($(shell ./systype),x86_64-redhat-linuxe3)
ARCHI=x86_64-redhat-linuxe3
CPU=x86_64
else
ifeq ($(shell ./systype),x86_64-redhat-linuxe4)
ARCHI=x86_64-redhat-linuxe4
CPU=x86_64
else
ifeq ($(shell ./systype),x86_64-redhat-linuxe6)
ARCHI=x86_64-redhat-linuxe6
CPU=x86_64
RSYNC=/usr/bin/rsync -azpv
else

ifeq ($(shell ./systype),i686-redhat-linuxe4)
ARCHI=i686-redhat-linuxe4
CPU=i386
RSYNC=/usr/bin/rsync -azpv
else
ifeq ($(shell ./systype),i686-redhat-linuxe4)
ARCHI=i686-redhat-linuxe4
CPU=i386
RSYNC=/usr/bin/rsync -azpv
else
ifeq ($(shell ./systype),hppa1.1-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
else
ifeq ($(shell ./systype),i686-redhat-linuxe5)
ARCHI=i686-redhat-linuxe5
CPU=i386
RSYNC=/usr/bin/rsync -azpv
else
ifeq ($(shell ./systype),i686-redhat-linuxe5)
ARCHI=i686-redhat-linuxe5
CPU=i386
RSYNC=/usr/bin/rsync -azpv
else
ifeq ($(shell ./systype),hppa1.1-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
else

ifeq ($(shell ./systype),hppa1.1-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
ZIP=/opt/moto/zip/bin/zip
else
ifeq ($(shell ./systype),hppa2.0-hp-hpux10.20)
ARCHI=hppa1.1-hp-hpux10.20
else
ifeq ($(shell ./systype),hppa2.0w-hp-hpux11.11)
ARCHI=hppa1.1-hp-hpux11.11
ZIP=/opt/moto/zip/bin/zip
else
ifeq ($(shell ./systype),ia64-hp-hpux11.23)
ARCHI=ia64-hp-hpux11.23
else

cantbuild:
	@echo "Error:  $(shell ./systype) target OS is not supported"
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




# ---------------------------- VARIABLE DECLARATION ---------------------------

SRCS=PyXML-0.8.3.tar.gz  expat-1.95.6.patch  grep-2.5.1.patch  openssl-0.9.7b.tar.gz  tar-1.15.tar.bz2 \
Python-2.3.2.patch  expat-1.95.6.tar.gz  grep-2.5.1.tar.bz2  patch-2.5.8.tar.gz  texinfo-4.13.patch \
Python-2.3.2.tar.bz2  fileutils-4.1.7.patch  gzip-1.3.5.tar.gz  python-fchksum-1.7.patch texinfo-4.13a.tar.gz \
bash-2.05b.patch  fileutils-4.1.7.tar.bz2  make-3.81.patch  python-fchksum-1.7.tar.gz	zlib-1.2.3-tww.tar.gz \
bash-2.05b.tar.gz  findutils-4.1.20.patch  make-3.81.tar.bz2  sbutils-1.2.8.tar.bz2 \
bzip2-1.0.2-tww.tar.gz  findutils-4.1.20.tar.gz  openssl-0.9.7b.patch  tar-1.13.25.patch






# **************************** MAIN TARGETS ************************************
#
#

all: sb sbinit gensbpkg sbimg

sb:  aux python  openssl ggrep sbutils128

#utils: gpatch gmake gzip bzip2 gtar texinfo bash  zlib expat cpio sed 
#utils: gpatch gmake bzip2 gtar texinfo bash  zlib expat cpio sed 
#################################################################################
#
#  , default,  , gnutls,  
#  libgcrypt, libgpg-error, libssh2, libtasn1, libxml, libxslt, 
#  lxml, opencdk, openssl, pth, pycurl, python, python-fchksum, 
# has errors: gzip curl      
#################################################################################

aux: gpatch gmake gtar texinfo bash zlib cpio sed ggrep gunzip \
     findutils coreutils gawk bzip2

python:  python252 python-fchksum PyXML 

pythonclean:  python252-clean 

clean: cleanbinary cleansrc cleantmp
cleanbinary:
	rm -rf ${INSTALL_PREFIX}/${install_name}
cleansrc:
	rm -f  *~ build.out.txt
cleantmp:
	rm -rf ${BuildDir}/*



# ---------------------------- SUB TARGETS -----------------------------------------
#################################################################################
module_name_shtool=shtool
build_name_shtool=shtool-2.0.2
install_name_shtool=${install_name}/lib/aux/shtool
INSTALL_PREFIX_shtool=${INSTALL_PREFIX}/${install_name_shtool}
shtool: ${INSTALL_PREFIX_shtool}

${INSTALL_PREFIX_shtool}:
#unpack source ball
	rm -rf ${BuildDir}/shtool-2.0.2
	${GZIP} -dc src/shtool-2.0.2.tar.gz | tar xvf - -C ${BuildDir}
# patch it

#configure 
	(cd ${BuildDir}/shtool-2.0.2;\
        ${CONFIGURE} --program-prefix=g --prefix=${INSTALL_PREFIX_shtool};${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_shtool}/man \
        )

#################################################################################
module_name_sed=sed
build_name_sed=sed-4.1.5
install_name_sed=${install_name}/lib/aux/sed
path_sed=src/sed-4.1.5.tar.gz
patch1_path_sed=src/sed-4.1.5.auto.patch    
patch2_path_sed=src/sed-4.1.5.tww.patch
patch3_path_sed=src/sed-4.1.5.gnulib.patch  
patch4_path_sed=src/sed-4.1.5.tww-gnulib.patch
patch1_sed=sed-4.1.5.auto.patch    
patch2_sed=sed-4.1.5.tww.patch
patch3_sed=sed-4.1.5.gnulib.patch  
patch4_sed=sed-4.1.5.tww-gnulib.patch

INSTALL_PREFIX_sed=${INSTALL_PREFIX}/${install_name_sed}
sed: ${INSTALL_PREFIX_sed}

sed-clean:
	rm -rf  ${INSTALL_PREFIX_sed}

${INSTALL_PREFIX_sed}:
#unpack source ball
	rm -rf ${BuildDir}/sed-4.1.5
	${GZIP} -dc src/sed-4.1.5.tar.gz | tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_sed} ${BuildDir}/${build_name_sed};cd ${BuildDir}/${build_name_sed};${GPATCH} -p0 < ${patch1_sed})
	(cp ${patch2_path_sed} ${BuildDir}/${build_name_sed};cd ${BuildDir}/${build_name_sed};${GPATCH} -p0 < ${patch2_sed})
	(cp ${patch3_path_sed} ${BuildDir}/${build_name_sed};cd ${BuildDir}/${build_name_sed};${GPATCH} -p0 < ${patch3_sed})
	(cp ${patch4_path_sed} ${BuildDir}/${build_name_sed};cd ${BuildDir}/${build_name_sed};${GPATCH} -p0 < ${patch4_sed})
#configure 
	(cd ${BuildDir}/sed-4.1.5;\
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  --program-prefix=g --prefix=${INSTALL_PREFIX_sed};\
        ${GMAKE}  ;\
        ${GMAKE} install;\
        rm -rf ${INSTALL_PREFIX_sed}/man \
        )


#################################################################################
module_name_curl=curl
build_name_curl=curl-7.19.6
install_name_curl=${install_name}/lib/aux/curl
path_curl=src/curl-7.19.6.tar.bz2
patch1_path_curl=src/curl-7.19.6.auto.patch  
patch2_path_curl=src/curl-7.19.6.tww.patch

INSTALL_PREFIX_curl=${INSTALL_PREFIX}/${install_name_curl}
curl: ${INSTALL_PREFIX_curl}

curl-clean:
	rm -rf  ${INSTALL_PREFIX_curl} 	${BuildDir}/${build_name_curl}

${INSTALL_PREFIX_curl}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_curl}
	${BZIP2} -dc ${path_curl} | tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_curl} ${BuildDir}/${build_name_curl};cd ${BuildDir}/${build_name_curl};${GPATCH} -p0 < ${patch1_curl})
	(cp ${patch2_path_curl} ${BuildDir}/${build_name_curl};cd ${BuildDir}/${build_name_curl};${GPATCH} -p0 < ${patch2_curl})
#configure 
	(cd ${BuildDir}/curl-4.1.5;\
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  --program-prefix=g --prefix=${INSTALL_PREFIX_curl};\
        ${GMAKE}  ;\
        ${GMAKE} install;\
        rm -rf ${INSTALL_PREFIX_curl}/man \
        )


#################################################################################
module_name_cpio=cpio
build_name_cpio=cpio-2.9
install_name_cpio=${install_name}/lib/aux/cpio
path_cpio=src/cpio-2.9.tar.bz2  
patch1_path_cpio=src/cpio-2.9.auto.patch  
patch2_path_cpio=src/cpio-2.9.gnulib.patch  
patch3_path_cpio=src/cpio-2.9.tww.patch
patch1_cpio=cpio-2.9.auto.patch  
patch2_cpio=cpio-2.9.gnulib.patch  
patch3_cpio=cpio-2.9.tww.patch

INSTALL_PREFIX_cpio=${INSTALL_PREFIX}/${install_name_cpio}

cpio: ${INSTALL_PREFIX_cpio}

${INSTALL_PREFIX_cpio}:
#unpack source ball
	rm -rf ${BuildDir}/cpio-2.9
	${BZIP2} -dc src/cpio-2.9.tar.bz2 | tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch2_path_cpio} ${BuildDir}/${build_name_cpio};cd ${BuildDir}/${build_name_cpio};${GPATCH} -p0 < ${patch2_cpio})
	(cp ${patch3_path_cpio} ${BuildDir}/${build_name_cpio};cd ${BuildDir}/${build_name_cpio};${GPATCH} -p0 < ${patch3_cpio})
	(cp ${patch1_path_cpio} ${BuildDir}/${build_name_cpio};cd ${BuildDir}/${build_name_cpio};${GPATCH} -p0 < ${patch1_cpio})

#configure 
	(cd ${BuildDir}/cpio-2.9;\
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} --program-prefix=g --prefix=${INSTALL_PREFIX_cpio};\
        ${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_cpio}/man \
        )





#################################################################################
module_name_gunzip=gunzip
build_name_gunzip=unzip-5.52
install_name_gunzip=${install_name}/lib/aux/gunzip
path_gunzip=src/unzip552.tar.gz
patch1_path_gunzip=src/unzip-5.52.CVE-2005-2475.patch  
patch2_path_gunzip=src/unzip-5.52.CVE-2008-0888.patch	
patch3_path_gunzip=src/unzip-5.52.tww.patch
patch1_gunzip=unzip-5.52.CVE-2005-2475.patch  
patch2_gunzip=unzip-5.52.CVE-2008-0888.patch	
patch3_gunzip=unzip-5.52.tww.patch

INSTALL_PREFIX_gunzip=${INSTALL_PREFIX}/${install_name_gunzip}
gunzip: ${INSTALL_PREFIX_gunzip}
gunzip-clean:
	rm -rf  ${INSTALL_PREFIX_gunzip} ${BuildDir}/grep-2.5.1
${INSTALL_PREFIX_gunzip}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_gunzip}
	${GZIP} -dc ${path_gunzip} | tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_gunzip} ${BuildDir}/${build_name_gunzip};cd ${BuildDir}/${build_name_gunzip};${GPATCH} -p0 < ${patch1_gunzip})
	(cp ${patch2_path_gunzip} ${BuildDir}/${build_name_gunzip};cd ${BuildDir}/${build_name_gunzip};${GPATCH} -p0 < ${patch2_gunzip})
	(cp ${patch3_path_gunzip} ${BuildDir}/${build_name_gunzip};cd ${BuildDir}/${build_name_gunzip};${GPATCH} -p0 < ${patch3_gunzip})
#configure 
	(cd ${BuildDir}/grep-2.5.1;\
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} --program-prefix=g --prefix=${INSTALL_PREFIX_gunzip};\
        ${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_gunzip}/man \
        )

#################################################################################
module_name_ggrep=ggrep
build_name_ggrep=grep-2.5.1
install_name_ggrep=${install_name}/lib/aux/grep
path_ggrep=src/grep-2.5.1.tar.bz2  
patch1_path_ggrep=src/grep-2.5.1.tww.patch
patch2_path_ggrep=src/grep-2.5.1.auto.patch  
patch1_ggrep=grep-2.5.1.tww.patch
patch2_ggrep=grep-2.5.1.auto.patch  
INSTALL_PREFIX_ggrep=${INSTALL_PREFIX}/${install_name_ggrep}
ggrep: ${INSTALL_PREFIX_ggrep}
ggrep-clean:
	rm -rf  ${INSTALL_PREFIX_ggrep} ${BuildDir}/grep-2.5.1
${INSTALL_PREFIX_ggrep}:
#unpack source ball
	rm -rf ${BuildDir}/grep-2.5.1
	${BZIP2} -dc src/grep-2.5.1.tar.bz2 | tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_ggrep} ${BuildDir}/${build_name_ggrep};cd ${BuildDir}/${build_name_ggrep};${GPATCH} -p0 < ${patch1_ggrep})
	(cp ${patch2_path_ggrep} ${BuildDir}/${build_name_ggrep};cd ${BuildDir}/${build_name_ggrep};${GPATCH} -p0 < ${patch2_ggrep})

#configure 
	(cd ${BuildDir}/grep-2.5.1;\
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} --program-prefix=g --prefix=${INSTALL_PREFIX_ggrep};\
        ${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_ggrep}/man \
        )



#################################################################################
module_name_gpatch=gpatch
build_name_gpatch=patch-2.5.8
install_name_gpatch=${install_name}/lib/aux/gpatch25
INSTALL_PREFIX_gpatch=${INSTALL_PREFIX}/${install_name_gpatch}
gpatch: ${INSTALL_PREFIX_gpatch}

${INSTALL_PREFIX_gpatch}:
#unpack source ball
	rm -rf ${BuildDir}/patch-2.5.8
	gzip -dc src/patch-2.5.8.tar.gz | tar xvf - -C ${BuildDir}
# patch it

#configure 
	(cd ${BuildDir}/patch-2.5.8; ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  --program-prefix=g --prefix=${INSTALL_PREFIX_gpatch};${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_gpatch}/man \
        )

#################################################################################
Module_name_gmake=gmake
install_name_gmake=${install_name}/lib/aux/gmake
build_name_gmake=make-3.81
path_gmake=src/make-3.81.tar.bz2
patch_path_gmake=src/make-3.81.patch
patch_gmake=make-3.81.patch
INSTALL_PREFIX_gmake=${INSTALL_PREFIX}/${install_name_gmake}

gmake: gpatch ${INSTALL_PREFIX_gmake}

${INSTALL_PREFIX_gmake}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_gmake}
	${BZIP2} -dc ${path_gmake} | tar xvf - -C ${BuildDir}
# patch it
#	(cp ${patch_path_gmake} ${BuildDir}/${build_name_gmake};cd ${BuildDir}/${build_name_gmake};${GPATCH} -p0 < ${patch_gmake} )
#configure 
	(cd ${BuildDir}/make-3.81; ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} --program-prefix=g --prefix=${INSTALL_PREFIX_gmake};${GMAKE} ;${GMAKE} install; \
         rm -rf ${INSTALL_PREFIX_gmake}/info ${INSTALL_PREFIX_gmake}/man ${INSTALL_PREFIX_gmake}/share)


#################################################################################
module_name_gzip=gzip
build_name_gzip=gzip-1.3.12
install_name_gzip=${install_name}/lib/aux/gzip13

path_gzip=src/gzip-1.3.12.tar.gz
patch1_path_gzip=src/gzip-1.3.12.tww.patch
patch2_path_gzip=src/gzip-1.3.12.CVE-2006-4338.patch
patch3_path_gzip=src/gzip-1.3.12.CVE-2006-4337.patch
patch1_gzip=gzip-1.3.12.tww.patch
patch2_gzip=gzip-1.3.12.CVE-2006-4338.patch
patch3_gzip=gzip-1.3.12.CVE-2006-4337.patch

INSTALL_PREFIX_gzip=${INSTALL_PREFIX}/${install_name_gzip}

gzip:${INSTALL_PREFIX_gzip}
gzip-clean:
	rm -rf ${INSTALL_PREFIX_gzip} ${BuildDir}/${build_name_gzip}

CFGOPT="--disable-dependency-tracking    --disable-nls "
${INSTALL_PREFIX_gzip}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_gzip}
	gzip -dc ${path_gzip}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_gzip} ${BuildDir}/${build_name_gzip};cd ${BuildDir}/${build_name_gzip};${GPATCH} -p0 < ${patch1_gzip})
	(cp ${patch2_path_gzip} ${BuildDir}/${build_name_gzip};cd ${BuildDir}/${build_name_gzip};${GPATCH} -p0 < ${patch2_gzip})
	(cp ${patch3_path_gzip} ${BuildDir}/${build_name_gzip};cd ${BuildDir}/${build_name_gzip};${GPATCH} -p0 < ${patch3_gzip})

#configure  
	(cd ${BuildDir}/${build_name_gzip}; \
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  \
        --prefix=${INSTALL_PREFIX_gzip};\
        ${GMAKE};\
        ${GMAKE}install; \
        rm -rf ${INSTALL_PREFIX_gzip}/info ${INSTALL_PREFIX_gzip}/man)

#################################################################################
module_name_bzip2=bzip2
build_name_bzip2=bzip2-1.0.5
install_name_bzip2=${install_name}/lib/aux/bzip2
INSTALL_PREFIX_bzip2=${INSTALL_PREFIX}/${install_name_bzip2}

path_bzip2=src/bzip2-1.0.5.tar.gz
patch1_path_bzip2=src/bzip2-1.0.5.auto.patch  
patch2_path_bzip2=src/bzip2-1.0.5.tww.patch
patch1_bzip2=bzip2-1.0.5.auto.patch  
patch2_bzip2=bzip2-1.0.5.tww.patch

bzip2: ${INSTALL_PREFIX_bzip2}
bzip2-clean:
	rm -rf ${INSTALL_PREFIX_bzip2} ${BuildDir}/${build_name_bzip2}

${INSTALL_PREFIX_bzip2}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_bzip2}
	gzip -dc ${path_bzip2}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_bzip2} ${BuildDir}/${build_name_bzip2};cd ${BuildDir}/${build_name_bzip2};${GPATCH} -p0 < ${patch1_bzip2})
	(cp ${patch2_path_bzip2} ${BuildDir}/${build_name_bzip2};cd ${BuildDir}/${build_name_bzip2};${GPATCH} -p0 < ${patch2_bzip2})
#configure 
	(cd ${BuildDir}/${build_name_bzip2};\
         ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} \
         --enable-shared --enable-static --disable-dependency-tracking \
         --prefix=${INSTALL_PREFIX_bzip2}; \
         ${GMAKE} install; \
         rm -rf ${INSTALL_PREFIX_bzip2}/bin/bzip2recover \
         ${INSTALL_PREFIX_bzip2}/info ${INSTALL_PREFIX_bzip2}/man \
        )

#################################################################################
module_name_expat=expat
build_name_expat=expat-1.95.8
install_name_expat=${install_name}/lib/aux/libexpat
path_expat=src/expat-1.95.8.tar.gz
patch_path_expat=src/expat-1.95.8.patch
patch_expat=expat-1.95.8.patch
INSTALL_PREFIX_expat=${INSTALL_PREFIX}/${install_name_expat}

expat: ${INSTALL_PREFIX_expat}

${INSTALL_PREFIX_expat}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_expat}
	gzip -dc ${path_expat}| tar xvf - -C ${BuildDir}
# patch it
	(\
        cp ${patch_path_expat} ${BuildDir}/${build_name_expat};\
        cd ${BuildDir}/${build_name_expat};${GPATCH} -p0 < ${patch_expat} \
        )
#configure 
	(cd ${BuildDir}/${build_name_expat}; \
          rm -f config.cache; \
          ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  CFLAGS="${CFLAGS:--O2}"${LDFLAGS+LDFLAGS="${LDFLAGS}"} \
         --enable-shared --enable-static --prefix=${INSTALL_PREFIX}/${install_name_expat};\
         ${GMAKE} install;\
         rm -rf ${INSTALL_PREFIX}/bin ${INSTALL_PREFIX}/man ;\
         )

#################################################################################
module_name_fileutils=fileutils
build_name_fileutils=fileutils-4.1.7
install_name_fileutils=${install_name}/lib/aux/fileutils41
path_fileutils=src/fileutils-4.1.7.tar.bz2
path_patch_fileutils=src/fileutils-4.1.7.patch
patch_fileutils=fileutils-4.1.7.patch
INSTALL_PREFIX_fileutils=${INSTALL_PREFIX}/${install_name_fileutils}

fileutils: ${INSTALL_PREFIX_fileutils}

fileutilsclean: 
	rm -rf ${INSTALL_PREFIX_fileutils}

${INSTALL_PREFIX_fileutils}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_fileutils}
	${BZIP2} -dc ${path_fileutils}| tar xvf - -C ${BuildDir}
# patch it
	(\
        cp ${path_patch_fileutils} ${BuildDir}/${build_name_fileutils};\
        cd ${BuildDir}/${build_name_fileutils};${GPATCH} -p0 < ${patch_fileutils} \
        )

#<dependencies> <depend var="PERL">perl561</depend></dependencies>
#configure 
	(cd ${BuildDir}/${build_name_fileutils}; \
	 ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} --disable-nls --program-prefix=g \
         --disable-dependency-tracking --prefix=${INSTALL_PREFIX_fileutils};\
        ${GMAKE};${GMAKE} install \
         )
#################################################################################
module_name_findutils=findutils
build_name_findutils=findutils-4.4.0
install_name_findutils=${install_name}/lib/aux/findutils44
path_findutils=src/findutils-4.4.0.tar.gz
patch1_path_findutils=src/findutils-4.4.0.auto.patch	
patch2_path_findutils=src/findutils-4.4.0.gnulib.patch  
patch3_path_findutils=src/findutils-4.4.0.tww.patch
patch1_findutils=findutils-4.4.0.auto.patch	
patch2_findutils=findutils-4.4.0.gnulib.patch  
patch3_findutils=findutils-4.4.0.tww.patch

findutils: ${INSTALL_PREFIX}/${install_name_findutils}

findutilsclean: 
	rm -rf ${INSTALL_PREFIX}/${install_name_findutils} ${BuildDir}/${build_name_findutils}

${INSTALL_PREFIX}/${install_name_findutils}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_findutils}
	${GZIP} -dc ${path_findutils}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_findutils} ${BuildDir}/${build_name_findutils};cd ${BuildDir}/${build_name_findutils};${GPATCH} -p0 < ${patch1_findutils})
	(cp ${patch2_path_findutils} ${BuildDir}/${build_name_findutils};cd ${BuildDir}/${build_name_findutils};${GPATCH} -p0 < ${patch2_findutils})
	(cp ${patch3_path_findutils} ${BuildDir}/${build_name_findutils};cd ${BuildDir}/${build_name_findutils};${GPATCH} -p0 < ${patch3_findutils})

#configure 
	(cd ${BuildDir}/${build_name_findutils}; \
         ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  --disable-dependency-tracking \
        --program-prefix=g --prefix=${INSTALL_PREFIX}/${install_name_findutils} \
        --infodir=${INSTALL_PREFIX}/${install_name_findutils}/info \
        --mandir=${INSTALL_PREFIX}/${install_name_findutils}/man ; \
        ${GMAKE}; \
        ${GMAKE} install; \
        rm -rf ${INSTALL_PREFIX}/${install_name_findutils}/var ${INSTALL_PREFIX}/${install_name_findutils}/libexec {INSTALL_PREFIX}/${install_name_findutils}/bin/glocate ${INSTALL_PREFIX}/${install_name_findutils}/bin/gupdatedb ${INSTALL_PREFIX}/${install_name_findutils}/man ${INSTALL_PREFIX}/${install_name_findutils}/info;\
        )

#################################################################################
module_name_autoconf=autoconf
build_name_autoconf=autoconf-2.57
install_name_autoconf=${install_name}/lib/aux/autoconf
path_autoconf=src/autoconf-2.57.tar.gz
patch_path_autoconf=src/autoconf-2.57.patch
patch_autoconf=autoconf-2.57.patch
INSTALL_PREFIX_autoconf=${INSTALL_PREFIX}/${install_name_autoconf}

autoconf: ${INSTALL_PREFIX_autoconf}

${INSTALL_PREFIX_autoconf}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_autoconf}
	gzip -dc ${path_autoconf}| tar xvf - -C ${BuildDir}

# patch it
	(\
        cp ${patch_path_autoconf} ${BuildDir}/${build_name_autoconf};\
        cd ${BuildDir}/${build_name_autoconf};${GPATCH} -p0 < ${patch_autoconf} \
        )

#configure 
	(cd ${BuildDir}/${build_name_autoconf}; \
         rm -f config.cache; \
          ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  CFLAGS="${CFLAGS:--O2}" --program-prefix=g --disable-dependency-tracking --prefix=${INSTALL_PREFIX_autoconf};\
         ${GMAKE} install;\
         rm -rf ${INSTALL_PREFIX_autoconf}/info ${INSTALL_PREFIX_autoconf}/lib ${INSTALL_PREFIX_autoconf}/libexec ${INSTALL_PREFIX_autoconf}/man ${INSTALL_PREFIX_autoconf}/share;\
        )



#################################################################################
module_name_gtar=gtar
build_name_gtar=tar-1.20
install_name_gtar=${install_name}/lib/aux/gtar
path_gtar=src/tar-1.20.tar.bz2
patch1_path_gtar=src/tar-1.20.auto.patch    
patch2_path_gtar=src/tar-1.20.tww.patch
patch3_path_gtar=src/tar-1.20.gnulib.patch  
patch4_path_gtar=src/tar-1.20.tww-gnulib.patch
patch1_gtar=tar-1.20.auto.patch    
patch2_gtar=tar-1.20.tww.patch
patch3_gtar=tar-1.20.gnulib.patch  
patch4_gtar=tar-1.20.tww-gnulib.patch

INSTALL_PREFIX_gtar=${INSTALL_PREFIX}/${install_name_gtar}

gtar: ${INSTALL_PREFIX_gtar}

${INSTALL_PREFIX_gtar}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_gtar}
	${BZIP2} -dc ${path_gtar}| tar xvf - -C ${BuildDir}

# patch it
	(cp ${patch1_path_gtar} ${BuildDir}/${build_name_gtar};cd ${BuildDir}/${build_name_gtar};${GPATCH} -p0 < ${patch1_gtar})
	(cp ${patch2_path_gtar} ${BuildDir}/${build_name_gtar};cd ${BuildDir}/${build_name_gtar};${GPATCH} -p0 < ${patch2_gtar})
	(cp ${patch3_path_gtar} ${BuildDir}/${build_name_gtar};cd ${BuildDir}/${build_name_gtar};${GPATCH} -p0 < ${patch3_gtar})
	(cp ${patch4_path_gtar} ${BuildDir}/${build_name_gtar};cd ${BuildDir}/${build_name_gtar};${GPATCH} -p0 < ${patch4_gtar})

#configure 
	(cd ${BuildDir}/${build_name_gtar}; \
         rm -f config.cache; \
         ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} \
         --program-prefix=g --disable-dependency-tracking --prefix=${INSTALL_PREFIX_gtar};\
         ${GMAKE};\
         ${GMAKE} install;\
         rm -rf ${INSTALL_PREFIX_gtar}/info ${INSTALL_PREFIX_gtar}/lib ${INSTALL_PREFIX_gtar}/libexec ${INSTALL_PREFIX_gtar}/man ${INSTALL_PREFIX_gtar}/share;\
        )

#################################################################################
module_name_bash=bash
build_name_bash=bash-3.2
install_name_bash=${install_name}/lib/aux/bash
path_bash=src/bash-3.2.tar.gz

patch01_path_bash=src/bash-3.2.001.patch		
patch02_path_bash=src/bash-3.2.002.patch		
patch03_path_bash=src/bash-3.2.003.patch		
patch04_path_bash=src/bash-3.2.004.patch		
patch05_path_bash=src/bash-3.2.005.patch		
patch06_path_bash=src/bash-3.2.006.patch		
patch07_path_bash=src/bash-3.2.007.patch	
patch08_path_bash=src/bash-3.2.008.patch	
patch09_path_bash=src/bash-3.2.009.patch	
patch10_path_bash=src/bash-3.2.010.patch	
patch11_path_bash=src/bash-3.2.011.patch	
patch12_path_bash=src/bash-3.2.012.patch	
patch13_path_bash=src/bash-3.2.013.patch	
patch14_path_bash=src/bash-3.2.014.patch	
patch15_path_bash=src/bash-3.2.015.patch	
patch16_path_bash=src/bash-3.2.016.patch	
patch17_path_bash=src/bash-3.2.017.patch	
patch18_path_bash=src/bash-3.2.018.patch	
patch19_path_bash=src/bash-3.2.019.patch	
patch20_path_bash=src/bash-3.2.020.patch	
patch21_path_bash=src/bash-3.2.021.patch	
patch22_path_bash=src/bash-3.2.022.patch	
patch23_path_bash=src/bash-3.2.023.patch	
patch24_path_bash=src/bash-3.2.024.patch	
patch25_path_bash=src/bash-3.2.025.patch	
patch26_path_bash=src/bash-3.2.026.patch	
patch27_path_bash=src/bash-3.2.027.patch	
patch28_path_bash=src/bash-3.2.028.patch
patch29_path_bash=src/bash-3.2.029.patch
patch30_path_bash=src/bash-3.2.030.patch
patch31_path_bash=src/bash-3.2.031.patch
patch32_path_bash=src/bash-3.2.032.patch
patch33_path_bash=src/bash-3.2.033.patch
patch34_path_bash=src/bash-3.2.034.patch
patch35_path_bash=src/bash-3.2.035.patch
patch36_path_bash=src/bash-3.2.036.patch
patch37_path_bash=src/bash-3.2.037.patch	 
patch38_path_bash=src/bash-3.2.038.patch	 
patch39_path_bash=src/bash-3.2.039.patch	 
patch40_path_bash=src/bash-3.2.auto.patch	 
patch41_path_bash=src/bash-3.2.tww.patch   
patch01_bash=bash-3.2.001.patch		
patch02_bash=bash-3.2.002.patch		
patch03_bash=bash-3.2.003.patch		
patch04_bash=bash-3.2.004.patch		
patch05_bash=bash-3.2.005.patch		
patch06_bash=bash-3.2.006.patch		
patch07_bash=bash-3.2.007.patch	
patch08_bash=bash-3.2.008.patch	
patch09_bash=bash-3.2.009.patch	
patch10_bash=bash-3.2.010.patch	
patch11_bash=bash-3.2.011.patch	
patch12_bash=bash-3.2.012.patch	
patch13_bash=bash-3.2.013.patch	
patch14_bash=bash-3.2.014.patch	
patch15_bash=bash-3.2.015.patch	
patch16_bash=bash-3.2.016.patch	
patch17_bash=bash-3.2.017.patch	
patch18_bash=bash-3.2.018.patch	
patch19_bash=bash-3.2.019.patch	
patch20_bash=bash-3.2.020.patch	
patch21_bash=bash-3.2.021.patch	
patch22_bash=bash-3.2.022.patch	
patch23_bash=bash-3.2.023.patch	
patch24_bash=bash-3.2.024.patch	
patch25_bash=bash-3.2.025.patch	
patch26_bash=bash-3.2.026.patch	
patch27_bash=bash-3.2.027.patch	
patch28_bash=bash-3.2.028.patch
patch29_bash=bash-3.2.029.patch
patch30_bash=bash-3.2.030.patch
patch31_bash=bash-3.2.031.patch
patch32_bash=bash-3.2.032.patch
patch33_bash=bash-3.2.033.patch
patch34_bash=bash-3.2.034.patch
patch35_bash=bash-3.2.035.patch
patch36_bash=bash-3.2.036.patch
patch37_bash=bash-3.2.037.patch	 
patch38_bash=bash-3.2.038.patch	 
patch39_bash=bash-3.2.039.patch	 
patch40_bash=bash-3.2.auto.patch	 
patch41_bash=bash-3.2.tww.patch   


INSTALL_PREFIX_bash=${INSTALL_PREFIX}/${install_name_bash}

bash: ${INSTALL_PREFIX_bash}

bashclean:
	rm -rf ${INSTALL_PREFIX_bash}

${INSTALL_PREFIX_bash}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_bash}
	gzip -dc ${path_bash}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch01_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch01_bash})
	(cp ${patch02_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch02_bash})
	(cp ${patch03_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch03_bash})
	(cp ${patch04_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch04_bash})
	(cp ${patch05_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch05_bash})
	(cp ${patch06_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch06_bash})
	(cp ${patch07_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch07_bash})
	(cp ${patch08_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch08_bash})
	(cp ${patch09_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch09_bash})
	(cp ${patch10_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch10_bash})
	(cp ${patch11_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch11_bash})
	(cp ${patch12_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch12_bash})
	(cp ${patch13_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch13_bash})
	(cp ${patch14_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch14_bash})
	(cp ${patch15_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch15_bash})
	(cp ${patch16_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch16_bash})
	(cp ${patch17_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch17_bash})
	(cp ${patch18_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch18_bash})
	(cp ${patch19_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch19_bash})
	(cp ${patch20_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch20_bash})
	(cp ${patch21_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch21_bash})
	(cp ${patch22_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch22_bash})
	(cp ${patch23_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch23_bash})
	(cp ${patch24_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch24_bash})
	(cp ${patch25_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch25_bash})
	(cp ${patch26_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch26_bash})
	(cp ${patch27_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch27_bash})
	(cp ${patch28_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch28_bash})
	(cp ${patch29_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch29_bash})
	(cp ${patch30_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch30_bash})
	(cp ${patch31_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch31_bash})
	(cp ${patch32_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch32_bash})
	(cp ${patch33_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch33_bash})
	(cp ${patch34_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch34_bash})
	(cp ${patch35_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch35_bash})
	(cp ${patch36_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch36_bash})
	(cp ${patch37_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch37_bash})
	(cp ${patch38_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch38_bash})
	(cp ${patch39_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch39_bash})
	(cp ${patch40_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch40_bash})
	(cp ${patch41_path_bash} ${BuildDir}/${build_name_bash};cd ${BuildDir}/${build_name_bash};${GPATCH} -p0 < ${patch41_bash})

# configure
	(cd ${BuildDir}/${build_name_bash}; \
rm -f config.cache;\
 ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}   --enable-alias \
--enable-array-variables --enable-bang-history \
--enable-brace-expansion --enable-command-timing \
--enable-cond-command --enable-directory-stack --enable-dparen-arithmetic \
--enable-extended-glob --enable-help-builtin --enable-history \
--enable-job-control --enable-process-substitution \
--enable-rprompt-string-decoding --disable-readline \
--enable-restricted --enable-progcomp --disable-largefile \
--infodir=${INSTALL_PREFIX_bash}/info \
${ARGS+${ARGS}} --prefix=${INSTALL_PREFIX_bash};\
${GMAKE};\
${GMAKE} install;)




#################################################################################
module_name_texinfo=texinfo
build_name_texinfo=texinfo-4.13
install_name_texinfo=${install_name}/lib/aux/texinfo413
path_texinfo=src/texinfo-4.13a.tar.gz
patch1_path_texinfo=src/texinfo-4.13.auto.patch  
patch2_path_texinfo=src/texinfo-4.13.gnulib.patch  
patch3_path_texinfo=src/texinfo-4.13.tww.patch
patch1_texinfo=texinfo-4.13.auto.patch 
patch2_texinfo=texinfo-4.13.gnulib.patch  
patch3_texinfo=texinfo-4.13.tww.patch

INSTALL_PREFIX_texinfo=${INSTALL_PREFIX}/${install_name_texinfo}

texinfo: ${INSTALL_PREFIX_texinfo}

texinfoclean: 
	rm -rf ${INSTALL_PREFIX_texinfo}

${INSTALL_PREFIX_texinfo}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_texinfo}
	${GZIP} -dc ${path_texinfo}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_texinfo} ${BuildDir}/${build_name_texinfo};cd ${BuildDir}/${build_name_texinfo};${GPATCH} -p0 < ${patch1_texinfo})
	(cp ${patch2_path_texinfo} ${BuildDir}/${build_name_texinfo};cd ${BuildDir}/${build_name_texinfo};${GPATCH} -p0 < ${patch2_texinfo})
	(cp ${patch3_path_texinfo} ${BuildDir}/${build_name_texinfo};cd ${BuildDir}/${build_name_texinfo};${GPATCH} -p0 < ${patch3_texinfo})
#configure 
	(cd ${BuildDir}/${build_name_texinfo}; \
         rm -f config.cache ;\
          ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} \
          --disable-nls --disable-dependency-tracking \
          --prefix=${INSTALL_PREFIX_texinfo};\
         ${GMAKE} install ;\
         rm -rf ${INSTALL_PREFIX_texinfo}/info ${INSTALL_PREFIX_texinfo}/man \
         ${INSTALL_PREFIX_texinfo}/share ${INSTALL_PREFIX_texinfo}/bin/info \
         ${INSTALL_PREFIX_texinfo}/bin/infokey ${INSTALL_PREFIX_texinfo}/bin/makeinfo \
         ${INSTALL_PREFIX_texinfo}/bin/texindex ${INSTALL_PREFIX_texinfo}/bin/texi2dvi \
         )

#################################################################################
module_name_zlib=zlib
build_name_zlib=zlib-1.2.3
install_name_zlib=${install_name}/lib/aux/zlib12
path_zlib=src/zlib-1.2.3.tar.gz
patch1_path_zlib=src/zlib-1.2.3.auto.patch   
patch2_path_zlib=src/zlib-1.2.3.tww.patch
patch3_path_zlib=src/zlib-1.2.3.gnulib.patch  
patch4_path_zlib=src/zlib-1.2.3.tww-gnulib.patch
patch1_zlib=zlib-1.2.3.auto.patch   
patch2_zlib=zlib-1.2.3.tww.patch
patch3_zlib=zlib-1.2.3.gnulib.patch  
patch4_zlib=zlib-1.2.3.tww-gnulib.patch

INSTALL_PREFIX_zlib=${INSTALL_PREFIX}/${install_name_zlib}

zlib: ${INSTALL_PREFIX_zlib}

zlibclean:
	rm -rf ${BuildDir}/${build_name_zlib}
	rm -rf ${INSTALL_PREFIX_zlib}
${INSTALL_PREFIX_zlib}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_zlib}
	${GZIP} -dc ${path_zlib}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_zlib} ${BuildDir}/${build_name_zlib};cd ${BuildDir}/${build_name_zlib};${GPATCH} -p0 < ${patch1_zlib})
	(cp ${patch2_path_zlib} ${BuildDir}/${build_name_zlib};cd ${BuildDir}/${build_name_zlib};${GPATCH} -p0 < ${patch2_zlib})
	(cp ${patch3_path_zlib} ${BuildDir}/${build_name_zlib};cd ${BuildDir}/${build_name_zlib};${GPATCH} -p0 < ${patch3_zlib})
	(cp ${patch4_path_zlib} ${BuildDir}/${build_name_zlib};cd ${BuildDir}/${build_name_zlib};${GPATCH} -p0 < ${patch4_zlib})

#configure 
	(cd ${BuildDir}/${build_name_zlib}; \
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS}  --enable-shared --enable-static  --prefix=${INSTALL_PREFIX_zlib};\
        ${GMAKE} install;\
        rm -rf ${INSTALL_PREFIX_zlib}/man;\
        )

#################################################################################
module_name_openssl=openssl
build_name_openssl=openssl-0.9.7b
install_name_openssl=${install_name}/lib/aux/libopenssl097
path_openssl=src/openssl-0.9.7b.tar.gz
patch_path_openssl=src/openssl-0.9.7b.tww.patch
patch_openssl=openssl-0.9.7b.tww.patch
PRNGD=/prngd
PRNGD_SOCKET=/var${PRNGD}/pool
PERL=/usr/bin/perl 
INSTALL_PREFIX_openssl=${INSTALL_PREFIX}/${install_name_openssl}
ARCH=darwin-i386-cc

openssl: ${INSTALL_PREFIX_openssl}

opensslclean: 
	rm -rf ${INSTALL_PREFIX_openssl}

${INSTALL_PREFIX_openssl}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_openssl}
	gzip -dc ${path_openssl}| tar xvf - -C ${BuildDir}
# patch it
	(\
        cp ${patch_path_openssl} ${BuildDir}/${build_name_openssl};\
        cd ${BuildDir}/${build_name_openssl};${GPATCH} -p0 < ${patch_openssl} \
        )
#         ./Configure PERL=${PERL} MAKE=${GMAKE} ${ARCH} no-idea shared -DDEVRANDOM_EGD=\"${PRNGD_SOCKET}\" \
#configure 
	(cd ${BuildDir}/${build_name_openssl}; \
         sed -e "s!^is located at.*!is located at ${PRNGD_SOCKET}.!" \
         doc/crypto/RAND_egd.pod >${BuildDir}/$$ ;\
         cp ${BuildDir}/$$ doc/crypto/RAND_egd.pod && rm ${BuildDir}/$$ ;\
         ./Configure ${ARCH} no-idea shared -DDEVRANDOM_EGD=\"${PRNGD_SOCKET}\" \
          --openssldir=${INSTALL_PREFIX_openssl} --prefix=${INSTALL_PREFIX_openssl}; \
         ${GMAKE}  depend ;\
         ${GMAKE}  LDFLAGS="${LDFLAGS+${LDFLAGS}}";\
         ${GMAKE} MAKE=${GMAKE} RPATH="${RPATH}${INSTALL_PREFIX_openssl}/lib ${LDFLAGS+${LDFLAGS}}" install ;\
         sed "s!-L\(\${libdir}\)!-L\1 ${CC_LD_RT:-${RPATH}}\1!" \
         ${INSTALL_PREFIX_openssl}/lib/pkgconfig/openssl.pc >${BuildDir}/$$ ;\
         cp ${BuildDir}/$$ ${INSTALL_PREFIX_openssl}/lib/pkgconfig/openssl.pc && rm ${BuildDir}/$$ ;\
         rm -rf ${INSTALL_PREFIX_openssl}/bin ${INSTALL_PREFIX_openssl}/certs \
         ${INSTALL_PREFIX_openssl}/man ${INSTALL_PREFIX_openssl}/misc \
         ${INSTALL_PREFIX_openssl}/openssl.cnf ${INSTALL_PREFIX_openssl}/private \
         )
#################################################################################
module_name_python=python252
build_name_python=Python-2.5.2
install_name_python=${install_name}/lib/aux/python
INSTALL_PREFIX_python=${INSTALL_PREFIX}/${install_name_python}
LDFLAGS=-Wl,-F.
path_python=src/Python-2.5.2.tar.bz2
patch1_path_python=src/Python-2.5.2.auto.patch
patch2_path_python=src/Python-2.5.2.freebsd.patch
patch3_path_python=src/Python-2.5.2.tww.patch
patch4_path_python=src/Python-2.5.2.fc-db47.patch	
patch5_path_python=src/Python-2.5.2.incpaths.patch  
patch6_path_python=src/Python-2.5.2.tk85.patch
patch1_python=Python-2.5.2.auto.patch
patch2_python=Python-2.5.2.freebsd.patch
patch3_python=Python-2.5.2.tww.patch
patch4_python=Python-2.5.2.fc-db47.patch	
patch5_python=Python-2.5.2.incpaths.patch  
patch6_python=Python-2.5.2.tk85.patch


python252: ${INSTALL_PREFIX_python}

python252-clean: 
	rm -rf ${INSTALL_PREFIX_python} ${BuildDir}/${build_name_python}
${INSTALL_PREFIX_python}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_python}
	${BZIP2} -dc ${path_python} | tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_python} ${BuildDir}/${build_name_python};cd ${BuildDir}/${build_name_python};${GPATCH} -p0 < ${patch1_python})
	(cp ${patch2_path_python} ${BuildDir}/${build_name_python};cd ${BuildDir}/${build_name_python};${GPATCH} -p0 < ${patch2_python})
#	(cp ${patch3_path_python} ${BuildDir}/${build_name_python};cd ${BuildDir}/${build_name_python};${GPATCH} -p0 < ${patch3_python})
	(cp ${patch4_path_python} ${BuildDir}/${build_name_python};cd ${BuildDir}/${build_name_python};${GPATCH} -p0 < ${patch4_python})
#	(cp ${patch5_path_python} ${BuildDir}/${build_name_python};cd ${BuildDir}/${build_name_python};${GPATCH} -p0 < ${patch5_python})
	(cp ${patch6_path_python} ${BuildDir}/${build_name_python};cd ${BuildDir}/${build_name_python};${GPATCH} -p0 < ${patch6_python})

#configure 
	(cd ${BuildDir}/${build_name_python}; \
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} LDFLAGS=${LDFLAGS}\
         --disable-ipv6  --prefix=${INSTALL_PREFIX_python};\
         ${GMAKE};\
         ${GMAKE} install ;\
         rm -rf ${INSTALL_PREFIX_python}/info ${INSTALL_PREFIX_python}/man \
         ${INSTALL_PREFIX_python}/share ${INSTALL_PREFIX_python}/bin/info \
         ${INSTALL_PREFIX_python}/bin/infokey ${INSTALL_PREFIX_python}/bin/makeinfo \
         ${INSTALL_PREFIX_python}/bin/texindex ${INSTALL_PREFIX_python}/bin/texi2dvi \
         )


#################################################################################
module_name_sbutils=sbutils128
build_name_sbutils=sbutils-1.2.8
install_name_sbutils=/lib/misclib.py
path_sbutils=src/sbutils-1.2.8.tar.bz2
patch_path_sbutils1=src/systype.patch
patch_path_sbutils2=src/misclib.py.patch
patch_sbutils1=systype.patch
patch_sbutils2=misclib.py.patch
sbutils_config1=src/sbutils128.conf
SB_INSTALL_PREFIX=${INSTALL_PREFIX}/sbutils128
INSTALL_PREFIX_sbutils=${INSTALL_PREFIX}/${module_name_sbutils}/${install_name_sbutils}
_datadir="${SB_INSTALL_PREFIX}/share"
_sysconfdir="${SB_INSTALL_PREFIX}/etc"

sbutils128: ${INSTALL_PREFIX_sbutils}

sbutils128-clean: 
	rm -rf ${INSTALL_PREFIX_sbutils}
${INSTALL_PREFIX_sbutils}:
#unpack source ball

	rm -rf ${BuildDir}/${build_name_sbutils}
	${BZIP2}  -dc ${path_sbutils}| tar xvf - -C ${BuildDir}
#patch it
	(\
        cp ${patch_path_sbutils1} ${patch_path_sbutils2} ${BuildDir}/${build_name_sbutils}; \
        cd ${BuildDir}/${build_name_sbutils};${GPATCH} -p0 < ${patch_sbutils1} \
        )

#configure 
	(cd ${BuildDir}/${build_name_sbutils}; \
         rm -f config.cache ;\
          ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} CFLAGS="${CFLAGS:--O2}" \
BASH="${SB_INSTALL_PREFIX}/lib/aux/bash/bin/bash" \
PYTHON="${SB_INSTALL_PREFIX}/lib/aux/python/bin/python" \
GCHGRP="${SB_INSTALL_PREFIX}/lib/aux/fileutils41/bin/gchgrp" \
GCHMOD="${SB_INSTALL_PREFIX}/lib/aux/fileutils41/bin/gchmod" \
GCHOWN="${SB_INSTALL_PREFIX}/lib/aux/fileutils41/bin/gchown" \
GFIND="${SB_INSTALL_PREFIX}/lib/aux/findutils41/bin/gfind" \
GGREP="${SB_INSTALL_PREFIX}/lib/aux/grep/bin/ggrep" \
GINSTALL="${SB_INSTALL_PREFIX}/lib/aux/fileutils41/bin/ginstall" \
GLN="${SB_INSTALL_PREFIX}/lib/aux/fileutils41/bin/gln" \
GTAR="${SB_INSTALL_PREFIX}/lib/aux/gtar/bin/gtar" \
GTOUCH="${SB_INSTALL_PREFIX}/lib/aux/fileutils41/bin/gtouch" \
--datadir="${_datadir}" --sysconfdir="${_sysconfdir}" \
--prefix=${SB_INSTALL_PREFIX};\
${GMAKE}; \
${GMAKE} install \
)

sbinit:
	sudo rm -f /usr/bin/sb
	sudo cp ${sbutils_config1} ${INSTALL_PREFIX}/sbutils128/etc/sbutils.conf
	sudo ln -s /opt/bd/sbutils128/bin/sb /usr/bin/sb

#################################################################################
module_name_python-fchksum=python-fchksum
build_name_python-fchksum=python-fchksum-1.7
install_name_python-fchksum=${install_name}/lib/aux/python/lib/python2.4/site-packages/fchksum.so
patch_path_python-fchksum=src/python-fchksum-1.7.patch
patch_python-fchksum=python-fchksum-1.7.patch
INSTALL_PREFIX_python-fchksum=${INSTALL_PREFIX}/${install_name_python-fchksum}
python-fchksum: ${INSTALL_PREFIX_python-fchksum}
SB_VAR_PYTHON=${INSTALL_PREFIX_python}
SB_VAR_ZLIB=${INSTALL_PREFIX_zlib}

${INSTALL_PREFIX_python-fchksum}:
#unpack source ball
	rm -rf ${BuildDir}/python-fchksum-1.7
	gzip  -dc src/python-fchksum-1.7.tar.gz | tar xvf - -C ${BuildDir}
# patch it
	(\
        cp ${patch_path_python-fchksum} ${BuildDir}/${build_name_python-fchksum}; \
        cd ${BuildDir}/${build_name_python-fchksum};${GPATCH} -p0 < ${patch_python-fchksum} \
        )
#configure 
	(cd ${BuildDir}/${build_name_python-fchksum};${SB_VAR_PYTHON}/bin/python setup.py --zlib-prefix=${SB_VAR_ZLIB} \
${LD_RT+--lflags="${LD_RT}${SB_VAR_ZLIB_LIB}${LD_RT_POST+${LD_RT_POST}}"} ${LIBS+--zlib="${LIBS}"} build_ext --inplace )

	(cd ${BuildDir}/${build_name_python-fchksum};${SB_VAR_PYTHON}/bin/python setup.py --zlib-prefix=${SB_VAR_ZLIB} \
${LD_RT+--lflags="${LD_RT}${SB_VAR_ZLIB_LIB}${LD_RT_POST+${LD_RT_POST}}"} ${LIBS+--zlib="${LIBS}"} install)


#################################################################################
module_name_PyXML=PyXML
build_name_PyXML=PyXML-0.8.4
install_name_PyXML=${install_name}/lib/aux/python/lib/python2.4/site-packages/_xmlplus/parsers
patch_path_PyXML=src/PyXML-0.8.4.patch
patch_PyXML=PyXML-0.8.4.patch
INSTALL_PREFIX_PyXML=${INSTALL_PREFIX}/${install_name_PyXML}
PyXML: ${INSTALL_PREFIX_PyXML}
SB_VAR_PYTHON=${INSTALL_PREFIX_python}
#SB_VAR_EXPAT=${install_name_expat}
SB_VAR_EXPAT=${INSTALL_PREFIX_expat}
SB_VAR_EXPAT_LIB=${INSTALL_PREFIX_expat}

PyXML-clean:
	rm -rf ${install_name}/lib/aux/python/lib/python2.4/site-packages/_xmlplus/parsers
${INSTALL_PREFIX_PyXML}:
#unpack source ball
	rm -rf ${BuildDir}/PyXML-0.8.4
	gzip  -dc src/PyXML-0.8.4.tar.gz | tar xvf - -C ${BuildDir}
#configure 
	(cd ${BuildDir}/${build_name_PyXML};${SB_VAR_PYTHON}/bin/python setup.py  build --without-xpath --without-xslt  \
         --with-libexpat=${SB_VAR_EXPAT} ${LD_RT+--ldflags="${LD_RT}${SB_VAR_EXPAT_LIB}\
        ${LD_RT_POST+${LD_RT_POST}}"})

#install

	(cd ${BuildDir}/${build_name_PyXML};${SB_VAR_PYTHON}/bin/python setup.py  install --without-xpath --without-xslt  \
         --with-libexpat=${SB_VAR_EXPAT} ${LD_RT+--ldflags="${LD_RT}${SB_VAR_EXPAT_LIB}\
         ${LD_RT_POST+${LD_RT_POST}}"})

#################################################################################
# Create package 
# packagemaker -build -f root-path
#                        -p package-destination-path
#                        -i info-plist-path
#                        [-r resources-path]
#                        [-d description-plist-path]
#                        [-b build-path]
#                        [-s] [-ds] [-v] [-u]
#################################################################################
gensbpkg:
	rm -rf ${BuildDir}/${PKGNAME} 
	(${PKGMKR} -build \
        -f ${SB_INSTALL_PREFIX} \
        -p ${BuildDir}/${PKGNAME} \
        -i  src/Info.plist  \
        -d  src/Description.plist \
        -v )
gensbpkgtar:
	(cd ${BuildDir};tar cvf ${PKGNAME}.tar  ${PKGNAME})
installsb:
	/usr/sbin/installer -pkg ${BuildDir}/${PKGNAME} -target "/opt/bd"
scpibook: gensbpkgtar sbimg
	scp ${BuildDir}/${PKGNAME}.tar ${BuildDir}/${build_name}.dmg  tjyang@ibook:/Users/tjyang

gen-sb-dmg:

#################################################################################
# http://www.stepwise.com/Articles/Technical/2001-03-29.01.html
#################################################################################
# disk1 is not always disk1
gen-volume:
	rm -f ${BuildDir}/TargetImage.dmg ${build_name}.dmg 
#	hdiutil eject /dev/disk2
	hdiutil create  -megabytes 20 ${BuildDir}/TargetImage.dmg -layout NONE 
	hdid -nomount ${BuildDir}/TargetImage.dmg
	newfs_hfs -v ${build_name}  /dev/disk2
	hdiutil eject /dev/disk2
mount-volume:
	hdid ${BuildDir}/TargetImage.dmg
	/usr/bin/rsync  -azpv ${BuildDir}/${PKGNAME} /Volumes/${build_name}/
	hdiutil eject /dev/disk2
sbimg: gen-volume mount-volume
	rm -f ${BuildDir}/${build_name}.dmg 
	hdiutil convert -format UDCO ${BuildDir}/TargetImage.dmg  -o ${BuildDir}/${build_name}.dmg 
#	hdiutil eject /dev/disk1

#################################################################################
#	 (export DSIZE=`du -s /opt/bd/sbutils128/ | awk -F' ' '{print \$1}'`;
#################################################################################





#cd  /Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS
#
#bash-3.2# ./PackageMaker --help
#
#    packagemaker --root | -r root-path
#                 --doc | -d pmdoc-path
#                 --out | -o destination-path
#                 --id | -i package-identifier
#                 --version | -n version
#                 --title | -t title
#                 --install-to | -l install-to-path
#                 --info | -f info-path
#                 --resources | -e resources-path
#                 --scripts | -s scripts-path
#                 --certificate | -c certificate-name
#                 (--filter | -x regular-expression)*
#                 (--target | -g 10.5 | 10.4 | 10.3)*
#                 (--domain | -h system | user | anywhere)*
#                 --verbose | -v
#                 --no-recommend | -m
#                 --root-volume-only | -b
#                 --discard-forks | -k
#                 --temp-root
#
#Creating a snapshot package:
#    packagemaker --watch [normal options, except --doc and --root]
#
#Signing an existing flat package/metapackage:
#    packagemaker --sign path-to-pkg
#                 --certificate | -c certificate-name
#                 [--out | -o] destination-path
#
#Backwards compatible mode:
#    packagemaker -build -proj pmproj-path
#                        -p destination-path
#                        [-b build-path]
#                        [-s] [-ds] [-v] [-u]
#
#    packagemaker -build -f root-path
#                        -p destination-path
#                        -i info-plist-path
#                        [-r resources-path]
#                        [-d description-plist-path]
#                        [-b build-path]
#                        [-s] [-ds] [-v] [-u]
#
#    packagemaker -build -mi | -mc | -ms packages-directory-patch
#                        -p destination-path
#                        -i info-plist-path
#                        [-r resources-path]
#                        [-d description-plist-path]
#                        [-b build-path]
#                        [-v]
#
#bash-3.2# 



#################################################################################
module_name_coreutils=coreutils
build_name_coreutils=coreutils-6.12
install_name_coreutils=${install_name}/lib/aux/coreutils61

path_coreutils=src/coreutils-6.12.tar.gz
patch1_path_coreutils=src/coreutils-6.12.accomodate_older_selinux.patch
patch2_path_coreutils=src/coreutils-6.12.gnulib.patch
patch3_path_coreutils=src/coreutils-6.12.address_root_cause_of_compilation_failures.patch  
patch4_path_coreutils=src/coreutils-6.12.other_upstream_fixes.patch
patch5_path_coreutils=src/coreutils-6.12.auto.patch					     
patch6_path_coreutils=src/coreutils-6.12.c99-to-c89.diff
patch7_path_coreutils=src/coreutils-6.12.tww.patch
patch1_coreutils=coreutils-6.12.accomodate_older_selinux.patch
patch2_coreutils=coreutils-6.12.gnulib.patch
patch3_coreutils=coreutils-6.12.address_root_cause_of_compilation_failures.patch  
patch4_coreutils=coreutils-6.12.other_upstream_fixes.patch
patch5_coreutils=coreutils-6.12.auto.patch					     
patch6_coreutils=coreutils-6.12.c99-to-c89.diff
patch7_coreutils=coreutils-6.12.tww.patch


INSTALL_PREFIX_coreutils=${INSTALL_PREFIX}/${install_name_coreutils}

coreutils: ${INSTALL_PREFIX_coreutils}

coreutilsclean:
	rm -rf ${BuildDir}/${build_name_coreutils}
	rm -rf ${INSTALL_PREFIX_coreutils}
${INSTALL_PREFIX_coreutils}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_coreutils}
	${GZIP} -dc ${path_coreutils}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_coreutils} ${BuildDir}/${build_name_coreutils};cd ${BuildDir}/${build_name_coreutils};${GPATCH} -p0 < ${patch1_coreutils})
	(cp ${patch2_path_coreutils} ${BuildDir}/${build_name_coreutils};cd ${BuildDir}/${build_name_coreutils};${GPATCH} -p0 < ${patch2_coreutils})
	(cp ${patch3_path_coreutils} ${BuildDir}/${build_name_coreutils};cd ${BuildDir}/${build_name_coreutils};${GPATCH} -p0 < ${patch3_coreutils})
	(cp ${patch4_path_coreutils} ${BuildDir}/${build_name_coreutils};cd ${BuildDir}/${build_name_coreutils};${GPATCH} -p0 < ${patch4_coreutils})
	(cp ${patch5_path_coreutils} ${BuildDir}/${build_name_coreutils};cd ${BuildDir}/${build_name_coreutils};${GPATCH} -p0 < ${patch5_coreutils})
	(cp ${patch6_path_coreutils} ${BuildDir}/${build_name_coreutils};cd ${BuildDir}/${build_name_coreutils};${GPATCH} -p0 < ${patch6_coreutils})
	(cp ${patch7_path_coreutils} ${BuildDir}/${build_name_coreutils};cd ${BuildDir}/${build_name_coreutils};${GPATCH} -p0 < ${patch7_coreutils})

#configure 
	(cd ${BuildDir}/${build_name_coreutils}; \
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} \
        --program-prefix=g --disable-dependency-tracking \
        --mandir=${INSTALL_PREFIX_coreutils}/man \
        --info=${INSTALL_PREFIX_coreutils}/info \
        --prefix=${INSTALL_PREFIX_coreutils};\
        ${GMAKE} install;\
        rm -rf ${INSTALL_PREFIX_coreutils}/man;\
        )


#################################################################################
module_name_gawk=gawk
build_name_gawk=gawk-3.1.6
install_name_gawk=${install_name}/lib/aux/gawk31
INSTALL_PREFIX_gawk=${INSTALL_PREFIX}/${install_name_gawk}

path_gawk=src/gawk-3.1.6.tar.bz2 
patch1_path_gawk=src/gawk-3.1.6.auto.patch
patch2_path_gawk=src/gawk-3.1.6.tww.patch
patch1_gawk=gawk-3.1.6.auto.patch
patch2_gawk=gawk-3.1.6.tww.patch


gawk: ${INSTALL_PREFIX_gawk}

gawkclean:
	rm -rf ${BuildDir}/${build_name_gawk}
	rm -rf ${INSTALL_PREFIX_gawk}
${INSTALL_PREFIX_gawk}:
#unpack source ball
	rm -rf ${BuildDir}/${build_name_gawk}
	${BZIP2} -dc ${path_gawk}| tar xvf - -C ${BuildDir}
# patch it
	(cp ${patch1_path_gawk} ${BuildDir}/${build_name_gawk};cd ${BuildDir}/${build_name_gawk};${GPATCH} -p0 < ${patch1_gawk})
	(cp ${patch2_path_gawk} ${BuildDir}/${build_name_gawk};cd ${BuildDir}/${build_name_gawk};${GPATCH} -p0 < ${patch2_gawk})

#configure 
	(cd ${BuildDir}/${build_name_gawk}; \
        ${SHELL} ${CONFIGURE} CC=${CC} CFLAGS=${CFLAGS} \
        --disable-nls --disable-dependency-tracking \
        --mandir=${INSTALL_PREFIX_gawk}/man \
        --info=${INSTALL_PREFIX_gawk}/info \
        --datadir=${INSTALL_PREFIX_gawk}/share \
        --prefix=${INSTALL_PREFIX_gawk};\
        ${GMAKE} install;\
        rm -rf ${INSTALL_PREFIX_gawk}/man;\
        )

