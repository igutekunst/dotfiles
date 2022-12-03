SHELL := /bin/bash

LOCAL:= ~/local
RC:=$(HOME)/.bashrc.d/

all: link \
	~/local \
	~/.bashrc.d

~/.vimrc:
	ln -s `pwd`/.vimrc ~/.vimrc
~/.vim:
	ln -s `pwd`/.vim/ ~/.vim

link: ~/.vim ~/.vimrc


.PHONY: history link

venv:
	python3 -m venv venv

ansible: venv
	source venv/bin/activate &&  pip install ansible keyring


~/local:
	mkdir ~/local
	mkdir ~/local/bin
	mkdir ~/local/src

~/.bashrc.d:
	mkdir ~/.bashrc.d

# howdoi
