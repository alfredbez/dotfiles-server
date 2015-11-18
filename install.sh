#!/bin/bash

# some helper functions, credits to Ben "cowboy" Alman
# see https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles#L26-L30
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

function symlink() {
    if [ -h "$2" ]; then
        local target="$(readlink -f ${2})"
        if [ "$1" == "$target" ]; then
            # don't create symlink if it exists and the target is the same
            return 0
        fi
    fi
    if [ -f "$2" ]; then
    e_error "File already exists!"
    local newname="$2.$(date +%s)"
    mv "$2" "$newname" && e_success "renamed to $newname"
    fi
    ln -s "$1" "$2"
}

# VIM stuff
symlink "$HOME/.dotfiles/.vim" "$HOME/.vim"
symlink "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
e_success "created vim symlinks"

symlink "$HOME/.dotfiles-server/.bash_aliases" "$HOME/.bash_aliases"
symlink "$HOME/.dotfiles-server/.gitconfig" "$HOME/.gitconfig"
e_success "symlinked random stuff"
