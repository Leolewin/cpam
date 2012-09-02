LOG=/tmp/gcc-3.3.2.ec.`date '+%m-%d-%y-%H-%M-%S'`.out
date > ${LOG}
sb -CB /pub/cpamsrc/tww/6.2gcc/dists/6.2/src/gcc-3.3.2/sb-db.xml.ec  >> ${LOG} 2>&1
date >> ${LOG}
