#! /bin/bash
echo "Copying .vimrc to $HOME"
cp ./vimrc $HOME/.vimrc

echo "Copying .tmux.conf to $HOME"
cp ./tmux.conf $HOME/.tmux.conf

echo "Copying alacritty.yml to $HOME/.alacritty.yml"
cp ./alacritty.yml $HOME/.allacritty.yml

if [ "$(uname)" <> "Darwin" ]; then
  echo "Copying sxhkdrc to $HOME/.config/sxhkd"
  sudo cp ./sxhkdrc $HOME/.config/sxhkd
fi

echo "Done"

