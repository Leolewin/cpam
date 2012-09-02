# -----------------------------------------------------------------------------
#          M A K E F I L E   S C R I P T   S P E C I F I C A T I O N
# -----------------------------------------------------------------------------
#
# NAME
#       Makefile   - a make file to bootstrap TWW HPMS tools.
#
# REVISION HISTORY
#       07/03/2003 T.J. Yang original.
#       04/16/2004 T.J. Yang enable distcc to improve the compilation time.
#
# USAGE
#       make
#       make build
#       make dmg
#       make pkg
#
# DESCRIPTION
#        
#       The purpose of this makefile script is to bootstrap TWW HPMS tools.
#       sbutils,pbutils and pkgutils will be generated.
#       
# TO DOs
#  1. Generate Native pacakges on a platform.       
#  2. turn this script into a sh script instead of makefile.

#
# RETURN CODE
#       SUCCESS - Action completed successfully
#       SYSERR - Action did not complete successfully
#
# **************************** MAIN SCRIPT ************************************
#
#
# ---------------------------- CONSTANT DECLARATION ---------------------------
#
#
# ---------------------------- VARIABLE DECLARATION ---------------------------
#

# ---------------------------- SCRIPT -----------------------------------------
#
# set -x     # Uncomment for debugging.

# WHAT: Change to the working directory
# WHY:  We need programs located there ... complain if can't
#

SYSTYPE=MacOSX 
PKGMKR=/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker
program_name=sbutils
version=1.2.8
revision="1"
TMP=/tmp
BDIR=${TMP}
PKGNAME=${program_name}-${version}.pkg
build_name=${program_name}-${version}
install_name=${program_name}128
INSTALL_PREFIX=/opt/bd
#GMAKE=${INSTALL_PREFIX}/${install_name}/lib/aux/gmake/bin/gmake
#GMAKE=/usr/bin/make -j 8
GMAKE=/usr/bin/make
# configure distcc 
SET_DISTCC_HOSTS=DISTCC_HOSTS='emac ibook'
SETCC=CC='/usr/bin/distcc /usr/bin/gcc'
#GPATCH=${INSTALL_PREFIX}/${install_name}/lib/aux/gpatch25/bin/gpatch
GPATCH=/usr/bin/patch
#BZIP2=${INSTALL_PREFIX_bzip2}/bin/bzip2
BZIP2=/usr/bin/bzip2
GZIP=/usr/bin/gzip

#CFLAGS="-O -g -isysroot /Developer/SDKs/MacOSX10.5.sdk -arch i386 " 
#CFLAGS="-O -g -isysroot /Developer/SDKs/MacOSX10.5.sdk" 
CFLAGS:="-O -g -isysroot /Developer/SDKs/MacOSX10.7.sdk" 
LDFLAGS:="-Wl,-syslibroot,/Developer/SDKs/MacOSX10.7.sdk"

DISTCC_CONFIGURE= CFLAGS="-O -g -isysroot /Developer/SDKs/MacOSX10.7.sdk "  \
LDFLAGS="-Wl,-syslibroot,/Developer/SDKs/MacOSX10.7.sdk" \
./configure --disable-dependency-tracking


SRCS=PyXML-0.8.3.tar.gz  expat-1.95.6.patch  grep-2.5.1.patch  openssl-0.9.7b.tar.gz  tar-1.15.tar.bz2 \
Python-2.3.2.patch  expat-1.95.6.tar.gz  grep-2.5.1.tar.bz2  patch-2.5.8.tar.gz  texinfo-4.6.patch \
Python-2.3.2.tar.bz2  fileutils-4.1.7.patch  gzip-1.3.5.tar.gz  python-fchksum-1.7.patch texinfo-4.6.tar.bz2 \
bash-2.05b.patch  fileutils-4.1.7.tar.bz2  make-3.79.1.patch  python-fchksum-1.7.tar.gz	zlib-1.1.4-tww.tar.gz \
bash-2.05b.tar.gz  findutils-4.1.20.patch  make-3.79.1.tar.gz  sbutils-1.2.8.tar.bz2 \
bzip2-1.0.2-tww.tar.gz  findutils-4.1.20.tar.gz  openssl-0.9.7b.patch  tar-1.13.25.patch

#################################################################################
# gpatch gmake gzip bzip2 findutils gtar bash texinfo zlib  expat openssl  coreutils python
#
#################################################################################
all: sb sbinit gensbpkg sbimg

sb:  utils python  openssl ggrep sbutils128

#utils: gpatch gmake gzip bzip2 gtar texinfo bash  zlib expat cpio sed 
#utils: gpatch gmake bzip2 gtar texinfo bash  zlib expat cpio sed 
utils: gpatch gmake gtar texinfo bash  zlib expat cpio sed 

python:  python246 python-fchksum PyXML 

pythonclean:  python246-clean 

##################################################################################
#module_name_openssl=openssl
#build_name_openssl=openssl-0.9.7b
#patch_path_openssl=src/openssl-0.9.7b.tww.patch
#patch_openssl=openssl-0.9.7b.tww.patch
#install_name_openssl=${program_name}12/lib/aux/openssl
#INSTALL_PREFIX_openssl=${INSTALL_PREFIX}/${install_name_openssl}
#openssl: ${INSTALL_PREFIX_openssl}
#PRNGD=/prngd
#PRNGD_SOCKET=/var${PRNGD}/pool
#PERL=/usr/bin/perl 
#INSTALL_PREFIX_openssl=${INSTALL_PREFIX}/${install_name_openssl}
#ARCH=darwin-ppc-cc
#
#opensslclean: 
#	rm -rf ${INSTALL_PREFIX_openssl}
#
#${INSTALL_PREFIX_openssl}:
##unpack source ball
#	rm -rf ${BDIR}/openssl-0.9.7b
#	${GZIP} -dc src/openssl-0.9.7b.tar.gz | tar xvf - -C ${BDIR}
## patch it
#	(\
#        cp ${patch_path_openssl} ${BDIR}/${build_name_openssl};\
#        cd ${BDIR}/${build_name_openssl};${GPATCH} -p0 < ${patch_openssl} \
#        )
##configure 
#	(${SET_DISTCC_HOSTS};cd ${BDIR}/${build_name_openssl}; \
#         sed -e "s!^is located at.*!is located at ${PRNGD_SOCKET}.!" \
#         doc/crypto/RAND_egd.pod >${TMP}/$$ ;\
#         cp ${TMP}/$$ doc/crypto/RAND_egd.pod && rm ${TMP}/$$ ;\
#         ${PERL} ./Configure ${ARCH} no-idea shared -DDEVRANDOM_EGD=\"${PRNGD_SOCKET}\" \
#          --openssldir=${INSTALL_PREFIX_openssl} --prefix=${INSTALL_PREFIX_openssl}; \
#         ${GMAKE}  depend ;\
#         ${GMAKE}  LDFLAGS="${LDFLAGS+${LDFLAGS}}";\
#         ${GMAKE} MAKE=${GMAKE} RPATH="${RPATH}${INSTALL_PREFIX_openssl}/lib ${LDFLAGS+${LDFLAGS}}" install ;\
#         sed "s!-L\(\${libdir}\)!-L\1 ${CC_LD_RT:-${RPATH}}\1!" \
#         ${INSTALL_PREFIX_openssl}/lib/pkgconfig/openssl.pc >${TMP}/$$ ;\
#         cp ${TMP}/$$ ${INSTALL_PREFIX_openssl}/lib/pkgconfig/openssl.pc && rm ${TMP}/$$ ;\
#         rm -rf ${INSTALL_PREFIX_openssl}/bin ${INSTALL_PREFIX_openssl}/certs \
#         ${INSTALL_PREFIX_openssl}/man ${INSTALL_PREFIX_openssl}/misc \
#         ${INSTALL_PREFIX_openssl}/openssl.cnf ${INSTALL_PREFIX_openssl}/private \
#         )
#

#################################################################################
module_name_shtool=shtool
build_name_shtool=shtool-2.0.2
install_name_shtool=${install_name}/lib/aux/shtool
INSTALL_PREFIX_shtool=${INSTALL_PREFIX}/${install_name_shtool}
shtool: ${INSTALL_PREFIX_shtool}

${INSTALL_PREFIX_shtool}:
#unpack source ball
	rm -rf ${BDIR}/shtool-2.0.2
	${GZIP} -dc src/shtool-2.0.2.tar.gz | tar xvf - -C ${BDIR}
# patch it

#configure 
	(cd ${TMP}/shtool-2.0.2;\
        export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} --program-prefix=g --prefix=${INSTALL_PREFIX_shtool};${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_shtool}/man \
        )


#################################################################################
module_name_sed=sed
build_name_sed=sed-4.0.9
install_name_sed=${install_name}/lib/aux/sed
INSTALL_PREFIX_sed=${INSTALL_PREFIX}/${install_name_sed}
sed: ${INSTALL_PREFIX_sed}

sed-clean:
	rm -rf  ${INSTALL_PREFIX_sed}

${INSTALL_PREFIX_sed}:
#unpack source ball
	rm -rf ${BDIR}/sed-4.0.9
	${GZIP} -dc src/sed-4.0.9.tar.gz | tar xvf - -C ${BDIR}
# patch it

#configure 
	(cd ${TMP}/sed-4.0.9;\
        export ${SET_DISTCC_HOSTS};\
        ${DISTCC_CONFIGURE} --program-prefix=g --prefix=${INSTALL_PREFIX_sed};\
        ${GMAKE}  ;\
        ${GMAKE} install;\
        rm -rf ${INSTALL_PREFIX_sed}/man \
        )



#################################################################################
module_name_cpio=cpio
build_name_cpio=cpio-2.6
install_name_cpio=${install_name}/lib/aux/cpio
INSTALL_PREFIX_cpio=${INSTALL_PREFIX}/${install_name_cpio}
cpio: ${INSTALL_PREFIX_cpio}

${INSTALL_PREFIX_cpio}:
#unpack source ball
	rm -rf ${BDIR}/cpio-2.6
	${BZIP2} -dc src/cpio-2.6.tar.bz2 | tar xvf - -C ${BDIR}
# patch it

#configure 
	(cd ${TMP}/cpio-2.6; export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} --program-prefix=g --prefix=${INSTALL_PREFIX_cpio};${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_cpio}/man \
        )


#################################################################################
module_name_ggrep=ggrep
build_name_ggrep=grep-2.5.1
install_name_ggrep=${install_name}/lib/aux/grep
INSTALL_PREFIX_ggrep=${INSTALL_PREFIX}/${install_name_ggrep}
ggrep: ${INSTALL_PREFIX_ggrep}

${INSTALL_PREFIX_ggrep}:
#unpack source ball
	rm -rf ${BDIR}/grep-2.5.1
	${BZIP2} -dc src/grep-2.5.1.tar.bz2 | tar xvf - -C ${BDIR}
# patch it

#configure 
	(cd ${TMP}/grep-2.5.1; export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} --program-prefix=g --prefix=${INSTALL_PREFIX_ggrep};${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_ggrep}/man \
        )



#################################################################################
module_name_gpatch=gpatch
build_name_gpatch=patch-2.5.8
install_name_gpatch=${install_name}/lib/aux/gpatch25
INSTALL_PREFIX_gpatch=${INSTALL_PREFIX}/${install_name_gpatch}
gpatch: ${INSTALL_PREFIX_gpatch}

${INSTALL_PREFIX_gpatch}:
#unpack source ball
	rm -rf ${BDIR}/patch-2.5.8
	gzip -dc src/patch-2.5.8.tar.gz | tar xvf - -C ${BDIR}
# patch it

#configure 
	(cd ${TMP}/patch-2.5.8; export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE}  --program-prefix=g --prefix=${INSTALL_PREFIX_gpatch};${GMAKE}  ;${GMAKE} install;rm -rf ${INSTALL_PREFIX_gpatch}/man \
        )

#################################################################################
Module_name_gmake=gmake
install_name_gmake=${install_name}/lib/aux/gmake
build_name_gmake=make-3.79.1
path_gmake=src/make-3.79.1.tar.gz
patch_path_gmake=src/make-3.79.1.patch
patch_gmake=make-3.79.1.patch
INSTALL_PREFIX_gmake=${INSTALL_PREFIX}/${install_name_gmake}

gmake: gpatch ${INSTALL_PREFIX_gmake}

${INSTALL_PREFIX_gmake}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_gmake}
	gzip -dc ${path_gmake} | tar xvf - -C ${BDIR}
# patch it
	(cp ${patch_path_gmake} ${BDIR}/${build_name_gmake};cd ${BDIR}/${build_name_gmake};${GPATCH} -p0 < ${patch_gmake} )
#configure 
	(cd ${BDIR}/make-3.79.1; export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} --program-prefix=g --prefix=${INSTALL_PREFIX_gmake};${GMAKE} ;${GMAKE} install; \
         rm -rf ${INSTALL_PREFIX_gmake}/info ${INSTALL_PREFIX_gmake}/man ${INSTALL_PREFIX_gmake}/share)


#################################################################################
module_name_gzip=gzip
build_name_gzip=gzip-1.3.5
install_name_gzip=${install_name}/lib/aux/gzip13
path_gzip=src/gzip-1.3.5.tar.gz
patch_path_gzip1=gzip-1.3.5.tww.patch
patch_path_gzip2=gzip-1.3.5.CAN-2005-0758.patch
patch_path_gzip3=gzip-1.3.5.CAN-2005-0988.patch
patch_path_gzip4=gzip-1.3.5.CAN-2005-1288.patch
INSTALL_PREFIX_gzip=${INSTALL_PREFIX}/${install_name_gzip}
#CFLAGS="-no-cpp-precomp -D_FILE_OFFSET_BITS=64"
CFLAGS="-O2"
gzip:${INSTALL_PREFIX_gzip}
CFGOPT="--disable-dependency-tracking    --disable-nls "
${INSTALL_PREFIX_gzip}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_gzip}
	gzip -dc ${path_gzip}| tar xvf - -C ${BDIR}
# patch it
#	(\
#        cp src/${patch_path_gzip1}\
#        src/${patch_path_gzip2} \
#        src/${patch_path_gzip3} \
#        src/${patch_path_gzip4} \
#        ${BDIR}/${build_name_gzip}; \
#        cd ${BDIR}/${build_name_gzip};\
#        ${GPATCH} -p0 < ${patch_path_gzip1}; \
#        ${GPATCH} -p0 < ${patch_path_gzip2}; \
#        ${GPATCH} -p0 < ${patch_path_gzip3}; \
#        ${GPATCH} -p0 < ${patch_path_gzip4}; \
#        )
#

#configure  
	(export ${SET_DISTCC_HOSTS};cd ${BDIR}/${build_name_gzip}; \
        CFLAGS=${CFLAGS} export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE}  \
        --prefix=${INSTALL_PREFIX_gzip};\
        ${GMAKE};\
        ${GMAKE}install; \
        rm -rf ${INSTALL_PREFIX_gzip}/info ${INSTALL_PREFIX_gzip}/man)

#################################################################################
module_name_bzip2=bzip2
build_name_bzip2=bzip2-1.0.2
install_name_bzip2=${install_name}/lib/aux/bzip2
path_bzip2=src/bzip2-1.0.2-tww.tar.gz
INSTALL_PREFIX_bzip2=${INSTALL_PREFIX}/${install_name_bzip2}

bzip2: ${INSTALL_PREFIX_bzip2}
bzip2-clean:
	rm -rf ${INSTALL_PREFIX_bzip2}

${INSTALL_PREFIX_bzip2}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_bzip2}
	gzip -dc ${path_bzip2}| tar xvf - -C ${BDIR}
# patch it
#configure 
	(cd ${BDIR}/${build_name_bzip2}; rm -f config.cache; \
         CC=cc CFLAGS="-no-cpp-precomp -D_FILE_OFFSET_BITS=64 " \
         export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} --enable-shared --enable-static --prefix=${INSTALL_PREFIX_bzip2}; \
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
	rm -rf ${BDIR}/${build_name_expat}
	gzip -dc ${path_expat}| tar xvf - -C ${BDIR}
# patch it
	(\
        cp ${patch_path_expat} ${BDIR}/${build_name_expat};\
        cd ${BDIR}/${build_name_expat};${GPATCH} -p0 < ${patch_expat} \
        )
#configure 
	(cd ${BDIR}/${build_name_expat}; \
          rm -f config.cache; \
          export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE}  CFLAGS="${CFLAGS:--O2}"${LDFLAGS+LDFLAGS="${LDFLAGS}"} \
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
	rm -rf ${BDIR}/${build_name_fileutils}
	${BZIP2} -dc ${path_fileutils}| tar xvf - -C ${BDIR}
# patch it
	(\
        cp ${path_patch_fileutils} ${BDIR}/${build_name_fileutils};\
        cd ${BDIR}/${build_name_fileutils};${GPATCH} -p0 < ${patch_fileutils} \
        )

#<dependencies> <depend var="PERL">perl561</depend></dependencies>
#configure 
	(cd ${BDIR}/${build_name_fileutils}; \
	 export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} --disable-nls --program-prefix=g \
         --disable-dependency-tracking --prefix=${INSTALL_PREFIX_fileutils};\
        ${GMAKE};${GMAKE} install \
         )

#module_name_findutils=findutils
#build_name_findutils=findutils-4.1.20
#install_name_findutils=${install_name}/lib/aux/findutils41
#path_findutils=src/findutils-4.1.20.tar.gz
#patch_path_findutils=src/findutils-4.1.20.patch
#patch_findutils=findutils-4.1.20.patch
#
#findutils: ${INSTALL_PREFIX}/${install_name_findutils}
#
#findutilsclean: 
#	rm -rf ${INSTALL_PREFIX}/${install_name_findutils}
#
#${INSTALL_PREFIX}/${install_name_findutils}:
##unpack source ball
#	rm -rf ${BDIR}/${build_name_findutils}
#	gzip -dc ${path_findutils}| tar xvf - -C ${BDIR}
## patch it
#	(\
#        cp ${patch_path_findutils} ${BDIR}/${build_name_findutils};\
#        cd ${BDIR}/${build_name_findutils};${GPATCH} -p0 < ${patch_findutils} \
#        )
#
##configure 
#	(cd ${BDIR}/${build_name_findutils}; \
#         export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} CFLAGS="-DHAVE_F_FSTYPENAME_IN_STATFS"  --disable-dependency-tracking \
#        --program-prefix=g --disable-nls --prefix=${INSTALL_PREFIX}/${install_name_findutils};\
#        ${GMAKE}; \
#        ${GMAKE} install; \
#        rm -rf ${INSTALL_PREFIX}/${install_name_findutils}/var ${INSTALL_PREFIX}/${install_name_findutils}/libexec {INSTALL_PREFIX}/${install_name_findutils}/bin/glocate ${INSTALL_PREFIX}/${install_name_findutils}/bin/gupdatedb ${INSTALL_PREFIX}/${install_name_findutils}/man ${INSTALL_PREFIX}/${install_name_findutils}/info;\
#        )
#
##
#

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
	rm -rf ${BDIR}/${build_name_autoconf}
	gzip -dc ${path_autoconf}| tar xvf - -C ${BDIR}

# patch it
	(\
        cp ${patch_path_autoconf} ${BDIR}/${build_name_autoconf};\
        cd ${BDIR}/${build_name_autoconf};${GPATCH} -p0 < ${patch_autoconf} \
        )

#configure 
	(cd ${BDIR}/${build_name_autoconf}; \
         rm -f config.cache; \
          export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE}  CFLAGS="${CFLAGS:--O2}" --program-prefix=g --disable-dependency-tracking --prefix=${INSTALL_PREFIX_autoconf};\
         ${GMAKE} install;\
         rm -rf ${INSTALL_PREFIX_autoconf}/info ${INSTALL_PREFIX_autoconf}/lib ${INSTALL_PREFIX_autoconf}/libexec ${INSTALL_PREFIX_autoconf}/man ${INSTALL_PREFIX_autoconf}/share;\
        )



#################################################################################
module_name_gtar=gtar
build_name_gtar=tar-1.15.1
install_name_gtar=${install_name}/lib/aux/gtar
path_gtar=src/tar-1.15.1.tar.bz2
patch_path_gtar=src/tar-1.15.1.patch
patch_gtar=tar-1.15.1.patch
INSTALL_PREFIX_gtar=${INSTALL_PREFIX}/${install_name_gtar}

gtar: ${INSTALL_PREFIX_gtar}

${INSTALL_PREFIX_gtar}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_gtar}
	${BZIP2} -dc ${path_gtar}| tar xvf - -C ${BDIR}

# patch it
	(\
        cp ${patch_path_gtar} ${BDIR}/${build_name_gtar};\
        cd ${BDIR}/${build_name_gtar};${GPATCH} -p0 < ${patch_gtar} \
        )

#configure 
	(cd ${BDIR}/${build_name_gtar}; \
         rm -f config.cache; \
         export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} \
         --program-prefix=g --disable-dependency-tracking --prefix=${INSTALL_PREFIX_gtar};\
         $SET_DISTCC_HOSTS} ${GMAKE};\
         ${GMAKE} install;\
         rm -rf ${INSTALL_PREFIX_gtar}/info ${INSTALL_PREFIX_gtar}/lib ${INSTALL_PREFIX_gtar}/libexec ${INSTALL_PREFIX_gtar}/man ${INSTALL_PREFIX_gtar}/share;\
        )

#################################################################################
module_name_bash=bash
build_name_bash=bash-3.0
install_name_bash=${install_name}/lib/aux/bash
path_bash=src/bash-3.0.tar.gz
patch_path_bash=src/bash-3.0.patch
patch_bash=bash-3.0.patch
INSTALL_PREFIX_bash=${INSTALL_PREFIX}/${install_name_bash}

bash: ${INSTALL_PREFIX_bash}

bashclean:
	rm -rf ${INSTALL_PREFIX_bash}

${INSTALL_PREFIX_bash}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_bash}
	gzip -dc ${path_bash}| tar xvf - -C ${BDIR}
# patch it
	(\
        cp ${patch_path_bash} ${BDIR}/${build_name_bash};\
        cd ${BDIR}/${build_name_bash};${GPATCH} -p0 < ${patch_bash} \
        )

	(cd ${BDIR}/${build_name_bash}; \
rm -f config.cache;\
 export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE}   --enable-alias \
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
build_name_texinfo=texinfo-4.8
install_name_texinfo=${install_name}/lib/aux/texinfo46
path_texinfo=src/texinfo-4.8.tar.bz2
patch_path_texinfo=src/texinfo-4.8.tww.patch
patch_texinfo=texinfo-4.8.tww.patch
INSTALL_PREFIX_texinfo=${INSTALL_PREFIX}/${install_name_texinfo}
texinfo: ${INSTALL_PREFIX_texinfo}

texinfoclean: 
	rm -rf ${INSTALL_PREFIX_texinfo}

${INSTALL_PREFIX_texinfo}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_texinfo}
	/usr/bin/bunzip2 -dc ${path_texinfo}| tar xvf - -C ${BDIR}
# patch it
	(\
        cp ${patch_path_texinfo} ${BDIR}/${build_name_texinfo};\
        cd ${BDIR}/${build_name_texinfo};${GPATCH} -p0 < ${patch_texinfo} \
        )
#configure 
	(cd ${BDIR}/${build_name_texinfo}; \
         rm -f config.cache ;\
          export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE}  CFLAGS="${CFLAGS:--O2}" \
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
build_name_zlib=zlib-1.1.4
install_name_zlib=${install_name}/lib/aux/zlib11
path_zlib=src/zlib-1.1.4-tww.tar.gz
INSTALL_PREFIX_zlib=${INSTALL_PREFIX}/${install_name_zlib}

zlib: ${INSTALL_PREFIX_zlib}

zlibclean:
	rm -rf ${BDIR}/${build_name_zlib}
	rm -rf ${INSTALL_PREFIX_zlib}
${INSTALL_PREFIX_zlib}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_zlib}
	gzip -dc ${path_zlib}| tar xvf - -C ${BDIR}
# patch it
#configure 
	(cd ${BDIR}/${build_name_zlib}; \
         export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE}  --enable-shared --enable-static  --prefix=${INSTALL_PREFIX_zlib};\
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
	rm -rf ${BDIR}/${build_name_openssl}
	gzip -dc ${path_openssl}| tar xvf - -C ${BDIR}
# patch it
	(\
        cp ${patch_path_openssl} ${BDIR}/${build_name_openssl};\
        cd ${BDIR}/${build_name_openssl};${GPATCH} -p0 < ${patch_openssl} \
        )
#         ./Configure PERL=${PERL} MAKE=${GMAKE} ${ARCH} no-idea shared -DDEVRANDOM_EGD=\"${PRNGD_SOCKET}\" \
#configure 
	(cd ${BDIR}/${build_name_openssl}; \
         sed -e "s!^is located at.*!is located at ${PRNGD_SOCKET}.!" \
         doc/crypto/RAND_egd.pod >${TMP}/$$ ;\
         cp ${TMP}/$$ doc/crypto/RAND_egd.pod && rm ${TMP}/$$ ;\
         ./Configure ${ARCH} no-idea shared -DDEVRANDOM_EGD=\"${PRNGD_SOCKET}\" \
          --openssldir=${INSTALL_PREFIX_openssl} --prefix=${INSTALL_PREFIX_openssl}; \
         ${GMAKE}  depend ;\
         export ${SET_DISTCC_HOSTS};${GMAKE}  LDFLAGS="${LDFLAGS+${LDFLAGS}}";\
         ${GMAKE} MAKE=${GMAKE} RPATH="${RPATH}${INSTALL_PREFIX_openssl}/lib ${LDFLAGS+${LDFLAGS}}" install ;\
         sed "s!-L\(\${libdir}\)!-L\1 ${CC_LD_RT:-${RPATH}}\1!" \
         ${INSTALL_PREFIX_openssl}/lib/pkgconfig/openssl.pc >${TMP}/$$ ;\
         cp ${TMP}/$$ ${INSTALL_PREFIX_openssl}/lib/pkgconfig/openssl.pc && rm ${TMP}/$$ ;\
         rm -rf ${INSTALL_PREFIX_openssl}/bin ${INSTALL_PREFIX_openssl}/certs \
         ${INSTALL_PREFIX_openssl}/man ${INSTALL_PREFIX_openssl}/misc \
         ${INSTALL_PREFIX_openssl}/openssl.cnf ${INSTALL_PREFIX_openssl}/private \
         )
#${GMAKE}and install

##################################################################################
#module_name_python=python235
#build_name_python=Python-2.3.5
#install_name_python=${install_name}/lib/aux/python
#path_python=src/Python-2.3.5.tar.bz2
#patch_path_python=src/Python-2.3.5.patch
#patch_python=Python-2.3.5.patch
#INSTALL_PREFIX_python=${INSTALL_PREFIX}/${install_name_python}
##--enable-framework=/System/Library/Frameworks --enable-toolbox-glue \
#CFLAGS=-fno-common \
#--disable-ipv6  --with-cxx=no --without-libdb --with-cycle-gc \
#--disable-nls --disable-dependency-tracking
#SHELL=/bin/sh
#LDFLAGS=-Wl,-F.
#python235: ${INSTALL_PREFIX_python}
#
#python-clean: 
#	rm -rf ${INSTALL_PREFIX_python}
#${INSTALL_PREFIX_python}:
##unpack source ball
##	rm -rf ${BDIR}/${build_name_python}
#	${BZIP2}  -dc ${path_python}| tar xvf - -C ${BDIR}
## patch it
#	(\
#        cp ${patch_path_python} ${BDIR}/${build_name_python};\
#        cd ${BDIR}/${build_name_python};${GPATCH} -p0 < ${patch_python} \
#        )
##configure 
#	(cd ${BDIR}/${build_name_python}; \
#         rm -f config.cache ;\
#        ${SHELL} export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} CC="${CC:-gcc}" CFLAGS=${CFLAGS} \
#         OPT="${OPT:--O2}" LDFLAGS=${LDFLAGS}\
#         --with-cxx=no --without-libdb --with-cycle-gc \
#         --disable-ipv6  --prefix=${INSTALL_PREFIX_python};\
#         ${GMAKE};\
#         ${GMAKE} install ;\
#         rm -rf ${INSTALL_PREFIX_python}/info ${INSTALL_PREFIX_python}/man \
#         ${INSTALL_PREFIX_python}/share ${INSTALL_PREFIX_python}/bin/info \
#         ${INSTALL_PREFIX_python}/bin/infokey ${INSTALL_PREFIX_python}/bin/makeinfo \
#         ${INSTALL_PREFIX_python}/bin/texindex ${INSTALL_PREFIX_python}/bin/texi2dvi \
#         )
#
#
#
#
#
##################################################################################
#module_name_python=python242
#build_name_python=Python-2.4.2
#install_name_python=${install_name}/lib/aux/python
#path_python=src/Python-2.4.2.tgz
#patch_path_python=src/python.snowleopard.patch
#patch_python=python.snowleopard.patch
#INSTALL_PREFIX_python=${INSTALL_PREFIX}/${install_name_python}
##--enable-framework=/System/Library/Frameworks --enable-toolbox-glue \
#CFLAGS=-fno-common \
#--disable-ipv6  --with-cxx=no --without-libdb --with-cycle-gc \
#--disable-nls --disable-dependency-tracking
#SHELL=/bin/sh
#LDFLAGS=-Wl,-F.
#python242: ${INSTALL_PREFIX_python}
#
#python242-clean: 
#	rm -rf ${INSTALL_PREFIX_python}
#${INSTALL_PREFIX_python}:
##unpack source ball
#	rm -rf ${BDIR}/${build_name_python}
#	${GZIP}  -dc ${path_python}| tar xvf - -C ${BDIR}
## patch it
#	(\
#        cp ${patch_path_python} ${BDIR}/${build_name_python};\
#        cd ${BDIR}/${build_name_python};${GPATCH} -p0 < ${patch_python} \
#        )
##configure 
#	(cd ${BDIR}/${build_name_python}; \
#         rm -f config.cache ;\
#        export ${SET_DISTCC_HOSTS};\
#        ${DISTCC_CONFIGURE}  CFLAGS=${CFLAGS} \
#         OPT="${OPT:--O2}" LDFLAGS=${LDFLAGS}\
#         --with-cxx=no --without-libdb --with-cycle-gc \
#         --disable-ipv6  --prefix=${INSTALL_PREFIX_python};\
#         ${GMAKE};\
#         ${GMAKE} install ;\
#         rm -rf ${INSTALL_PREFIX_python}/info ${INSTALL_PREFIX_python}/man \
#         ${INSTALL_PREFIX_python}/share ${INSTALL_PREFIX_python}/bin/info \
#         ${INSTALL_PREFIX_python}/bin/infokey ${INSTALL_PREFIX_python}/bin/makeinfo \
#         ${INSTALL_PREFIX_python}/bin/texindex ${INSTALL_PREFIX_python}/bin/texi2dvi \
#         )
#
#
#
#
module_name_python=python246
build_name_python=Python-2.4.6
install_name_python=${install_name}/lib/aux/python
path_python=src/Python-2.4.6.tar.bz2
patch_path_python=src/python.lion.patch
patch_python=python.lion.patch

patch_path_python1=src/patch-pymactoolbox.diff
patch_python1=patch-pymactoolbox.diff
patch_path_python2=src/patch-mactoolboxglue.diff
patch_python2=patch-mactoolboxglue.diff

INSTALL_PREFIX_python=${INSTALL_PREFIX}/${install_name_python}
#--enable-framework=/System/Library/Frameworks --enable-toolbox-glue \
CFLAGS=-fno-common \
--disable-ipv6  --with-cxx=no --without-libdb --with-cycle-gc \
--disable-nls --disable-dependency-tracking
SHELL=/bin/sh
LDFLAGS=-Wl,-F.
python246: ${INSTALL_PREFIX_python}

python246-clean: 
	rm -rf ${INSTALL_PREFIX_python}
${INSTALL_PREFIX_python}:
#unpack source ball
	rm -rf ${BDIR}/${build_name_python}
	${BZIP2} -dc ${path_python} | tar xvf - -C ${BDIR}
# patch it
	(\
        cp ${patch_path_python} ${BDIR}/${build_name_python};\
        cp ${patch_path_python1} ${BDIR}/${build_name_python};\
        cp ${patch_path_python2} ${BDIR}/${build_name_python};\
        cd ${BDIR}/${build_name_python};${GPATCH} -p0 < ${patch_python}; \
        cd ${BDIR}/${build_name_python};${GPATCH} -p0 < ${patch_python1}; \
        cd ${BDIR}/${build_name_python};${GPATCH} -p0 < ${patch_python2}; \
        )
#configure 
	(cd ${BDIR}/${build_name_python}; \
         rm -f config.cache ;\
        export ${SET_DISTCC_HOSTS};\
        ${DISTCC_CONFIGURE}  CFLAGS="${CFLAGS}" \
         OPT="${OPT:--O2}" LDFLAGS="${LDFLAGS}"\
         --with-cxx=no --without-libdb --with-cycle-gc \
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
# unknown system type "Darwin Ryan-Yangs-Computer.local 7.3.0 Darwin Kernel Version 7.3.0: Fri Mar  5 14:22:55 PST 2004; root:xnu/xnu-517.3.15.obj~4/RELEASE_PPC  Power Macintosh"
#  elif uname[0] == 'Linux':
#    if uname[4] == 'i686': return 'linux', '7', '1'

# sb --dist=cd --install-base=/Users/tjyang/TWWfsw --install-path=/Users/TWWfsw/tjyang pbutils-1.2.7/pbutils-1.2.7.sb
sbutils128: ${INSTALL_PREFIX_sbutils}

sbutils128-clean: 
	rm -rf ${INSTALL_PREFIX_sbutils}
${INSTALL_PREFIX_sbutils}:
#unpack source ball

	rm -rf ${BDIR}/${build_name_sbutils}
	${BZIP2}  -dc ${path_sbutils}| tar xvf - -C ${BDIR}
#patch it
	(\
        cp ${patch_path_sbutils1} ${patch_path_sbutils2} ${BDIR}/${build_name_sbutils}; \
        cd ${BDIR}/${build_name_sbutils};${GPATCH} -p0 < ${patch_sbutils1} \
        )

#configure 
	(cd ${BDIR}/${build_name_sbutils}; \
         rm -f config.cache ;\
          export ${SET_DISTCC_HOSTS};${DISTCC_CONFIGURE} CFLAGS="${CFLAGS:--O2}" \
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
	rm -rf ${BDIR}/python-fchksum-1.7
	gzip  -dc src/python-fchksum-1.7.tar.gz | tar xvf - -C ${BDIR}
# patch it
	(\
        cp ${patch_path_python-fchksum} ${BDIR}/${build_name_python-fchksum}; \
        cd ${BDIR}/${build_name_python-fchksum};${GPATCH} -p0 < ${patch_python-fchksum} \
        )
#configure 
	(cd ${BDIR}/${build_name_python-fchksum};${SB_VAR_PYTHON}/bin/python setup.py --zlib-prefix=${SB_VAR_ZLIB} \
${LD_RT+--lflags="${LD_RT}${SB_VAR_ZLIB_LIB}${LD_RT_POST+${LD_RT_POST}}"} ${LIBS+--zlib="${LIBS}"} build_ext --inplace )

	(cd ${BDIR}/${build_name_python-fchksum};${SB_VAR_PYTHON}/bin/python setup.py --zlib-prefix=${SB_VAR_ZLIB} \
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
	rm -rf ${BDIR}/PyXML-0.8.4
	gzip  -dc src/PyXML-0.8.4.tar.gz | tar xvf - -C ${BDIR}
#configure 
	(cd ${BDIR}/${build_name_PyXML};${SB_VAR_PYTHON}/bin/python setup.py  build --without-xpath --without-xslt  \
         --with-libexpat=${SB_VAR_EXPAT} ${LD_RT+--ldflags="${LD_RT}${SB_VAR_EXPAT_LIB}\
        ${LD_RT_POST+${LD_RT_POST}}"})

#install

	(cd ${BDIR}/${build_name_PyXML};${SB_VAR_PYTHON}/bin/python setup.py  install --without-xpath --without-xslt  \
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
	rm -rf ${BDIR}/${PKGNAME} 
	(${PKGMKR} -build \
        -f ${SB_INSTALL_PREFIX} \
        -p ${BDIR}/${PKGNAME} \
        -i  src/Info.plist  \
        -d  src/Description.plist \
        -v )
gensbpkgtar:
	(cd ${BDIR};tar cvf ${PKGNAME}.tar  ${PKGNAME})
installsb:
	/usr/sbin/installer -pkg ${BDIR}/${PKGNAME} -target "/opt/bd"
scpibook: gensbpkgtar sbimg
	scp ${TMP}/${PKGNAME}.tar ${TMP}/${build_name}.dmg  tjyang@ibook:/Users/tjyang

gen-sb-dmg:

#################################################################################
# http://www.stepwise.com/Articles/Technical/2001-03-29.01.html
#################################################################################
# disk1 is not always disk1
gen-volume:
	rm -f ${BDIR}/TargetImage.dmg ${build_name}.dmg 
#	hdiutil eject /dev/disk2
	hdiutil create  -megabytes 20 ${BDIR}/TargetImage.dmg -layout NONE 
	hdid -nomount ${BDIR}/TargetImage.dmg
	newfs_hfs -v ${build_name}  /dev/disk2
	hdiutil eject /dev/disk2
mount-volume:
	hdid ${BDIR}/TargetImage.dmg
	/usr/bin/rsync  -azpv ${BDIR}/${PKGNAME} /Volumes/${build_name}/
	hdiutil eject /dev/disk2
sbimg: gen-volume mount-volume
	rm -f ${BDIR}/${build_name}.dmg 
	hdiutil convert -format UDCO ${BDIR}/TargetImage.dmg  -o ${TMP}/${build_name}.dmg 
#	hdiutil eject /dev/disk1
#################################################################################
#	 (export DSIZE=`du -s /opt/bd/sbutils128/ | awk -F' ' '{print \$1}'`;
#################################################################################
clean: cleanbinary cleansrc cleandmgpkg
cleandmgpkg:
	rm -rf ${TMP}/${build_name}.dmg  ${BDIR}/${PKGNAME} 
cleanbinary:
	rm -rf ${INSTALL_PREFIX}/${install_name}
cleansrc:
	cd ${BDIR}
	rm -rf  *~ ${build_name_gpatch} ${build_name_gmake} ${build_name_gzip}\
               ${build_name_bzip2}  ${build_name_findutils} ${build_name_gtar}\
               ${build_name_bash}  ${build_name_python} ${build_name_zlib}\
               ${build_name_fileutils} ${build_name_expat} ${build_name_openssl} \
               ${build_name_texinfo} 



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
CFLAGS:=-O -g -isysroot /Developer/SDKs/MacOSX10.7.sdk 
LDFLAGS:=-Wl,-syslibroot,/Developer/SDKs/MacOSX10.7.sdk
asrunner: AdiumApplescriptRunner.h
#	cc $(CFLAGS) $(LDFLAGS) -o AdiumApplescriptRunner AdiumApplescriptRunner.m
#	cc -framework Foundation -arch x86_64 -o AdiumApplescriptRunner AdiumApplescriptRunner.m
#	cc -framework Foundation -arch i386 -o AdiumApplescriptRunner AdiumApplescriptRunner.m
	cc -framework Foundation -framework AppKit -o ApplescriptRunner ApplescriptRunner.m AdiumApplescriptRunner.m
#	cc  -o AdiumApplescriptRunner AdiumApplescriptRunner.m
