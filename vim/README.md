# Vimrc

## Env and usage

#### This vimrc is provide for Golang, C/C++ or JS/Python programmer.

SYSTEM:

- MacOS
- Ubuntu

## Install vim8+ on ubuntu

```
sudo su -

apt-get install -y build-essential python3-dev libclang-dev cmake
apt-get remove --auto-remove vim -y
add-apt-repository ppa:jonathonf/vim -y
apt-get update
apt-get install vim
```

## Coc language server setting

```
brew install llvm
go get golang.org/x/tools/gopls@latest
npm i -g bash-language-server
npm install -g dockerfile-language-server-nodejs
pip3 install python-language-server[all]
```
