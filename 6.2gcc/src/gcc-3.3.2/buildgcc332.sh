LOG=/tmp/gcc-3.3.2.`date '+%m-%d-%y-%H-%M-%S'`.out
date > ${LOG}
sb /pub/cpamsrc/tww/6.2gcc/dists/6.2/src/gcc-3.3.2/sb-db.xml >> ${LOG} 2>&1
date >> ${LOG}
