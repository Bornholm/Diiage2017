#!/bin/bash
#@AIM: Show all process and their children
#@AUTHORS: Benjamin PLIMMER
#@PARAMS:


if command -v pstreee >/dev/null
then
        pstree -p
else
        echo "I require pstree but it's not installed."
        echo "Type y to install"
        read answer

        if echo "$answer" | grep -iq "^y"
        then
                apt-get install psmisc >/dev/null
                pstree -p
        else
                ps -faux |less
        fi
fi
