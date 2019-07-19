#!/bin/bash
set -eux

HERMIT_HOME=/home/hermit
sudo -i -u hermit bash << EOF
mkdir -p $HERMIT_HOME/.vim/swapfiles
git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git $HERMIT_HOME/.vim/bundle/Vundle.vim
git clone --recursive --depth 1 https://github.com/Shougo/unite.vim.git $HERMIT_HOME/.vim/bundle/unite.vim
git clone --recursive --depth 1 https://github.com/scrooloose/nerdtree.git $HERMIT_HOME/.vim/bundle/nerdtree
git clone --recursive --depth 1 https://github.com/majutsushi/tagbar.git $HERMIT_HOME/.vim/bundle/tagbar
git clone --recursive --depth 1 https://github.com/vim-airline/vim-airline.git $HERMIT_HOME/.vim/bundle/vim-airline
git clone --recursive --depth 1 https://github.com/vim-airline/vim-airline-themes.git $HERMIT_HOME/.vim/bundle/vim-airline-themes
git clone --recursive --depth 1 https://github.com/jnurmine/Zenburn.git $HERMIT_HOME/.vim/bundle/Zenburn
git clone --recursive --depth 1 https://github.com/Yggdroot/indentLine.git $HERMIT_HOME/.vim/bundle/indentLine
git clone --recursive --depth 1 https://github.com/mileszs/ack.vim.git $HERMIT_HOME/.vim/bundle/ack.vim
git clone --recursive --depth 1 https://github.com/tpope/vim-dispatch.git $HERMIT_HOME/.vim/bundle/vim-dispatch
git clone --recursive --depth 1 https://github.com/tpope/vim-fugitive.git $HERMIT_HOME/.vim/bundle/vim-fugitive
git clone --recursive --depth 1 https://github.com/w0rp/ale.git $HERMIT_HOME/.vim/bundle/ale
git clone --recursive --depth 1 https://github.com/davidhalter/jedi-vim.git $HERMIT_HOME/.vim/bundle/jedi-vim
git clone --recursive --depth 1 https://github.com/fatih/vim-go.git $HERMIT_HOME/.vim/bundle/vim-go
git clone --recursive --depth 1 https://github.com/uarun/vim-protobuf.git $HERMIT_HOME/.vim/bundle/vim-protobuf
git clone --recursive --depth 1 https://github.com/leafgarland/typescript-vim.git $HERMIT_HOME/.vim/bundle/typescript-vim
EOF
