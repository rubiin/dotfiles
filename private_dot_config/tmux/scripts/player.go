package main

import (
	"fmt"
	"os/exec"
	"strings"
	"sync"
)

func GetSongName(ch chan string, wg *sync.WaitGroup) {
	cmd := exec.Command("playerctl", "metadata", "--format", "{{ artist }} - {{ title }}")
	response, err := cmd.Output()
	if err != nil {
		panic(err)
	}

	songName := strings.TrimSpace(string(response)) // trim spaces around
	songName = songName[0:30]

	ch <- songName
	wg.Done()
}

func GetPlayerStatus(ch chan string, wg *sync.WaitGroup) {
	cmd := exec.Command("playerctl", "status")
	response, err := cmd.Output()
	if err != nil {
		panic(err)
	}

	status := strings.TrimSpace(string(response)) // trim spaces around
	status = strings.Trim(status, "\n")
	ch <- status
	wg.Done()
}

func main() {

	statusMap := make(map[string]string)

	statusMap["Playing"] = ""
	statusMap["Paused"] = ""

	songStatusCh := make(chan string, 1)
	songNameCh := make(chan string, 1)

	wg := sync.WaitGroup{}

	wg.Add(2)

	go GetPlayerStatus(songStatusCh, &wg)
	go GetSongName(songNameCh, &wg)

	wg.Wait()
	close(songNameCh)
	close(songStatusCh)

	songName := <-songNameCh

	songStatus := <-songStatusCh

	icon, exists := statusMap[songStatus]

	if exists {

		fmt.Printf("%s %s", icon, songName)
	} else {
		fmt.Printf("%s : %s", songStatus, songName)
	}

}
