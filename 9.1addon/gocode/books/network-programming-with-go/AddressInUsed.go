package main

import (
	"fmt"
	"net"
)

func main() {
	addr := ":8053"
	at, _ := net.ResolveTCPAddr("tcp6", addr)
	_, e := net.ListenTCP("tcp6", at)
	if e != nil {
		fmt.Printf("%s\n", e.Error())
	}
	au, _ := net.ResolveTCPAddr("tcp4", addr)
	_, e = net.ListenTCP("tcp4", au)
	if e != nil {
		fmt.Printf("%s\n", e.Error())
	}
}
