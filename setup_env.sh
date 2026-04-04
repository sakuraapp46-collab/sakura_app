!/bin/bash
set -e

echo 'Installing dependencies...'
sudo apt-get update
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev     

echo 'Downloading Flutter...'
mkdir -p ~/development
cd ~/development
if [ ! -d 'flutter' ]; then
  git clone https://github.com/flutter/flutter.git -b stable
else
  echo 'Flutter already exists.'
fi

echo 'Configuring Path...'
export PATH=\"\$PATH:\$HOME/development/flutter/bin\"
if ! grep -q 'flutter/bin' ~/.bashrc; then
  echo 'export PATH=\"\$PATH:\$HOME/development/flutter/bin\"' >> ~/.bashrc
 fi

echo 'Running Flutter Doctor...'
~/development/flutter/bin/flutter doctor

echo 'Setup Complete! Please restart your terminal or source ~/.bashrc'
