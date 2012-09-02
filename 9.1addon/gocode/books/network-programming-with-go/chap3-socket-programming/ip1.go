/* IP
 */

package main

import (
	"net"
	"os"
	"fmt"
)


func reportNetwork(name string ) {
	addr := net.ParseIP(name)
        mask := addr.DefaultMask()
	network := addr.Mask(mask)
	fmt.Println("Nework is ",network.String())
}

func Toip16(name string ) {
	addr := net.ParseIP(name)
	fmt.Println("IP16 is ",addr.To16(addr))
}

func reportMask(name string ) {
	addr := net.ParseIP(name)
        mask := addr.DefaultMask()
	fmt.Println("Default mask length is ",mask.String())
}

func verifyIP(name string ) {
	addr := net.ParseIP(name)
	if addr == nil {
		fmt.Println("Invalid address:")
	} else {
		fmt.Println("address is vaild :", addr.String())
	}
}

func main() {
	if len(os.Args) != 2 {
		fmt.Fprintf(os.Stderr, "Usage: %s ip-addr\n", os.Args[0])
		os.Exit(1)
	}
	name := os.Args[1]
        verifyIP(name)
        reportMask(name)
        reportNetwork(name)
        Toip16(name)
	os.Exit(0)
}
