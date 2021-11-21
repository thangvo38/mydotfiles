#! /bin/bash
echo "Copying .vimrc to $HOME"
cp ./.vimrc $HOME

echo "Copying .tmux.conf to $HOME"
cp ./.tmux.conf $HOME

echo "Copying alacritty.yml to $HOME/.alacritty.yml"

if [ "$(uname)" <> "Darwin" ]; then
  echo "Copying sxhkdrc to $HOME/.config/sxhkd"
  sudo cp ./sxhkdrc $HOME/.config/sxhkd
fi

echo "Done"

