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
	git add .
	git commit -m"$commit_msg" 
	git push
}

# Queue up a change, and take a snapshot
commit()
{
	read -p "Enter commit message (imperative) please -->  " commit_msg
	read -p "Continue? (Y/N): " && [[ "$REPLY" == [yY] || "$REPLY" == [Yy][Ee][Ss] ]]
	git add .
	git commit -m"$commit_msg" 
}

# Look up ALX project
alx()
{
	# read the the repo name, and project
	read -p "Wt't the repo? => " repo
	read -p "Wt's the project? => " project

	ALX_PATH="$HOME/Desktop/ALX-SE"
	PROJECT="*$repo*/*$project*"
	
	# test the project exist or not
	# `-n` length of string is non-zero
	if [ -n "$(find "$ALX_PATH" -wholename "$PROJECT" -type d)" ]; then
		cd $(echo "$ALX_PATH/$PROJECT")
	else
		echo "$PROJECT is not exist!" | tr -d '*' >&2
	fi
}

# Remove empty lines
# `read` reads a line from the stdi and split it into fields
rm_emptylines()
{
	for line in `tail +1 | tr -d ' '`; do
		echo $line
	done

	# The while loop combined with `reda` is pretty useful,
	# but The file need to be,
	# existed before the expansion.
	# "$1" is the file
	# `-z` for zero-length strings
	# `-r` to ignore escaping
#	while read -r line; do
#		[[ -z $line ]] && continue
#		echo $line
#	done < "$1"

	# or - more elegant, but it has ambigious behavior,
	# when the line starts with special characters.
	# cat $1 | grep ' '
}

# Default to main prototype
default()
{
	# use of `[[` here to eliminate the error binary expected,
	# So basically, the double brakets is much safer
	if [[ ! $(tail -n +1 main.h | grep "$1") ]]; then
		echo "int main(int ac, char **av)"
	fi
}

# Boiler-plate for c file based on main.h
proto()
{
	FUNC_NAME="`echo "$1" | cut -d- -f2`"
	echo -e "#include \"main.h\"

/**
 * "$FUNC_NAME" - write your short description
 * Description: Long desc
 *
 * Return: 0 as exit status
 */
`default "$FUNC_NAME"`
$(tail -n +1 main.h | grep $FUNC_NAME | tr -d \;)
{
	return (0);
}"
}

# Create c file based on the boiler-plate
vimc()
{
	# `-s` sqweeze new lines
	proto "$1" | tr -s '\n' > "$1".c && vim "$1".c
}

# here script first try
here_script()
{
	cat << _EOF_
	<html>
	        <head>
                        <title>Here Script</title>
	        </head>
	</html>
_EOF_
}

# Compile c file with flags
gcf()
{
	gcc $FLAGS $@
}

# Script once I wrote to copy files with certain prototype
cp_proto()
{
	# gre ' ' to execlude emptyline in the end
	for file in $(tail +4 main.h | grep ' ' | cut -d_ -f2 | cut -d\( -f1); do
		cp `find ../ -name *$file*.c` . 
	done
}

## enviroment variables
export FLAGS="-Wall -Werror -pedantic -Wextra -std=gnu89"
