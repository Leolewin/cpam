#! /usr/bin/bash
# Copyright 2002, 2003 Free Software Foundation
# by Alexandre Oliva <aoliva@redhat.com>

# This script is Free Software, and it can be copied, distributed and
# modified as defined in the GNU General Public License.  A copy of
# its license can be downloaded from http://www.gnu.org/copyleft/gpl.html

# This is a wrapper for distcc that turns relative pathnames into
# network-neutral ones.  It modifies anything containing a slash and
# not starting with dash or slash, as well as -B flags.  We need not
# be concerned about -I and -L, since distcc always does preprocessing
# and linking locally.

# To use it, set the STAGE_CC_WRAPPER to the name of this script, and
# the GCC build machinery will use it when buildling bootstrap stages
# and target libraries.  You will also need to point NETPWD to the
# netpwd script, and perhaps customize it to map pathnames properly
# for your environment.  You may also want to set DISTCCREL_LOCALHOST
# and or DISTCCREL_HOSTS, per comments below.

# If distccrel is invoked with echo as the first argument, instead of
# running distcc with the rest of the command line, it will print the
# command it would have run.


# Using cd -P works around a bug in bash 2.05b-3, when resolving
# complex pathnames involving a few symlinks.

if (cd -P .) > /dev/null 2>&1; then
  CD='cd -P'
else
  CD='cd'
fi

# If the first pathname contains any slash (.../xgcc, ./libtool, etc),
case "$1" in
echo | */*)
  nargs=$#
  basedir=`${NETPWD-netpwd}`

  if (unset CDPATH) >/dev/null 2>&1; then
    unset CDPATH
  else
    CDPATH=:.
  fi

  # then process arguments
  prev=
  for arg
  do
    case $arg in
    -fworking-directory)

      # If this flag is present in the command line, we don't have to
      # disable the use of localhost: GCC will emit the preprocessing
      # pwd in debugging info.  In general, it's not present in the
      # command line, though, so you have to set it yourself.
      DISTCCREL_LOCALHOST=localhost
      ;;

    -B[^/]*)
      arg=-B$basedir/`echo "X$arg" | sed -e '1s/^X-B//'`
      ;;

    [^-/]*/?*)
      case $prev in
      -include)
        if test -f $basedir/$arg; then
          arg=$basedir/$arg
	fi
	;;
      *)
        arg=$basedir/$arg
	;;
      esac
      ;;

    /*)
      dir=$arg

      if test -d "$dir"; then

	# Preserve trailing slashes, if any (but not the first leading slash)
	# in trailer.
	trailer=`echo "$dir" | sed -e 's,^/\(/*\),\1,;s,/*[^/][^/]*,,g;s,\(/*\)$,\1,'`
	dir=`$CD "$dir" && ${NETPWD-netpwd} || echo "dir"`$trailer

      elif test -f "$dir"; then
	newdir=`echo "$dir" | sed -e 's,//*[^/][^/]*$,,;s,^$,/,'`
 	newdirlenindots=`echo "$newdir" | sed s,.,.,g`
 	trailer=`echo "$dir" | sed -e s,$newdirlenindots,,`
 	dir=$newdir

	dir=`$CD "$dir" && ${NETPWD-netpwd} || echo "dir"`$trailer
      fi

      arg=$dir
      ;;

    -B/*)
      dir=`echo "X$arg" | sed -e '1s/X-B//'`

      if test -d "$dir"; then

	# Preserve trailing slashes, if any (but not the first leading slash)
	# in trailer.
	trailer=`echo "$dir" | sed -e 's,^/\(/*\),\1,;s,/*[^/][^/]*,,g;s,\(/*\)$,\1,'`
	dir=`$CD "$dir" && ${NETPWD-netpwd} || echo "dir"`$trailer

# 	dir=`echo "$dir" | sed -e s,$trailer$,,`

# 	# Take trailing pathnames out of $dir until it turn into a valid
# 	# directory name, even if it's /.
# 	until ($CD $dir) > /dev/null 2>&1; do
# 	  newdir=`echo "$dir" | sed -e 's,//*[^/][^/]*$,,;s,^$,/,'`
# 	  newdirlenindots=`echo "$newdir" | sed s,.,.,g`
# 	  trailer=`echo "$dir" | sed -e s,$newdirlenindots,,`$trailer
# 	  dir=$newdir
# 	done
# 	dir=`$CD "$dir" && ${NETPWD-netpwd} || echo "$dir"`$trailer
      fi

      arg=-B$dir
      ;;
    esac
    set fnord ${1+"$@"} "$arg"
    prev=$arg
  done
  shift $nargs # take list of fnords out
  shift $nargs # take original args out
  ;;
esac

# In case a remote machine can't be used for builds with gcc because
# its gcc is older, but it can be used as part of the bootstrap, it
# should be in DISTCCREL_HOSTS, and we replace DISTCC_HOSTS with it
# here.  You can also set DISTCCREL_HOSTS to something that includes
# or excludes localhost, which may speed up the computation of
# DISTCC_HOSTS from DISTCCREL_LOCALHOST below.
case $DISTCCREL_HOSTS in
"")
# Since GCC adds the current working directory to the object file's
# debugging info, you have to start distcc on all machines in the same
# directory (say /tmp) and make sure you never use the localhost
# compiler, using the current machine as if it were remote, if at all.
# This problem is actually fixed in GCC 3.4-pre, that adds the
# preprocess-time current directory to the preprocessed output, and
# recognizes it when compiling to format object.
  case " $DISTCC_HOSTS " in
  *" localhost "*)
    : ${DISTCCREL_LOCALHOST=${HOSTNAME-`uname -n`}}
    case $DISTCCREL_LOCALHOST in
    localhost) ;;
    *) DISTCC_HOSTS=`echo " $DISTCC_HOSTS " | sed "s, localhost , $DISTCCREL_LOCALHOST ,"` ;;
    esac
    DISTCCREL_ECHO=DISTCC_HOSTS="'"`echo $DISTCC_HOSTS`"' ${DISTCC-distcc}"
    ;;
  *)
    DISTCCREL_ECHO=${DISTCC-distcc} ;;
  esac ;;
*) DISTCC_HOSTS=$DISTCCREL_HOSTS
   DISTCCREL_ECHO=DISTCC_HOSTS="'"`echo $DISTCC_HOSTS`"' ${DISTCC-distcc}"
   ;;
esac

case $1 in
echo)
  shift
  echo $DISTCCREL_ECHO ${1+"$@"}
  ;;
*)
  exec ${DISTCC-distcc} ${1+"$@"}
  ;;
esac

