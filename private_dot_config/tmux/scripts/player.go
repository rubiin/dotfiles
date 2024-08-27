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

	songName := string(response)

	songName = strings.Trim(songName, " ") // trim spaces around
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

	status := string(response)

	status = strings.Trim(status, " ") // trim spaces around

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

	songName := strings.TrimSpace(<-songNameCh)

	songStatus := strings.Trim(<-songStatusCh, "\n")
	songStatus = strings.TrimSpace(songStatus)

	icon, exists := statusMap[songStatus]

	if exists {

		fmt.Printf("%s %s", icon, songName)
	} else {
		fmt.Printf("%s : %s", songStatus, songName)
	}

}
