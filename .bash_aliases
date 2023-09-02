#!/bin/bash

## Aliases
alias vim="nvim"
alias html="here_script | cut -f2"
alias vimx="createx_bash"

## Shell Functions
#print the date in certain format
today(){
	echo "Today's date is: "$(date +"%A, %B %-d, %Y")  
}

# create executable file, and open it with vim
# the first argument is the name of the file
createx_bash()
{
	file_name="$1"
	echo -e '#!/bin/bash\n' > $file_name && vim $file_name && chmod u+x $file_name  
}

# Git: Queue a change, make a snapshot, and push your changes in one fell swoop
bussyGit() {
	# commit_msg="COMMIT MESSAGE"
	read -p "Enter commit message (imperative) please -->  " commit_msg
	git add .
	git commit -m"$commit_msg" 
	git push
}

# Queue up a change, and take a snapshot
commit()
{
	read -p "Enter commit message (imperative) please -->  " commit_msg
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
		#exit 1
	fi
}

# C file: Create c file with, main function docs
vimc()
{
	FUNC_NAME="`echo "$1" | cut -d- -f2`"

	echo -e "#include \"main.h\"
/**
 * "$FUNC_NAME" - write your short description
 * Description: Long desc
 *
 * Return: 0 as exit status
 */
$(tail -n +1 main.h | grep $FUNC_NAME | tr -d \;) 
{
	return (0);
}" > "$1".c && vim "$1".c
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

## enviroment variables
export FLAGS="-Wall -Werror -pedantic -Wextra -std=gnu89"
