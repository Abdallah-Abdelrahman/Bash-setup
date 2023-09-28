#!/bin/bash

## Aliases
alias vim="nvim"
alias html="here_script | cut -f2"
alias vimx="createx_bash"

## Shell Functions

# create executable file, and open it with vim
# the first argument is the name of the file
createx_bash()
{
	file_name="$1"
	echo -e '#!/bin/bash\n' > $file_name && vim $file_name && chmod u+x $file_name
}

# Git: Queue a change, make a snapshot, and push your changes in one fell swoop
bussyGit()
{
	# commit_msg="COMMIT MESSAGE"
	read -p "Enter commit message (imperative) please -->  " commit_msg
	read -p "Continue? (Y/N): " && [[ "$REPLY" == [yY] || "$REPLY" == [Yy][Ee][Ss] ]]
	if [[ "$REPLY" == [yY] || "$REPLY" == [Yy][Ee][Ss] ]]; then
		git add .
		git commit -m"$commit_msg"
		git push
	else
		echo cancelled!
	fi
}

# Queue up a change, and take a snapshot
commit()
{
	read -p "Enter commit message (imperative) please -->  " commit_msg
	read -p "Continue? (Y/N): "
	if [[ "$REPLY" == [yY] || "$REPLY" == [Yy][Ee][Ss] ]]; then
		git add .
		git commit -m"$commit_msg"
	else
		echo cancelled!
	fi

}

# Look up ALX project
alx()
{
	# read the the repo name, and project
	read -p "Wt't the repo? => " repo
	read -p "Wt's the project? => " project

	ALX_PATH="$HOME/Desktop/ALX-SE"
	PROJECT="*$repo*/*$project*"
	last="`echo -n $project | tail -c 1 | tr '[:lower:]' '[:upper:]'`"
	rest="`echo -n $project | head -c -1`"
	last_cap="$rest$last"
	PROJECT_CAPS="*$repo*/*$last_cap*"
	
	# test the project exist or not, if so change directory
	# `-n` length of string is non-zero
	if [ -n "$(find "$ALX_PATH" -wholename "$PROJECT" -type d)" ]; then
		cd $(echo "$ALX_PATH/$PROJECT")
	elif [ -n "$(find "$ALX_PATH" -wholename "$PROJECT_CAPS" -type d)" ]; then 
		cd $(echo "$ALX_PATH/$PROJECT_CAPS")
	else
		echo "$PROJECT is not exist!" | tr -d '*' >&2
	fi
}

# Remove empty lines
# `read` reads a line from the stdi and split it into fields
rm_emptylines()
{
	# The while loop combined with `reda` is pretty useful,
	# when dealing with single file.
	# `-z` for zero-length strings
	# `-r` to ignore escaping
	# `IFS=` to remove the default delim for `read`
	# `-gt 3` here means don't skip empty lines in the 1st 3 lines.
	count=0
	while IFS= read -r line; do
		[[ -z $line && "$count" -gt 3 ]] && continue
		echo "$line"
		count=$(("$count" + 1));
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
$(tail -n +1 "$2".h | grep $FUNC_NAME | tr -d \;)
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
	gcc $FLAGS $@
}

# Script once I wrote to copy files with certain prototype
cp_proto()
{
	# `grep ' '` to execlude emptyline in the end
	for file in $(tail +4 main.h | grep ' ' | cut -d_ -f2 | cut -d\( -f1); do
		cp `find ../ -name *$file*.c` .
	done
}

## enviroment variables
export FLAGS="-Wall -Werror -pedantic -Wextra -std=gnu89"
