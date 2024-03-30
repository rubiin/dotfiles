#! /bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew update && brew upgrade
brew install kubectl tldr howdoi bat autojump minikube asdf lazydocker tldr speedtest-cli
