#! /bin/sh

# Download fonts

if [ -d "monolisa-nerdfont-patch" ]; then
  # Take action if $DIR exists. #
  rm -rf monolisa-nerdfont-patch
fi
git clone https://github.com/daylinmorgan/monolisa-nerdfont-patch
cd monolisa-nerdfont-patch/MonoLisa && mkdir ttf && cd ttf
ghget https://github.com/d8-bbc11/monolisa/blob/main/fonts/MonoLisa-italic.ttf && ghget https://github.com/d8-bbc11/monolisa/blob/main/fonts/MonoLisa-normal.ttf
cd ~/monolisa-nerdfont-patch
make
cp patched/ttf/*.ttf ~/.local/share/fonts
fc-cache -vf
