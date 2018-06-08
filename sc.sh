#!/bin/bash

function sc() {
    # help
    if [[ "${1}" = "help" || "$#" -le "1" ]]; then
        echo -e "sc filename[\e[0;106mfind -name xxx\e[0m] greps[\e[0;106mgrep xxx | grep xxx | grep...\e[0m]"
        return
    fi

    # colored grep command
    alias color_grep='\grep -n --color=auto'

    # replace grep command to colored grep command
    GREPS=$(echo ${2} | sed 's/grep/color_grep/g')

    # output
    for FILE in `find . -type f -name "${1}"`; do
        CMD="cat ${FILE} | ${GREPS} | wc -l"

        # grep lines
        LINE=$(eval $CMD)

        if [ "$LINE" -ne "0" ]; then
            echo -e "\e[0;106m ====== Begin of: ${FILE} ====== \e[0m"

            # output filename
            CMD="cat ${FILE} | ${GREPS}"
            eval $CMD

            echo -e "\e[0;102m ====== End of: ${FILE} ====== \e[0m"
            echo -e "\n"
        fi
    done
}