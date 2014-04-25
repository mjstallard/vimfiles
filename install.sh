#!/bin/sh

# This installation is destructive, as it removes exisitng files/directories.
# Use at your own risk.

# install vundle
echo "Installing vundle..."
  if [ -d "vim/bundle/vundle" ]; then
    cd "vim/bundle/vundle"
    git pull
    cd "../../.."
  else
    git clone http://github.com/gmarik/vundle.git vim/bundle/vundle
  fi
echo "Done installing vundle."

# Symlink all of the files in the repo to your home directory.
for name in *; do
  if [ ! $name == "README.md" -a ! $name == "LICENSE" -a ! $name == "install.sh" ]; then
    target="$HOME/.$name"

    if [ -h $target ]; then
      rm $target
      echo "Deleted $target"
    elif [ -d $target ]; then
      rm -rf $target
      echo "Deleted $target"
    fi

    ln -sf "$PWD/$name" "$target"
    echo "Linked $PWD/$name to $target."
  fi
done

vim -c BundleInstall! -c BundleClean! -c q -c q

echo
echo "Installed successfully."
echo
