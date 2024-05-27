#!/usr/bin/env bash

## Aliases
alias vim="nvim"
alias vimx="createx"
alias mysetup="vim ~/.bash_aliases"
alias w3c="~/Desktop/W3C-Validator/w3c_validator.py"
alias rsql='mysql -uroot -p$ROOT_PSW'
alias rm_pycache='find . -type d -name "__pycache__" -exec rm -rf {} +'
alias git-graph='git log --oneline --decorate --graph --all'

## Shell Functions


# script to make every py file executable
creatx_all()
{
	DIR="$1"
	for f in "$(find $DIR -name "*.py")"; do
		chmod u+x $f
	done
}
# create new alx project initialized w/ readme file
navalx()
{
	REPO="$1"
	PROJECT="$2"
	ALX_PATH="$HOME/Desktop/ALX-SE"

	# test the project exist or not, if so change directory
	# `-n` length of string is non-zero
	if [ -n "$(find "$ALX_PATH" -wholename "$ALX_PATH/*$REPO*" -type d)" ]; then
		cd $(echo "$ALX_PATH/*$REPO*")
	fi

	if [ -n "$PROJECT" ]; then
		mkdir "$PROJECT" && cd "$PROJECT" && vim README.md
	fi
}


# Look up ALX project
alx()
{
	if [[ "$#" > 0 ]]; then
		# navigate to repo
		navalx "$1"
	else
		# read the the repo name, and project

		read -p "Wt's the repo -> " repo NEW_PROJECT
		if [ -n "$NEW_PROJECT" ]; then
			# create new project inside a repo

			navalx "$repo" "$NEW_PROJECT"
		else
			# navigate to specific project inside a repo

			read -p "Wt's the project? -> " project

			ALX_PATH="$HOME/Desktop/ALX-SE"
			PROJECT="*$repo*"
			# This trick capitalizes the last char
			last="`echo -n $project | tail -c 1 | tr '[:lower:]' '[:upper:]'`"
			# This trick `echo`s the string, except the last char
			rest="`echo -n $project | head -c -1`"
			last_cap="$rest$last"
			PROJECT_CAPS="*$repo*/*$last_cap*"

			# test the project exist or not, if so change directory
			# `-n` length of string is non-zero
			if [ -n "$(find "$ALX_PATH" -wholename "$PROJECT/*$project*" -type d)" ]; then
				cd $(echo "$ALX_PATH/$PROJECT/*$project*")
			elif [ -n "$(find "$ALX_PATH" -wholename "$PROJECT_CAPS" -type d)" ]; then 
				cd $(echo "$ALX_PATH/$PROJECT_CAPS")
			else
				echo "$PROJECT is not exist!" | tr -d '*' >&2
			fi
		fi
	fi
}

# Remove empty lines
# `read` reads a line from the stdi and split it into fields
rm_emptylines()
{
	# The while loop combined with `read` is pretty useful,
	# when dealing with single file.
	# `-z` for zero-length strings
	# `-r` to ignore escaping
	# `IFS=` to remove the default delim for `read`
	# `-gt 3` here means don't skip empty lines in the 1st 3 lines.
	count=0
	while IFS= read -r line; do
		[[ -z $line && "$count" -gt 3 ]] && continue
		echo "$line"
		((count++));
	done

	# or - more elegant, but it has ambigious behavior,
	# when the line starts with special characters.
	# cat $1 | grep ' '
}

# Generate header file boiler-plate
header()
{
	# `<<-` the hyphen means remove the leading tabs.
	cat > "$1".h <<- _EOF_
	#ifndef HEADER
	#define HEADER
	/* your protos and preprocessors goes here*/
	#endif /* HEADER */
_EOF_
}

# Open header boiler-plate with vim
vimh()
{
	header "$1" && vim "$1".h
}

# Default to main prototype
default()
{
	# use of `[[` here to eliminate the error binary expected,
	# So basically, the double brakets is much safer
	if [[ ! $(tail -n +1 "$2".h | grep "$1") ]]; then
		echo "int main(int ac, char **av)"
	fi
}

# Boiler-plate for c file based on main.h
# `<< _EOF_` is called here script or document,
# useful when formatting large text.
proto()
{
	FUNC_NAME="`echo "$1" | cut -d- -f2`"
	rm_emptylines << _EOF_ 
#include "$2.h"

/**
 * $FUNC_NAME - write your short description
 * Description: Long desc
 *
 * Return: 0 as exit status
 */
$(default "$FUNC_NAME" "$2")
$(grep $FUNC_NAME "$2".h | tr -d \;)
{
	return (0);
}
_EOF_
}

# Create c file based on the boiler-plate
vimc()
{
	file="$1"
	header="main"

	if [[ "$#" < 1 ]]; then
		read -p "wt's ur c file honey? (w/out extension): -> " file
	fi

	if [[ "$#" == 2 ]]; then
		header="$2"
	fi
	
	proto "$file" "$header" > "$file".c && vim "$file".c
}

# Compile c file with flags
# `$@` expands to varaible of arguments
gcf()
{
	# Don't quote enviroment varaible `FLAGS` it won't work.
	gcc -g $FLAGS "$@" 
}

# run valgrind with flags
valgf()
{
	valgrind --leak-check=full --show-leak-kinds=all $@
}

# simple script to replace variable
# in a project tree with a replacement
replace()
{
	local var="$1"
	local dir="$2"
	local replacement="$3"
	grep "$var" "$dir" -d recurse | awk -F: '{print $1}' | sort -u | xargs -I {} sed -i "s/"$var"/"$replacement"/g" {}
}

# fix git username and password
# git remote set-url origin https://name:password@github.com/repo.git

# -------- source executables --------
source ~/bin/goto

## enviroment variables
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\e[0;35m$(__git_ps1 " (%s)")\033[0m\$ '
export FLAGS="-Wall -Werror -pedantic -Wextra -std=gnu89"
export RESET='\e[0m' # No Color
export COLOR_BLACK='\e[0;30m'
export COLOR_GRAY='\e[1;30m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_WHITE='\e[1;37m'
export ROOT_PSW='fOola_1995'
export HBNB_ENV='dev'
export HBNB_MYSQL_USER='hbnb_dev'
export HBNB_MYSQL_PWD='hbnb_dev_pwd'
export HBNB_MYSQL_HOST='localhost'
export HBNB_MYSQL_DB='hbnb_dev_db'
export HBNB_TYPE_STORAGE='db'
export WEB_01='52.91.118.253'
export WEB_02='35.153.16.72'
export GOOGLE_API_KEY='AIzaSyCZ65KtrvdNeYBIbii408b_eWg6sMZ9PcQ'
export GA_API_KEY='AIzaSyDrSr4FKbjIrgVFXqpHfUR6zwAjGTuvugs'
STC_PSW='fola1995'
STC_USR='root'
WIFI_USR_5G='13375'
WIFI_PSW_5G='N01n73rn37'
WIFI_USR_4G='13374'
WIFI_PSW_4G='N01n73rn374'
# export NODE_PATH='/usr/lib/node_modules'
