DOTFILES ?= $(shell pwd)
HOSTNAME ?= $(shell hostname)

all: shell code perl web mail

shell:
	ln -fs $(DOTFILES)/zsh/zshrc        ${HOME}/.zshrc
	ln -fns $(DOTFILES)/zsh/zsh.d       ${HOME}/.zsh.d
	ln -fs $(DOTFILES)/gnupg            ${HOME}/.gnupg
	ln -fs $(DOTFILES)/ssh/config       ${HOME}/.ssh/config

    ifeq ($(HOSTNAME),orion)
	    ln -fs $(DOTFILES)/screen/screenrc_orion ${HOME}/.screenrc
    else
	    ln -fs $(DOTFILES)/screen/screenrc  ${HOME}/.screenrc
    endif

code:
	ln -fs $(DOTFILES)/gitconfig        ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/vimrc            ${HOME}/.vimrc
	ln -fns $(DOTFILES)/vim             ${HOME}/.vim
	ln -fs $(DOTFILES)/.tm_properties  ${HOME}/.tm_properties

perl:
	ln -fs $(DOTFILES)/perltidyrc       ${HOME}/.perltidyrc
	ln -fs $(DOTFILES)/perlcritic       ${HOME}/.perlcriticrc

web:
	ln -fs $(DOTFILES)/vimperatorrc   ${HOME}/.vimperatorrc

mail:
	ln -fs $(DOTFILES)/muttrc           ${HOME}/.muttrc
