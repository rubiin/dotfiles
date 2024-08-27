package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	cmd := exec.Command("playerctl","metadata", "--format", "{{ artist }} - {{ title }}")
	response,err := cmd.Output()
	if(err != nil){
		panic(err)
	}

	songName := string(response)

	songName = strings.Trim(songName," ") // trim spaces around
	songName = songName[0:30]

	fmt.Println(songName)
}
