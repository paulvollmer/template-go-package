package main

import (
	"flag"
	"fmt"
)

var (
	version string
	commit  string
)

func main() {
	flagName := flag.String("n", "world", "flag placeholder")
	flag.Parse()

	fmt.Printf("Version %s (%s)\n", version, commit)
	fmt.Printf("hello %q\n", *flagName)
}
