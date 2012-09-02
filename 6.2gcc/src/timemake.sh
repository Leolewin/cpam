#!/sbin/sh
# -----------------------------------------------------------------------------
#                     S C R I P T   S P E C I F I C A T I O N
# -----------------------------------------------------------------------------
#
# NAME
#       ccase_inst - Install ClearCase
#
# REVISION HISTORY
#        9 Feb 1997 Lewis Muhlenkamp    Original
#
# USAGE
#       ccase_inst
#
# DESCRIPTION
#       This script must clean up after itself since this script should
#       only be run once, after the initial reboot from the cold install.
#
# RETURN CODE
#       SUCCESS (=0) - script completed sucessfully
#       ERROR   (=1) - error... bad things happened
#       SKIP    (=2) - startup or shutdown was skipped.

# WHAT: Define PATH.
# WHY:  Mainly for security reasons.
# NOTE: This should only be changed if you know what you're doing.
#
PATH=/usr/bin:/usr/sbin:/usr/lbin:/opt/TWWfsw/bin
export PATH

# WHAT: Define exit status flags.
# WHY:  Easier to program with a mnemonic than with the numbers.
# NOTE: THESE DO NOT CHANGE UNLESS NOTIFIED BY HP!  Startup depends on these
#       exit statuses being defined this way.
#
SUCCESS=0
ERROR=1
SKIP=2
export SUCCESS ERROR SKIP

#
# ********************************* MAIN SCRIPT *******************************
#
# ------------------------------- TRAP DECLARATION ----------------------------
#
# ----------------------------- CONSTANT DECLARATION --------------------------
#
CCBASE=/pub/ccase_rls/clearcase_v2.1/sun5
export CCBASE

# ---------------------------- VARIABLE DECLARATION ---------------------------
#
exit_code=${SUCCESS}

#
# ----------------------------------- SCRIPT ----------------------------------
#

# WHAT: Get argument list
# WHY:  So have them for later.
#
myself=$0
OPT="$1"
REP_FLAG="$2"
LOG=/tmp/$myself.log
export LOG




# Find out the time of making all the packages
# on one CPU. 
# redirect the std i/o and error message to a log file.
# Clean up the /opt/build /opt/TWWfsw/*(except pkgutils tools)
# gmake cleanall 

date </dev/null >>${LOG} 2>&1
time gmake allpkgs </dev/null >>${LOG} 2>&1
exit_code=$?


exit ${exit_code}
