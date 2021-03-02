alias vim ='nvim'
alias myzsh='source ~/.zshrc'
alias fixvlc='mkdir ~/.cache/vlc'
alias vmc='git diff --name-only --diff-filter=U'
alias updatef='sudo apt-fast update -y;sudo apt-fast upgrade -y;brew update && brew upgrade;'
alias kb="kubectl"


nest_generate_all(){
  nest g mo $1
  nest g co $1
  nest g s $1
}

ffmpeg_convert(){
  for i in *.{avi,flv,m4v,mov,wmv,mp4,MP4,TS,mkv};
  do ffmpeg -n -loglevel error -i "$i" -vcodec libx264 -crf 28 -preset faster -tune film "cc${i}"; 
  done
}

zsh_fix_history(){
cd ~
mv .zsh_history .zsh_history_old
strings .zsh_history_old > .zsh_history
fc -R .zsh_history
}
yarn_audit_fix(){
  npm i --package-lock-only && rm yarn.lock && npm audit fix && yarn import && rm package-lock.json
}

# tmux 
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"
alias tmux_end="pkill -f tmux";

## npm aliases
alias ni="npm install";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrf="npm run format -s --";
alias nrd="npm run start:dev -s --";
alias nrt="npm run test -s --";
alias nrtw="npm run test:watch -s --";
alias nrv="npm run validate -s --";
alias rmn="rm -rf node_modules";
alias flush-npm="rm -rf node_modules && npm i && say NPM is done";
alias nicache="npm install --prefer-offline";
alias nioff="npm install --offline";
alias nrm="npm run typeorm:run"

## yarn aliases
alias yi="yarn install";
alias ya="yarn add";
alias yr="yarn remove";
alias yau="yarn audit";
alias yrs="yarn run start";
alias yrd="yarn run start:dev";
alias yup="yarn upgrade";


## docker

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

## fzf aliases
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
