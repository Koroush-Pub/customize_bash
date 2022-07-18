#!/bin/bash

function welcome() {
	echo
	echo "welcome to first system setup."
	echo
}

function main_selection() {
PS3="choose >>"
select option in "Local Custom Prompt" "System Custom Prompt" "Test" "Cowsay Fortune Startup" "Exit";
do
        if [ "$option" == "Exit" ];
        then
                exit 0
        else
                opt=${option:0:3}
                $opt
        fi
done
}

function Loc() {

#local custom prompt
read -p "do you want your custom prompt added local to bashrc? (y/n): " lprompt

if [ "${lprompt:0:1}" == y ];
then
	echo "#custom prompt :" >> "$HOME/.bashrc"
	echo 'export PS1="\[\e[31m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[31m\]\W\[\e[m\]\[\e[32m\]\\$\[\e[m\] "' >> "$HOME/.bashrc"
	echo 'custom prompt added Succesfully'
	echo
	main_selection
else
	echo "$lprompt is unknown input!"
	echo
	main_selection
fi
}

function Sys() {

#system custom prompt
addr=/etc/bash.bashrc
echo "do you want all users have custom prompt (y/n): "
echo "you must have permission to do this."
read -p "note your default bash address is $addr. " aprompt

if [ "${aprompt:0:1}" == y ];
then
	echo "#custom prompt :" >> $addr
	echo 'export PS1="\[\e[31m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[31m\]\W\[\e[m\]\[\e[32m\]\\$\[\e[m\] "' >> $addr

        if [ $? -eq 1 ];
				then
					echo "unsuccessful operation!(run this script with sudo or higher permitions!)"
					echo
					main_selection
				else
					echo "custom prompt added Succesfully"
					echo
					main_selection
				fi

else
	:
fi
}

function Tes() {
echo "this is a test function"
echo
main_selection
}

function Cow() {
addr="$HOME/.bashrc"
select option in "install" "set" "unset" "back";
do
	case "$option" in
		"back")echo
					 main_selection
		       break;;
		"install")sudo apt-get install cowsay fortune -y
							if [ $? -eq 0 ];
							then
										echo
										echo "Succesfull Installation"
										echo
							else
										echo
										echo "Unsuccesfull Installation"
										echo
										continue
							fi;;
		"set")echo "#cowsay fortune addone: " >> "$addr"
		      echo "fortune | cowsay" >> "$addr"
		      if [ $? -eq 0 ];
		      then
		      echo "successful operation!"
		      else
		      echo "unsuccessful operation!"
				fi;;
		"unset")sed -i '/#cowsay fortune addone:/d' "$addr"
						sed -i '/fortune | cowsay/d' "$addr"
						echo "Operation Succesfull"
						;;
	esac
done
}

welcome
main_selection
