#! /bin/bash
echo "Updating vimrc from machine"
cp ~/.vimrc ./vimrc

echo "Updating tmux conf from machine"
cp ~/.tmux.conf ./tmux.conf

echo "Updating alacritty from machine"
cp ~/.config/alacritty.yml .

if [ "$(uname)" = "Linux" ]; then
  echo "Updating sxhkdrc"
  sudo cp $HOME/.config/sxhkd ./sxhkdrc
fi

git add vimrc tmux.conf alacritty.yml
git commit -m "Update configs file"
git push origin main

