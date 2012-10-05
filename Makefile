all: link

link: .vim .vimrc
	ln -s `pwd`/.vimrc ~/.vimrc
	ln -s `pwd`/.vim/ ~/.vim
