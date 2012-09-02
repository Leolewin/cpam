package main
import "os"
import "fmt"
import "log"
import "os/exec"
var cm1,cm1arg1 = "/bin/ls.exe","-l"
var xymonserver = " 192.168.1.8 "
var bb,debug= "/home/xymon/server/bin/bb"," --debug "
// const  board = '"hobbitdboard color=green fields=hostname,testname"'
const  board = "hobbitdboard color=green fields=hostname,testname"
// var cmall_arg =  cm2arg1 + xymonserver + hobbitboard 
func main() {
	buf2 := make([]byte, 1024) // creating a buffer with 1024 bytes in size
        fmt.Println(bb,debug,xymonserver,board)
//	cmd := exec.Command(bb,debug,xymonserver,board)
	cmd := exec.Command(bb,debug,xymonserver)
	buf2,err  := cmd.Output()
        if err != nil {
        fmt.Println(buf2)
	os.Stdout.Write(buf2)
        log.Fatal(err)
        }
	os.Stdout.Write(buf2)
}

//  # !/usr/bin/ksh
//  HBBB="/opt/moto/hobbitserver42/bin/bb --debug"
//  
//  ${HBBB}  127.0.0.1 "hobbitdboard color=purple fields=hostname,testname" |
//  while read L; do
//        HOST=`echo $L | cut -d'|' -f1`
//        TEST=`echo $L | cut -d'|' -f2`
//        ${HBBB} 127.0.0.1 "drop $HOST $TEST"
//  done

