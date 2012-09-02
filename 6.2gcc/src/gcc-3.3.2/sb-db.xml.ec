<?xml version="1.0"?>
<programs>
  <program name="gcc" version="4.0.0" revision="5">
    <build-name>${SB_PROG_NAME}-${SB_PROG_VER}</build-name>

    <install-name>${SB_PROG_NAME}400</install-name>

    <sources>
      <source  path="src/gcc-4.0.0.tar.bz2"/>
    </sources>

    <dependencies>
    </dependencies>

    <script-header>
<![CDATA[
_datadir="${SB_INSTALL_PREFIX}/share"
_docdir="${SB_INSTALL_PREFIX}/doc"
]]>
    </script-header>

    <configure>
<![CDATA[
test -d ${SB_BUILD_PREFIX}-objdir && rm -rf ${BUILD_PREFIX}-objdir
mkdir ${SB_BUILD_PREFIX}-objdir

cd ${SB_BUILD_PREFIX}-objdir
  CC=gcc ${SB_BUILD_PREFIX}/configure --enable-nls \
  --enable-languages=c,c++,objc \
  --with-included-gettext --enable-shared --disable-libgcj \
  --enable-threads --datadir="${_datadir}" \
  --with-local-prefix=${SB_INSTALL_PREFIX} --prefix=${INSTALL_PREFIX} 

perl -pi.bak -e 's!CONFIG_SITE=no-such-file \$\(SHELL\)!CONFIG_SITE=no-such-file EMAKE_BUILD_MODE=local \$\(SHELL\)!' ${SB_BUILD_PREFIX}/Makefile.in
grep CONFIG_SITE  /opt/build/gcc-3.3.2/Makefile.in
]]>
    </configure>

    <build>
<![CDATA[
export PATH=/opt/ecloud/sun4u_SunOS/bin/:$PATH
export EMAKE_CM=t-ec00.tr.comm.mot.com
export EMAKE_ROOT=/opt/build
export ECLOUD_ANNOTATE=/tmp/gcc-4.0.0.ecbuild.`date '+%m-%d-%y-%H-%M-%S'`.xml
set -x 
pwd
cd ${SB_BUILD_PREFIX}-objdir
pwd
#time gmake  bootstrap 
time emake --emake-annofile=${ECLOUD_ANNOTATE} --emake-root=${EMAKE_ROOT} bootstrap --emake-build-label=${SB_PROG_NAME}-${SB_PROG_VER}
]]>
    </build>
   <install>
<![CDATA[
(cd ${SB_BUILD_PREFIX}-objdir

# for Ada
case "${SB_SYSTYPE}" in
i686*-linux*|*-solaris2.[5789]*)
  export PATH=${SB_BUILD_BASE}/gnat/bin:$PATH
  ;;
*-osf5*)
  export PATH=${SB_BUILD_BASE}/gcc-3.3.2-alpha-dec-osf5.1b-bin/bin:$PATH
  ;;
*-osf4*)
  export PATH=${SB_BUILD_BASE}/gcc-3.3.2-alpha-dec-osf4.0f-bin/bin:$PATH
  ;;
esac

gmake install

case "${SB_SYSTYPE}" in
x86_64*-linux*)
  mv ${SB_INSTALL_PREFIX}/lib64/* ${SB_INSTALL_PREFIX}/lib
  rmdir ${SB_INSTALL_PREFIX}/lib64 ;;
esac

# relink some libraries to set correct runtime path
case "${SB_SYSTYPE}" in
*-aix*)
  # non-pthread library
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  gmake install LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
  gmake install

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
  gmake install-libs

  # pthread library
  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/libstdc++-v3/src
  gmake install LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
  gmake install

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
  gmake install-libs

  for _arch in power powerpc ppc64; do
    [ ! -d "${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}" ] && continue

    # non-pthread libraries
    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}/libstdc++-v3/src
    gmake install LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}/libf2c
    rm libg2c.la
    gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
    gmake install

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}/libobjc
    rm libobjc.la
    gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
    gmake install-libs

    # pthread libraries
    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/${_arch}/libstdc++-v3/src
    gmake install LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/${_arch}/libf2c
    rm libg2c.la
    gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
    gmake install

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/${_arch}/libobjc
    rm libobjc.la
    gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_INSTALL_PREFIX}/lib:/usr/lib"
    gmake install-libs
  done)
  ;;
*-hpux10*)
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/threads/libstdc++-v3/src
  gmake install LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  gmake install LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/threads/libf2c
  rm libg2c.la
  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"
  gmake install

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/threads/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"
  gmake install-libs

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"
  gmake install-libs)
  ;;
*-hpux11*)
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  gmake install LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"
  gmake install

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,+s -L${SB_INSTALL_PREFIX}/lib"
  gmake install-libs)
  ;;
x86_64*-linux*)
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  rm libstdc++.la
  gmake install LDFLAGS="-Wl,-rpath,${SB_INSTALL_PREFIX}/lib" \
        toolexeclibdir="${SB_INSTALL_PREFIX}/lib")

  ${SB_PATH_SHTOOL} subst -q -e "\
s!^glibcpp_toolexeclibdir = .*!\
glibcpp_toolexeclibdir = ${SB_INSTALL_PREFIX}/lib!; \
s!^toolexeclibdir = .*!\
toolexeclibdir = ${SB_INSTALL_PREFIX}/lib!; \
s!^LIBGCJ_LDFLAGS =.*!\
LIBGCJ_LDFLAGS = -Wl,-rpath,${SB_INSTALL_PREFIX}/lib!" \
  ${SB_SYSTYPE}/libjava/Makefile
  rm ${SB_SYSTYPE}/libjava/libgcj.la
  (gmake all-target-libjava install-target-libjava)
  ;;
esac)

# fix paths in .la
find ${SB_INSTALL_PREFIX} -name \*.la | while read _la; do
  ${SB_PATH_SHTOOL} subst -q -e "\
s!/lib/../lib!/lib!g; \
s!-L/lib64 !!g; \
s!-L/usr/lib64 !!g; \
s!-L/lib !!g; \
s!-L/usr/lib !!g;" ${_la}
  ${SB_PATH_SHTOOL} subst -q -e "\
s!^\(libdir=.*\)/\.!\1!" ${_la}
  ${SB_PATH_SHTOOL} subst -q -e "\
s!-L${SB_BUILD_PREFIX}[^ ][^ ]* !!g" ${_la}
  ${SB_PATH_SHTOOL} subst -q -e "\
s!-L[^ ][^ ]*/bin !!g" ${_la}
  ${SB_PATH_SHTOOL} subst -q -e "\
s!-L${SB_INSTALL_PREFIX}/${SB_SYSTYPE}/bin !!g" ${_la}
  ${SB_PATH_SHTOOL} subst -q -e "\
s!-L${SB_INSTALL_PREFIX}/${SB_SYSTYPE}/lib !!g" ${_la}
done

case "${SB_SYSTYPE}" in
*-linux*)
  case "${SB_SYSTYPE}" in
  x86_64-*-linux*)
    _systype=${SB_SYSTYPE} ;;
  *)
    _systype=i686-pc-linux-gnu ;;
  esac

  find ${SB_INSTALL_PREFIX} -name \*.la | while read _la; do
    ${SB_PATH_SHTOOL} subst -q -e "\
s!-L${SB_INSTALL_PREFIX}/lib/gcc-lib/${_systype}/${SB_PROG_VER}/\.\./\.\./\.\./\.\.!-L${SB_INSTALL_PREFIX}!g" ${_la}
    ${SB_PATH_SHTOOL} subst -q -e "\
s!-L${SB_INSTALL_PREFIX}/lib/gcc-lib/${_systype}/${SB_PROG_VER}/\.\./\.\./\.\.!-L${SB_INSTALL_PREFIX}/lib!g" ${_la}
  done
  ;;
*-aix*|*-solaris*)
  find ${SB_INSTALL_PREFIX} -name \*.la | while read _la; do
    ${SB_PATH_SHTOOL} subst -q -e "\
s!-L${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/\.\./\.\./\.\.!-L${SB_INSTALL_PREFIX}/lib!g" ${_la}
  done
  ;;
esac

# add runtime search path for libstdc++ when linking
case "${SB_SYSTYPE}" in
*-hpux*)
  sed -e "/link_command:/ {
i\\
*rpath:
i\\
-L${SB_VAR_GCC_RT}/lib
i\\

}" -e "s/%{static:}/%{static:} %(rpath)/" \
  ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs >/tmp/$$
  cp /tmp/$$ ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs
  rm -f /tmp/$$
  ;;
x86_64*-linux*)
  ${SB_PATH_SHTOOL} subst -q -e "\
/link_command:/ {
i\\
*rpath:
i\\
-rpath ${SB_VAR_GCC_RT}/lib
i\\

}
s/%(link_gcc_c_sequence)/%{!m32:%(rpath)} %(link_gcc_c_sequence)/" \
  ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs
  ;;
*-linux*)
  ${SB_PATH_SHTOOL} subst -q -e "\
/link_command:/ {
i\\
*rpath:
i\\
-rpath ${SB_VAR_GCC_RT}/lib
i\\

}
s/%(link_gcc_c_sequence)/%(rpath) %(link_gcc_c_sequence)/" \
  ${SB_INSTALL_PREFIX}/lib/gcc-lib/i686-pc-linux-gnu/${SB_PROG_VER}/specs
  ;;
*-irix*)
  sed -e "/link_command:/ {
i\\
*rpath:
i\\
-rpath ${SB_VAR_GCC_RT}/lib
i\\

i\\
*rpath64:
i\\
-rpath ${SB_VAR_GCC_RT}/lib/mabi=64
i\\

}" -e "s/%(link_gcc_c_sequence)/\
%{!mabi=64:%(rpath)} %{mabi=64:%(rpath64)} %(link_gcc_c_sequence)/" \
  ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs >/tmp/$$
  cp /tmp/$$ ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs
  rm -f /tmp/$$
  ;;
*-solaris2.[56]*)
  sed -e "/link_command:/ {
i\\
*rpath:
i\\
-R${SB_VAR_GCC_RT}/lib
i\\

}" -e "s/%(link_gcc_c_sequence)/\
%(rpath) %(link_gcc_c_sequence)/" \
  ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs >/tmp/$$
  cp /tmp/$$ ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs
  rm -f /tmp/$$
  ;;
*-solaris2*)
  sed -e "/link_command:/ {
i\\
*rpath:
i\\
-R${SB_VAR_GCC_RT}/lib
i\\

i\\
*rpath64:
i\\
-R${SB_VAR_GCC_RT}/lib/sparcv9
i\\

}" -e "s/%(link_gcc_c_sequence)/\
%{!m64:%(rpath)} %{m64:%(rpath64)} %(link_gcc_c_sequence)/" \
  ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs >/tmp/$$
  cp /tmp/$$ ${SB_INSTALL_PREFIX}/lib/gcc-lib/${SB_SYSTYPE}/${SB_PROG_VER}/specs
  rm -f /tmp/$$
  ;;
esac

${SB_PATH_GINSTALL} -m 755 -o root -g 0 -d ${_docdir}
${SB_PATH_GINSTALL} -m 644 -o root -g 0 gcc/doc/bugreport.texi \
gcc/doc/collect2.texi gcc/doc/compat.texi gcc/doc/configfiles.texi \
gcc/doc/configterms.texi gcc/doc/contrib.texi \
gcc/doc/contribute.texi gcc/doc/cppenv.texi gcc/doc/cppinternals.texi \
gcc/doc/cppopts.texi gcc/doc/cpp.texi gcc/doc/c-tree.texi \
gcc/doc/extend.texi gcc/doc/fragments.texi gcc/doc/frontends.texi \
gcc/doc/gcc.texi gcc/doc/gccint.texi gcc/doc/gcov.texi \
gcc/doc/gnu.texi gcc/doc/gty.texi gcc/doc/headerdirs.texi \
gcc/doc/hostconfig.texi gcc/doc/include/fdl.texi \
gcc/doc/include/funding.texi gcc/doc/include/gcc-common.texi \
gcc/doc/include/gpl.texi gcc/doc/install.texi \
gcc/doc/interface.texi gcc/doc/languages.texi \
gcc/doc/makefile.texi gcc/doc/md.texi gcc/doc/objc.texi \
gcc/doc/passes.texi gcc/doc/portability.texi gcc/doc/rtl.texi \
gcc/doc/service.texi gcc/doc/sourcebuild.texi gcc/doc/standards.texi \
gcc/doc/tm.texi gcc/doc/trouble.texi gcc/f/bugs.texi \
gcc/f/ffe.texi gcc/f/g77.texi gcc/f/intdoc.texi \
gcc/f/invoke.texi gcc/f/news.texi gcc/f/root.texi \
gcc/java/gcj.texi ${_docdir}

${SB_PATH_GCHOWN} -hR 0:0 ${SB_INSTALL_PREFIX}/lib/gcc-lib

# create runtime library
${SB_PATH_GINSTALL} -m 755 -o root -g 0 -d ${SB_VAR_GCC_RT}
(cd ${SB_INSTALL_PREFIX}
gtar cf - lib | (cd ${SB_VAR_GCC_RT}; gtar xpf -))
rm -rf ${SB_VAR_GCC_RT}/lib/charset.alias
rm -rf ${SB_VAR_GCC_RT}/lib/gcc-lib
rm -rf ${SB_VAR_GCC_RT}/lib/security
rm -rf ${SB_VAR_GCC_RT}/lib/32

# relink some libraries in runtime directory on AIX and HP-UX to
# set correct runtime path
case "${SB_SYSTYPE}" in
*-aix*)
  # non-pthread library
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  rm libstdc++.la
  gmake LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib"
  gmake install-toolexeclibLTLIBRARIES \
        LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib"
  ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
            libg2c.la ${SB_VAR_GCC_RT}/lib

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
        glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib"
  gmake install-libs \
        glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib"

  # pthread library
  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/libstdc++-v3/src
  rm libstdc++.la
  gmake LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread"
  gmake install-toolexeclibLTLIBRARIES \
        LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib"
  ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
            libg2c.la ${SB_VAR_GCC_RT}/lib/pthread

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
        glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread"
  gmake install-libs \
        glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread"

  for _arch in power powerpc ppc64; do
    [ ! -d "${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}" ] && continue

    # non-pthread libraries
    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}/libstdc++-v3/src
    rm libstdc++.la
    gmake LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
          toolexeclibdir="${SB_VAR_GCC_RT}/lib/${_arch}"
    gmake install-toolexeclibLTLIBRARIES \
          LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
          toolexeclibdir="${SB_VAR_GCC_RT}/lib/${_arch}"

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}/libf2c
    rm libg2c.la
    gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib"
    ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
              libg2c.la ${SB_VAR_GCC_RT}/lib/${_arch}

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/${_arch}/libobjc
    rm libobjc.la
    gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
          glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib/${_arch}"
    gmake install-libs \
          glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib/${_arch}"

    # pthread libraries
    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/${_arch}/libstdc++-v3/src
    rm libstdc++.la
    gmake LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
          toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread/${_arch}"
    gmake install-toolexeclibLTLIBRARIES \
          LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
          toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread/${_arch}"

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/${_arch}/libf2c
    rm libg2c.la
    gmake LIBG2C_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib"
    ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
              libg2c.la ${SB_VAR_GCC_RT}/lib/pthread/${_arch}

    cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/pthread/${_arch}/libobjc
    rm libobjc.la
    gmake LIBOBJC_LDFLAGS="-Wl,-blibpath:${SB_VAR_GCC_RT}/lib:/usr/lib" \
          glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread/${_arch}"
    gmake install-libs \
          glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib/pthread/${_arch}"
  done)
  ;;
*-hpux10*)
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/threads/libstdc++-v3/src
  rm libstdc++.la
  gmake LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib/threads"
  gmake install-toolexeclibLTLIBRARIES \
        LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib/threads"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  rm libstdc++.la
  gmake LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib"
  gmake install-toolexeclibLTLIBRARIES \
        LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib"

  rm ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/threads/libf2c/libg2c.la
  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib"
  ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
            libg2c.la ${SB_VAR_GCC_RT}/lib
  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/threads/libf2c
  ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
            libg2c.la ${SB_VAR_GCC_RT}/lib/threads

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/threads/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib"
  gmake install-libs glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib/threads"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib"
  ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
            libobjc.la ${SB_VAR_GCC_RT}/lib)
  ;;
*-hpux11*)
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  rm libstdc++.la
  gmake LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib"
  gmake install-toolexeclibLTLIBRARIES \
        LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib"

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libf2c
  rm libg2c.la
  gmake LIBG2C_LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib"
  ./libtool --mode=install /bin/sh ${SB_BUILD_PREFIX}/install-sh -c \
            libg2c.la ${SB_VAR_GCC_RT}/lib

  cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libobjc
  rm libobjc.la
  gmake LIBOBJC_LDFLAGS="-Wl,+s -L${SB_VAR_GCC_RT}/lib" \
        glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib"
  gmake install-libs glibcpp_toolexeclibdir="${SB_VAR_GCC_RT}/lib")
  ;;
x86_64*-linux*)
  (cd ${SB_BUILD_PREFIX}-objdir/${SB_SYSTYPE}/libstdc++-v3/src
  rm libstdc++.la
  gmake install LDFLAGS="-Wl,-rpath,${SB_VAR_GCC_RT}/lib" \
        toolexeclibdir="${SB_VAR_GCC_RT}/lib")

  (cd ${SB_BUILD_PREFIX}-objdir
  ${SB_PATH_SHTOOL} subst -q -e "\
s!^glibcpp_toolexeclibdir = .*!\
glibcpp_toolexeclibdir = ${SB_VAR_GCC_RT}/lib!; \
s!^toolexeclibdir = .*!\
toolexeclibdir = ${SB_VAR_GCC_RT}/lib!; \
s!^LIBGCJ_LDFLAGS =.*!\
LIBGCJ_LDFLAGS = -Wl,-rpath,${SB_VAR_GCC_RT}/lib!" \
  ${SB_SYSTYPE}/libjava/Makefile
  rm ${SB_SYSTYPE}/libjava/libgcj.la
  (gmake all-target-libjava)
  (cd ${SB_SYSTYPE}/libjava
  gmake install-toolexeclibLTLIBRARIES))
  ;;
esac

case "${SB_SYSTYPE}" in
*-aix*)
  find ${SB_VAR_GCC_RT} -name \*.la | while read _la; do
    ${SB_PATH_SHTOOL} subst -q -e "\
s!old_library=.*!old_library=''!; \
s!-L${SB_BUILD_PREFIX}[^ ][^ ]* !!g; \
s!-L[^ ][^ ]*/bin !!g; \
s!${SB_INSTALL_PREFIX}/lib/gcc-lib[^ ][^ ]* !!; \
s!${SB_INSTALL_PREFIX}/lib!${SB_VAR_GCC_RT}/lib!g;" ${_la}
  done
  ;;
*)
  # no static libraries
  find ${SB_VAR_GCC_RT} -name \*.a -exec rm {} \;

  # make sure every .la has a .so or .sl
  find ${SB_VAR_GCC_RT} -name \*.la | while read _la; do
    _so=${_la%%la}so
    _sl=${_la%%la}sl
    _a=${_la%%la}a

    [ ! -f ${_a} -a ! -f ${_so} -a ! -f ${_sl} ] && rm -f ${_la}
  done

  find ${SB_VAR_GCC_RT} -name \*.la | while read _la; do
    ${SB_PATH_SHTOOL} subst -q -e "\
s!old_library=.*!old_library=''!; \
s!-L${SB_BUILD_PREFIX}[^ ][^ ]* !!g; \
s!-L[^ ][^ ]*/bin !!g; \
s!${SB_INSTALL_PREFIX}/lib/gcc-lib[^ ][^ ]* !!; \
s!${SB_INSTALL_PREFIX}/lib!${SB_VAR_GCC_RT}/lib!g;" ${_la}
  done

  case "${SB_SYSTYPE}" in
  *-linux*)
    case "${SB_SYSTYPE}" in
    x86_64-*-linux*)
      _systype=${SB_SYSTYPE} ;;
    *)
      _systype=i686-pc-linux-gnu ;;
    esac

    find ${SB_VAR_GCC_RT} -name \*.la | while read _la; do
      ${SB_PATH_SHTOOL} subst -q -e "\
s!-L${SB_INSTALL_PREFIX}/${_systype}[^ ][^ ]* !!" ${_la}
    done
    ;;
  esac
  ;;
esac
]]>
    </install>


    <uninstall>
<![CDATA[
rm -rf ${SB_INSTALL_PREFIX} ${SB_VAR_GCC_RT}
]]>
    </uninstall>

    <purge>
<![CDATA[
rm -rf ${SB_BUILD_PREFIX} ${BUILD_PREFIX}-objdir \
${SB_BUILD_BASE}/gcc-4.0.0-alpha-dec-osf4.0f-bin/bin \
${SB_BUILD_BASE}/gcc-4.0.0-alpha-dec-osf5.1b-bin/bin \
${SB_BUILD_BASE}/gnat
]]>
    </purge>

    <notes>
      <change from="3.3.1" to="4.0.0">
        <items name="Bootstrap failures and problems">
          <item><para>8336 [SCO5] bootstrap config still tries to use
COFF options</para></item>
          <item><para>9330 [alpha-osf] Bootstrap failure on Compaq
Tru64 with --enable-threads=posix</para></item>
          <item><para>9631 [hppa64-linux] gcc-3.3 fails to
bootstrap</para></item>
          <item><para>9877 fixincludes makes a bad sys/byteorder.h on
svr5 (UnixWare 7.1.1)</para></item>
          <item><para>11687 xstormy16-elf build fails in
libf2c</para></item>
          <item><para>12263 [SGI IRIX] bootstrap fails during compile
of libf2c/libI77/backspace.c</para></item>
          <item><para>12490 buffer overflow in scan-decls.c (during
Solaris 9 fix-header processing)</para></item>
        </items>

        <items name="Internal compiler errors (multi-platform)">
          <item><para>7277 Casting integers to vector types causes
ICE</para></item>
          <item><para>7939 (c++) ICE on invalid function template
specialization</para></item>
          <item><para>11063 (c++) ICE on parsing initialization list
of const array member</para></item>
          <item><para>11207 ICE with negative index in array element
designator</para></item>
          <item><para>11522 (fortran) g77 dwarf-2 ICE in
add_abstract_origin_attribute</para></item>
          <item><para>11595 (c++) ICE on duplicate label
definition</para></item>
          <item><para>11646 (c++) ICE in commit_one_edge_insertion
with -fnon-call-exceptions -fgcse -O</para></item>
          <item><para>11665 ICE in struct initializer when taking
address</para></item>
          <item><para>11852 (c++) ICE with bad struct
initializer.</para></item>
          <item><para>11878 (c++) ICE in cp_expr_size</para></item>
          <item><para>11883 ICE with any -O on mercury-generated C
code</para></item>
          <item><para>11991 (c++) ICE in
cxx_incomplete_type_diagnostic, in cp/typeck2.c when applying typeid
operator to template template parameter</para></item>
          <item><para>12146 ICE in lookup_template_function, in
cp/pt.c</para></item>
          <item><para>12215 ICE in make_label_edge with
-fnon-call-exceptions -fno-gcse -O2</para></item>
          <item><para>12369 (c++) ICE with templates and
friends</para></item>
          <item><para>12446 ICE in emit_move_insn on complicated array
reference</para></item>
          <item><para>12510 ICE in final_scan_insn</para></item>
          <item><para>12544 ICE with large parameters used in nested
functions</para></item>
        </items>

        <items name="C and optimization bugs">
          <item><para>9862 spurious warnings with -W
-finline-functions</para></item>
          <item><para>10962 lookup_field is a linear search on a
linked list (can be slow if large struct)</para></item>
          <item><para>11370 -Wunreachable-code gives false
complaints</para></item>
          <item><para>11637 invalid assembly with
-fnon-call-exceptions</para></item>
          <item><para>11885 Problem with bitfields in packed
structs</para></item>
          <item><para>12082 Inappropriate unreachable code
warnings</para></item>
          <item><para>12180 Inline optimization fails for variadic
function</para></item>
          <item><para>12340 loop unroller + gcse produces wrong
code</para></item>
        </items>

        <items name="C++ compiler and library">
          <item><para>3907 nested template parameter collides with
member name</para></item>
          <item><para>5293 confusing message when binding a temporary
to a reference</para></item>
          <item><para>5296 [DR115] Pointers to functions and to
template functions behave differently in deduction</para></item>
          <item><para>7939 ICE on function template
specialization</para></item>
          <item><para>8656 Unable to assign function with
__attribute__ and pointer return type to an appropriate
variable</para></item>
          <item><para>10147 Confusing error message for invalid
template function argument</para></item>
          <item><para>11400 std::search_n() makes assumptions about
Size parameter * 11409 issues with using declarations, overloading,
and built-in functions</para></item>
          <item><para>11740 <command>ctype&lt;wchar_t&gt;::do_is(mask,
wchar_t)</command> doesn't handle multiple bits in mask</para></item>
          <item><para>11786 operator() call on variable in other
namespace not recognized</para></item>
          <item><para>11867 static_cast ignores
ambiguity</para></item>
          <item><para>11928 bug with conversion operators that are
typedefs</para></item>
          <item><para>12163 static_cast + explicit constructor
regression</para></item>
          <item><para>12181 Wrong code with comma operator and
c++</para></item>
          <item><para>12236 regparm and fastcall messes up
parameters</para></item>
          <item><para>12266 incorrect instantiation of unneeded
template during overload resolution</para></item>
          <item><para>12296 istream::peek() doesn't set
eofbit</para></item>
          <item><para>12298 [sjlj exceptions] Stack unwind destroys
not-yet-constructed object</para></item>
          <item><para>12369 ICE with templates and
friends</para></item>
          <item><para>12337 apparently infinite loop in
g++</para></item>
          <item><para>12344 stdcall attribute ignored if function
returns a pointer</para></item>
          <item><para>12451 missing(late) class forward declaration in
cxxabi.h</para></item>
          <item><para>12486 g++ accepts invalid use of a qualified
name</para></item>
        </items>

        <items name="x86 specific (Intel/AMD)">
          <item><para>8869 [x86 MMX] ICE with const variable
optimization and MMX builtins</para></item>
          <item><para>9786 ICE in fixup_abnormal_edges with
-fnon-call-exceptions -O2</para></item>
          <item><para>11689 g++3.3 emits un-assembleable code for k6
architecture</para></item>
          <item><para>12116 [k6] Invalid assembly output values with
X-MAME code</para></item>
          <item><para>12070 ICE converting between double and long
double with -msoft-float</para></item>
        </items>

        <items name="ia64-specific">
          <item><para>11184 [ia64 hpux] ICE on __builtin_apply
building libobjc</para></item>
          <item><para>11535 __builtin_return_address may not work on
ia64</para></item>
          <item><para>11693 [ia64] ICE in gen_nop_type</para></item>
          <item><para>12224 [ia64] Thread-local storage doesn't
work</para></item>
        </items>

        <items name="PowerPC-specific">
          <item><para>11087 [powerpc64-linux] GCC miscompiles raid1.c
from linux kernel</para></item>
          <item><para>11319 loop miscompiled on ppc32</para></item>
          <item><para>11949 ICE Compiler segfault with ffmpeg
-maltivec code</para></item>
        </items>

        <items name="SPARC-specific">
          <item><para>11662 wrong code for expr. with cast to long
long and exclusive or</para></item>
          <item><para>11965 invalid assembler code for a shift &lt; 32
operation</para></item>
          <item><para>12301 (c++) stack corruption when a returned
expression throws an exception</para></item>
        </items>

        <items name="Alpha-specific">
          <item><para>11717 [alpha-linux] unrecognizable insn
compiling for.c of kernel 2.4.22-pre8</para></item>
        </items>

        <items name="HPUX-specific">
          <item><para>11313 problem with #pragma weak and static
inline functions</para></item>
          <item><para>11712 __STDC_EXT__ not defined for C++ by
default anymore?</para></item>
        </items>

        <items name="Solaris specific">
          <item><para>12166 Profiled programs crash if PROFDIR is
set</para></item>
        </items>

        <items name="Solaris-x86 specific">
          <item><para>12101 i386 Solaris no longer works with GNU
as?</para></item>
        </items>

        <items name="Miscellaneous embedded target-specific bugs">
          <item><para>10988 [m32r-elf] wrong blockmove code with
-O3</para></item>
          <item><para>11805 [h8300-unknown-coff] [H8300] ICE for
simple code with -O2 11902 [sh4] spec file improperly inserts rpath
even when none needed</para></item>
          <item><para>11903 [sh4] -pthread fails to link due to error
in spec file on sh4</para></item>
        </items>
      </change>

      <change from="3.3" to="3.3.1">
        <items name="bootstrap failures">
          <item><para>11272 [Solaris] make bootstrap fails while
building libstdc++</para></item>
        </items>

        <items name="Internal compiler errors (multi-platform)">
          <item><para>5754 ICE on invalid nested template
class</para></item>
          <item><para>6597 ICE in set_mem_alias_set compiling Qt with
-O2 on ia64 and --enable-checking</para></item>
          <item><para>6949 (c++) ICE in tsubst_decl, in
cp/pt.c</para></item>
          <item><para>7053 (c++) ICE when declaring a function already
defined as a friend method of a template class</para></item>
          <item><para>8164 (c++) ICE when using different const
expressions as template parameter</para></item>
          <item><para>8384 (c++) ICE in is_base_type, in
dwarf2out.c</para></item>
          <item><para>9559 (c++) ICE with invalid initialization of a
static const</para></item>
          <item><para>9649 (c++) ICE in finish_member_declaration, in
cp/semantics.c when redeclaring a static member variable</para></item>
          <item><para>9864 (fortran) ICE in
add_abstract_origin_attribute, in dwarfout.c with -g -O
-finline-functions</para></item>
          <item><para>10432 (c++) ICE in poplevel, in
cp/decl.c</para></item>
          <item><para>10475 ICE in subreg_highpart_offset for code
with long long</para></item>
          <item><para>10635 (c++) ICE when dereferencing an incomplete
type casted from a void pointer</para></item>
          <item><para>10661 (c++) ICE in instantiate_decl, in cp/pt.c
while instantiating static member variables</para></item>
          <item><para>10700 ICE in copy_to_mode_reg on 64-bit
targets</para></item>
          <item><para>10712 (c++) ICE in constructor_name_full, in
cp/decl2.c</para></item>
          <item><para>10796 (c++) ICE when defining an enum with two
values: -1 and MAX_INT_64BIT</para></item>
          <item><para>10890 ICE in merge_assigned_reloads building
Linux 2.4.2x sched.c</para></item>
          <item><para>10939 (c++) ICE with template code</para></item>
          <item><para>10956 (c++) ICE when specializing a template
member function of a template class, in tsubst, in
cp/pt.c</para></item>
          <item><para>11041 (c++) ICE: const myclass &amp;x = *x; (when
operator*() defined)</para></item>
          <item><para>11059 (c++) ICE with empty union</para></item>
          <item><para>11083 (c++) ICE in commit_one_edge_insertion, in
cfgrtl.c with -O2 -fnon-call-exceptions</para></item>
          <item><para>11105 (c++) ICE in
mangle_conv_op_name_for_type</para></item>
          <item><para>11149 (c++) ICE on error when instantiation with
call function of a base type</para></item>
          <item><para>11228 (c++) ICE on new-expression using array
operator new and default-initialization</para></item>
          <item><para>11282 (c++) Infinite memory usage after syntax
error</para></item>
          <item><para>11301 (fortran) ICE with
-fno-globals</para></item>
          <item><para>11308 (c++) ICE when using an enum type name as
if it were a class or namespace</para></item>
          <item><para>11473 (c++) ICE with -gstabs when empty struct
inherits from an empty struct</para></item>
          <item><para>11503 (c++) ICE when instantiating template with
ADDR_EXPR</para></item>
          <item><para>11513 (c++) ICE in push_template_decl_real, in
cp/pt.c: template member functions</para></item>
        </items>

        <items name="Optimization bugs">
          <item><para>11198 -O2 -frename-registers generates wrong
code (aliasing problem)</para></item>
          <item><para>11304 Wrong code production with
-fomit-frame-pointer</para></item>
          <item><para>11381 volatile memory access optimized
away</para></item>
          <item><para>11536 [strength-reduce] -O2 optimization
produces wrong code</para></item>
          <item><para>11557 constant folding bug generates wrong
code</para></item>
        </items>

        <items name="C front end">
          <item><para>5897 No warning for statement after
return</para></item>
          <item><para>11279 DWARF-2 output mishandles large
enums</para></item>
        </items>

        <items name="Preprocessor bugs">
          <item><para>11022 no warning for non-compatible macro
redefinition</para></item>
        </items>

        <items name="C++ compiler and library">
          <item><para>2330 static_cast&lt;&gt;() to a private base is
allowed</para></item>
          <item><para>5388 Incorrect message "operands to ?: have
different types"</para></item>
          <item><para>5390 Libiberty fails to demangle multi-digit
template parameters</para></item>
          <item><para>7877 Incorrect parameter passing to
specializations of member function templates</para></item>
          <item><para>9393 Anonymous namespaces and compiling the same
file twice</para></item>
          <item><para>10032 -pedantic converts some errors to
warnings</para></item>
          <item><para>10468 const typeof(x) is non-const, but only in
templates</para></item>
          <item><para>10527 confused error message with "new int()"
parameter initializer</para></item>
          <item><para>10679 parameter MIN_INLINE_INSNS is not
honored</para></item>
          <item><para>10682 gcc chokes on a typedef for an enum inside
a class template</para></item>
          <item><para>10689 pow(std::complex(0),1/3) returns (nan,
nan) instead of 0.</para></item>
          <item><para>10845 template member function (with nested
template as parameter) cannot be called anymore if another unrelated
template member function is defined</para></item>
          <item><para>10849 Cannot define an out-of-class
specialization of a private nested template class</para></item>
          <item><para>10888 Suppress -Winline warnings for system
headers</para></item>
          <item><para>10929 -Winline warns about functions for which
no definition is visible</para></item>
          <item><para>10931 valid conversion static_cast&lt;const
unsigned int&amp;&gt;(lvalue-of-type-int) is rejected</para></item>
          <item><para>10940 Bad code with explicit
specialization</para></item>
          <item><para>10968 If member function implicitly
instantiated, explicit instantiation of class fails to instantiate
it</para></item>
          <item><para>10990 Cannot convert with dynamic_cast&lt;&gt;
to a private base class from within a member function</para></item>
          <item><para>11039 Bad interaction between implicit typename
deprecation and friendship</para></item>
          <item><para>11062 (libstdc++) avoid __attribute__
((unused)); say "__unused__" instead</para></item>
          <item><para>11095 C++ iostream manipulator causes segfault
when called with negative argument</para></item>
          <item><para>11098 g++ doesn't emit complete debugging
information for local variables in destructors</para></item>
          <item><para>11137 Linux shared library constructors not
called unless there's one global object</para></item>
          <item><para>11154 spurious ambiguity report for template
class specialization</para></item>
          <item><para>11329 Compiler cannot find user defined implicit
typecast</para></item>
          <item><para>11332 Spurious error with casts in ?:
expression</para></item>
          <item><para>11431 static_cast behavior with subclasses when
default constructor available</para></item>
          <item><para>11528 money_get facet does not accept "$.00" as
valid</para></item>
          <item><para>11546 Type lookup problems in out-of-line
definition of a class doubly nested from a template
class</para></item>
          <item><para>11567 C++ code containing templated member
function with same name as pure virtual member function results in
linking failure</para></item>
          <item><para>11645 Failure to deal with using and private
inheritance</para></item>
        </items>

        <items name="Java compiler and library">
          <item><para>5179 Qualified static field access doesn't
initialize its class</para></item>
          <item><para>8204 gcj -O2 to native reorders certain
instructions improperly</para></item>
          <item><para>10838 java.io.ObjectInputStream syntax
error</para></item>
          <item><para>10886 The RMI registry that comes with GCJ does
not work correctly</para></item>
          <item><para>11349 JNDI URL context factories not located
correctly</para></item>
        </items>

        <items name="x86-specific (Intel/AMD)">
          <item><para>4823 ICE on inline assembly code</para></item>
          <item><para>8878 miscompilation with -O and
SSE</para></item>
          <item><para>9815 (c++ library) atomicity.h - fails to
compile with -O3 -masm=intel</para></item>
          <item><para>10402 (inline assembly) [x86] ICE in
merge_assigned_reloads, in reload1.c</para></item>
          <item><para>10504 ICE with SSE2 code and -O3 -mcpu=pentium4
-msse2</para></item>
          <item><para>10673 ICE for x86-64 on freebsd libc vfprintf.c
source</para></item>
          <item><para>11044 [x86] out of range loop instructions for
FP code on K6</para></item>
          <item><para>11089 ICE: instantiate_virtual_regs_lossage
while using SSE built-ins</para></item>
          <item><para>11420 [x86_64] gcc generates invalid asm code
when "-O -fPIC" is used</para></item>
        </items>

        <items name="Sparc- or Solaris- specific">
          <item><para>9362 solaris 'as' dies when fed .s and
"-gstabs"</para></item>
          <item><para>10142 [SPARC64] gcc produces wrong code when
passing structures by value</para></item>
          <item><para>10663 New configure check aborts with Sun
tools.</para></item>
          <item><para>10835 combinatorial explosion in scheduler on
HyperSPARC</para></item>
          <item><para>10876 ICE in calculate_giv_inc when building
KDE</para></item>
          <item><para>10955 wrong code at -O3 for structure argument
in context of structure return</para></item>
          <item><para>11018 -mcpu=ultrasparc busts
tar-1.13.25</para></item>
          <item><para>11556 [sparc64] ICE in gen_reg_rtx() while
compiling 2.6.x Linux kernel</para></item>
        </items>

        <items name="ia64 specific">
          <item><para>10907 gcc violates the ia64 ABI (GP must be
preserved)</para></item>
          <item><para>11320 scheduler bug (in machine depended
reorganization pass)</para></item>
          <item><para>11599 bug with conditional and
__builtin_prefetch</para></item>
        </items>

        <items name="PowerPC specific">
          <item><para>9745 [powerpc] gcc mis-compiles libmcrypt (alias
problem during loop)</para></item>
          <item><para>10871 error in rs6000_stack_info save_size
computation</para></item>
          <item><para>11440 gcc mis-compiles c++ code (libkhtml) with
-O2, -fno-gcse cures it</para></item>
        </items>

        <items name="m68k-specific">
          <item><para>7594 [m68k] ICE on legal code associated with
simplify-rtx</para></item>
          <item><para>10557 [m68k] ICE in
subreg_offset_representable_p</para></item>
          <item><para>11054 [m68k] ICE in
reg_overlap_mentioned_p</para></item>
        </items>

        <items name="ARM-specific">
          <item><para>10842 [arm] Clobbered link register is copied to
pc under certain circumstances</para></item>
          <item><para>11052 [arm] noce_process_if_block() can lose
REG_INC notes</para></item>
          <item><para>11183 [arm] ICE in change_address_1 (3.3) /
subreg_hard_regno (3.4)</para></item>
        </items>

        <items name="MIPS-specific">
          <item><para>11084 ICE in propagate_one_insn, in
flow.c</para></item>
        </items>

        <items name="SH-specific">
          <item><para>10331 can't compile c++ part of gcc cross
compiler for sh-elf</para></item>
          <item><para>10413 [SH] ICE in reload_cse_simplify_operands,
in reload1.c</para></item>
          <item><para>11096 i686-linux to sh-linux cross compiler
fails to compile C++ files</para></item>
        </items>

        <items name="GNU/Linux (or Hurd?) specific">
          <item><para>2873 Bogus fixinclude of stdio.h from glibc
2.2.3</para></item>
        </items>

        <items name="UnixWare specific">
          <item><para>3163 configure bug: gcc/aclocal.m4 mmap test
fails on UnixWare 7.1.1</para></item>
        </items>

        <items name="Cygwin (or mingw) specific">
          <item><para>5287 ICE with dllimport attribute</para></item>
          <item><para>10148 [MingW/CygWin] Compiler dumps
core</para></item>
        </items>

        <items name="DJGPP specific">
          <item><para>8787 GCC fails to emit .intel_syntax when
invoked with -masm=intel on DJGPP</para></item>
        </items>

        <items name="Documentation">
          <item><para>1607 (c++) Format attributes on methods
undocumented</para></item>
          <item><para>4252 Invalid option
`-fdump-translation-unit'</para></item>
          <item><para>4490 Clarify restrictions on
-m96bit-long-double, -m128bit-long-double</para></item>
          <item><para>10355 document an issue with regparm attribute
on some systems (e.g. Solaris)</para></item>
          <item><para>10726 (fortran) Documentation for function
"IDate Intrinsic (Unix)" is wrong</para></item>
          <item><para>10805 document bug in old version of Sun
assembler</para></item>
          <item><para>10815 warn against GNU binutils on
AIX</para></item>
          <item><para>10877 document need for newer binutils on
i?86-*-linux-gnu</para></item>
          <item><para>11280 Manual incorrect with respect to
-freorder-blocks</para></item>
          <item><para>11466 Document -mlittle-endian and its
restrictions for the sparc64 port</para></item>
        </items>

        <items name="Testsuite bugs (compiler itself is not affected)">
          <item><para>10737 newer bison causes g++.dg/parse/crash2.C
to incorrectly report failure</para></item>
          <item><para>10810 gcc-3.3 fails make check: buffer overrun
in test_demangle.c</para></item>
        </items>

        <items name="GCC 3.3 Release Series (Caveats)">
          <item><para>The preprocessor no longer accepts multi-line
string literals. They were deprecated in 3.0, 3.1, and
3.2.</para></item>
          <item><para>The preprocessor no longer supports the -A-
switch when appearing alone. -A- followed by an assertion is still
supported.</para></item>
          <item><para>Support for all the systems obsoleted in GCC 3.1
has been removed from GCC 3.3. See below for a list of systems which
are obsoleted in this release.</para></item>
          <item><para>Checking for null format arguments has been
decoupled from the rest of the format checking mechanism. Programs
which use the format attribute may regain this functionality by using
the new nonnull function attribute. Note that all functions for which
GCC has a built-in format attribute, an appropriate built-in nonnull
attribute is also applied.</para></item>
          <item><para>The DWARF (version 1) debugging format has been
deprecated and will be removed in a future version of GCC. Version 2
of the DWARF debugging format will continue to be supported for the
foreseeable future.</para></item>
          <item><para>The C and Objective-C compilers no longer accept
the "Naming Types" extension (typedef foo = bar); it was already
unavailable in C++. Code which uses it will need to be changed to use
the "typeof" extension instead: typedef typeof(bar) foo. (We have
removed this extension without a period of deprecation because it has
caused the compiler to crash since version 3.0 and no one noticed
until very recently. Thus we conclude it is not in widespread
use.)</para></item>
          <item><para>The -traditional C compiler option has been
removed. It was deprecated in 3.1 and 3.2. (Traditional preprocessing
remains available.) The &lt;varargs.h&gt; header, used for writing
variadic functions in traditional C, still exists but will produce an
error message if used.</para></item>
        </items>

        <items name="GCC 3.3 Release Series (General Optimizer Improvements)">
          <item><para>A new scheme for accurately describing processor
pipelines, the DFA scheduler, has been added.</para></item>
          <item><para>Pavel Nejedly, Charles University Prague, has
contributed new file format used by the edge coverage profiler
(-fprofile-arcs).</para>
          <para>The new format is robust and diagnoses common mistakes
where profiles from different versions (or compilations) of the
program are combined resulting in nonsensical profiles and slow code
to produced with profile feedback. Additionally this format allows
extra data to be gathered. Currently, overall statistics are produced
helping optimizers to identify hot spots of a program globally
replacing the old intra-procedural scheme and resulting in better
code. Note that the gcov tool from older GCC versions will not be able
to parse the profiles generated by GCC 3.3 and vice
versa.</para></item>
          <item><para>Jan Hubicka, SuSE Labs, has contributed a new
superblock formation pass enabled using -ftracer. This pass simplifies
the control flow of functions allowing other optimizations to do
better job.</para>
          <para>He also contributed the function reordering pass
(-freorder-functions) to optimize function placement using profile
feedback.</para></item>
        </items>

        <items name="GCC 3.3 Release Series (C/ObjC/C++)">
          <item><para>The preprocessor now accepts directives within
macro arguments. It processes them just as if they had not been within
macro arguments.</para></item>
          <item><para>The separate ISO and traditional preprocessors
have been completely removed. The front-end handles either type of
preprocessed output if necessary.</para></item>
          <item><para>In C99 mode preprocessor arithmetic is done in
the precision of the target's intmax_t, as required by that
standard.</para></item>
          <item><para>The preprocessor can now copy comments inside
macros to the output file when the macro is expanded. This feature,
enabled using the -CC option, is intended for use by applications
which place metadata or directives inside comments, such as
lint.</para></item>
          <item><para>The method of constructing the list of
directories to be searched for header files has been revised. If a
directory named by a -I option is a standard system include directory,
the option is ignored to ensure that the default search order for
system directories and the special treatment of system header files
are not defeated.</para></item>
          <item><para>A few more ISO C99 features now work
correctly.</para></item>
          <item><para>A new function attribute, nonnull, has been
added which allows pointer arguments to functions to be specified as
requiring a non-null value.  The compiler currently uses this
information to issue a warning when it detects a null value passed in
such an argument slot.</para></item>
          <item><para>A new type attribute, may_alias, has been added.
Accesses to objects with types with this attribute are not subjected
to type-based alias analysis, but are instead assumed to be able to
alias any other type of objects, just like the char
type.</para></item>
        </items>

        <items name="GCC 3.3 Release Series (C/ObjC/C++)">
          <item><para>Type based alias analysis has been implemented
for C++ aggregate types</para></item>
        </items>

        <items name="GCC 3.3 Release Series (Objective-C)">
          <item><para>Generate an error if Objective-C objects are
passed by value in function and method calls</para></item>
          <item><para>When -Wselector is used, check the whole list of
selectors at the end of compilation, and emit a warning if a
@selector() is not known</para></item>
          <item><para>Define __NEXT_RUNTIME__ when compiling for the
NeXT runtime</para></item>
          <item><para>No longer need to include objc/objc-class.h to
compile self calls in class methods (NeXT runtime only)</para></item>
          <item><para>New -Wundeclared-selector option</para></item>
          <item><para>Removed selector bloating which was causing
object files to be 10% bigger on average (GNU runtime
only)</para></item>
          <item><para>Using at run time @protocol() objects has been
fixed in certain situations (GNU runtime only)</para></item>
          <item><para>Type checking has been fixed and improved in
many situations involving protocols</para></item>
        </items>

        <items name="GCC 3.3 Release Series (Java)">
          <item><para>The java.sql and javax.sql packages now
implement the JDBC 3.0 (JDK 1.4) API</para></item>
          <item><para>The JDK 1.4 assert facility has been
implemented</para></item>
          <item><para>The bytecode interpreter is now direct threaded
and thus faster</para></item>
        </items>

        <items name="GCC 3.3 Release Series (Fortran)">
          <item><para>Fortran improvements are listed in the Fortran
documentation</para></item>
        </items>

        <items name="GCC 3.3 Release Series (Ada)">
          <item><para>Ada tasking now works with glibc 2.3.x threading
libraries</para></item>
        </items>

        <items name="GCC 3.3 Release Series (New Targets and Target Specific Improvements)">
          <item><para>The following changes have been made to the
HP-PA port:</para>
          <unorderedlist>
            <item><para>The port now defaults to scheduling for the
PA8000 series of processors</para></item>
            <item><para>Scheduling support for the PA7300 processor
has been added</para></item>
            <item><para>The 32-bit port now supports weak symbols
under HP-UX 11</para></item>
            <item><para>The handling of initializers and finalizers
has been improved under HP-UX 11. The 64-bit port no longer uses
collect2.</para></item>
            <item><para>Dwarf2 EH support has been added to the 32-bit
linux port</para></item>
            <item><para>ABI fixes to correct the passing of small
structures by value</para></item>
          </unorderedlist></item>
          <item><para>The SPARC, HP-PA, SH4, and x86/pentium ports
have been converted to use the DFA processor pipeline
description.</para></item>
          <item><para>The following NetBSD configurations for the
SuperH processor family have been added:</para>
          <unorderedlist>
            <item><para>SH3, big-endian, sh-*-netbsdelf*</para></item>
            <item><para>SH3, little-endian,
shle-*-netbsdelf*</para></item>
            <item><para>SH5, SHmedia, big-endian, 32-bit default,
sh5-*-netbsd*</para></item>
            <item><para>SH5, SHmedia, little-endian, 32-bit default,
sh5le-*-netbsd*</para></item>
            <item><para>SH5, SHmedia, big-endian, 64-bit default,
sh64-*-netbsd*</para></item>
            <item><para>SH5, SHmedia, little-endian, 64-bit default,
sh64le-*-netbsd*</para></item>
          </unorderedlist></item>
          <item><para>The following changes have been made to the
IA-32/x86-64 port:</para>
          <unorderedlist>
            <item><para>SSE2 and 3dNOW! intrinsics are now
supported</para></item>
            <item><para>Support for thread local storage has been
added to the IA-32 and x86-64 ports</para></item>
            <item><para>The x86-64 port has been significantly
improved</para></item>
          </unorderedlist></item>
          <item><para>The following changes have been made to the MIPS
port</para>
          <unorderedlist>
            <item><para>All configurations now accept the -mabi
switch. Note that you will need appropriate multilibs for this option
to work properly.</para></item>
            <item><para>ELF configurations will always pass an ABI
flag to the assembler, except when the MIPS EABI is
selected</para></item>
            <item><para>-mabi=64 no longer selects MIPS IV
code</para></item>
            <item><para>The -mcpu option, which was deprecated in 3.1
and 3.2, has been removed from this release</para></item>
            <item><para>-march now changes the core ISA level. In
previous releases, it would change the use of processor-specific
extensions, but would leave the core ISA unchanged. For example,
mips64-elf -march=r8000 will now generate MIPS IV code.</para></item>
            <item><para>Under most configurations, -mipsN now acts as
a synonym for -march</para></item>
            <item><para>There are some new preprocessor macros to
describe the -march and -mtune settings. See the documentation of
those options for details.</para></item>
            <item><para>Support for the NEC VR-Series processors has
been added. This includes the 54xx, 5500, and 41xx
series.</para></item>
            <item><para>Support for the Sandcraft sr71k processor has
been added</para></item>
          </unorderedlist></item>
          <item><para>The following changes have been made to the
S/390 port:</para>
          <unorderedlist>
            <item><para>Support to build the Java runtime libraries
has been added. Java is now enabled by default on s390-*-linux* and
s390x-*-linux* targets.</para></item>
            <item><para>Multilib support for the s390x-*-linux* target
has been added; this allows to build 31-bit binaries using the -m31
option.</para></item>
            <item><para>Support for thread local storage has been
added.</para></item>
            <item><para>Inline assembler code may now use the 'Q'
constraint to specify memory operands without index
register.</para></item>
            <item><para>Various platform-specific performance
improvements have been implemented; in particular, the compiler now
uses the BRANCH ON COUNT family of instructions and makes more
frequent use of the TEST UNDER MASK family of
instructions.</para></item>
          </unorderedlist></item>
          <item><para>The following changes have been made to the
PowerPC port:</para>
          <unorderedlist>
            <item><para>Support for IBM Power4 processor
added</para></item>
            <item><para>Support for Motorola e500 SPE
added</para></item>
            <item><para>Support for AIX 5.2 added</para></item>
            <item><para>Function and Data sections now supported on
AIX</para></item>
            <item><para>Sibcall optimizations added</para></item>
          </unorderedlist></item>
          <item><para>The support for H8 Tiny is added to the H8/300
port with -mn</para></item>
        </items>

        <items name="GCC 3.3 Release Series (Other significant improvements)">
          <item><para>Almost all front-end dependencies in the
compiler have been separated out into a set of language hooks. This
should make adding a new front end clearer and easier.</para></item>
          <item><para>One effect of removing the separate preprocessor
is a small increase in the robustness of the compiler in general, and
the maintainability of target descriptions. Previously target-specific
built-in macros and others, such as __FAST_MATH__, had to be handled
with so-called specs that were hard to maintain. Often they would fail
to behave properly when conflicting options were supplied on the
command line, and define macros in the user's namespace even when
strict ISO compliance was requested. Integrating the preprocessor has
cleanly solved these issues.</para></item>
          <item><para>The Makefile suite now supports redirection of
make install by means of the variable DESTDIR</para></item>
        </items>
      </change>

      <note type="compilation">
        <para>A separate runtime directory is available containing the
shared GCC libraries, <command>${SB_INSTALL_PREFIX}r</command>. Unlike the
GCC 2.95.3 release, the normal GCC installation in
<command>${SB_INSTALL_PREFIX}</command> also contains the shared
libraries. The shared libraries in the runtime path can be linked
against to avoid the dependency on the full GCC installation.</para>

        <para>The GCC specs file has been modified on HP-UX, IRIX,
Redhat Linux, and Solaris to automatically add the runtime search path
to executables and binaries during the link stage. The specs file was 
not modified on AIX and Tru64 UNIX because the -blibpath/-rpath linker 
option is not additive.</para>

        <para>The Ada compiler is available for Solaris 2.5.1, 7, 8,
9/SPARC and Redhat Linux 7.1. The GCJ java compiler is available for
all platforms except Solaris 2.5.1/SPARC and IRIX 6.5. All supported
platforms contain the C, C++, and Fortran compilers.</para>

        <para>The C++ library used with this release of GCC is
incompatible with C++ libraries built with versions of GCC prior to
3.2.</para>

        <para>GCC can generate 64-bit binaries under IRIX 6.5 using
the ``<command>-mabi=64</command>'' command-line switch, under Solaris
7, 8, and 9/SPARC using the ``<command>-m64</command>'' command-line
switch, and under AIX 5.1 using the ``<command>-maix64</command>''
command-line switch.</para>
      </note>

      <note type="configuration">
        <para>The script used to fix up the system headers for use
with GCC is available in the installation directory,
"<command>${SB_INSTALL_PREFIX}/lib/gcc-lib/[arch]/4.0.0/install-tools</command>".
To execute it, first make a backup of the existing include directory
and then run the "<command>mkheaders</command>" script:</para>
        <screen>
# /bin/sh
# cd ${SB_INSTALL_PREFIX}/lib/gcc-lib/[arch]/4.0.0
# tar cf include.tar include
# cd ${SB_INSTALL_PREFIX}/lib/gcc-lib/[arch]/4.0.0/install-tools
# SHELL=/bin/sh sh mkheaders
        </screen>

        <para>The "<command>[arch]</command>" name corresponds to the
GNU system type for the host.</para>
      </note>

      <platform name="Redhat Enterprise Linux/AMD64">
        <para>GCC was built with --disable-multilib to disable support
for 32 and 64-bit GCC libraries (libgcc, libstdc++, etc.). The
${SB_INSTALL_PREFIX}/lib path contains 64-bit libraries. Generating
32-bit binaries/libraries is not possible.</para>
      </platform>
    </notes>

    <changelog>
      <change date="2004 August 8" revision="5"
      author="Albert Chin-A-Young" email="china@thewrittenword.com">
        <item><para>Remove dependencies</para></item>
        <item><para>Support for RHEL 3.0/AMD64</para></item>
      </change>

      <change date="2004 April 12" revision="4"
      author="Albert Chin-A-Young" email="china@thewrittenword.com">
        <item><para>Fix paths in .la files</para></item>
        <item><para>Build ADA for Tru64 UNIX</para></item>
      </change>

      <change date="2004 April 9" revision="3"
      author="Albert Chin-A-Young" email="china@thewrittenword.com">
        <item><para>Fix runtime library path on AIX and
HP-UX</para></item>
      </change>

      <change date="2004 February 15" revision="2"
      author="Albert Chin-A-Young" email="china@thewrittenword.com">
        <item><para>Apply fix for PR11397 (weak aliases broken on
Tru64 UNIX)</para></item>
        <item><para>Apply fix for PR13150 (WEAK symbols not exported
by collect2)</para></item>
        <item><para>Apply fix for PR14113 (-O2 corrupts
stack)</para></item>
        <item><para>Apply fix for PR13354 (internal compiler error: in
sparc_emit_set_const32)</para></item>
        <item><para>Apply fix for PR12865 ("mprotect" call to make
trampoline executable may fail)</para></item>
        <item><para>Apply fix for PR12496 (wrong result for
__atomic_add(&amp;value, -1) when using -O0 -m64)</para></item>
        <item><para>Apply fix for PR11634 (ICE in
verify_local_live_at_start, at flow.c:555)</para></item>
        <item><para>Apply fix for PR13031 (ICE (unrecognizable insn)
when building gnome-libs-1.4.2)</para></item>
        <item><para>Apply fix for PR12965 (SEGV+ICE in cc1plus on
alpha-linux with -O2)</para></item>
        <item><para>Apply fix for PR12654 (Incorrect comparison code
generated for Alpha)</para></item>
        <item><para>Apply fix for PR4490 (ICE with
-m128bit-long-double)</para></item>
        <item><para>Apply fix for PR12441 (Can't spill register
bug)</para></item>
        <item><para>Apply fix for PR13608 (Incorrect code with -O3
-ffast-math)</para></item>
      </change>

      <change date="2004 January 23" revision="1"
      author="Albert Chin-A-Young" email="china@thewrittenword.com">
        <item><para>Upgrade Perl dependency to 5.8.2</para></item>
      </change>
    </changelog>
  </program>
</programs>
