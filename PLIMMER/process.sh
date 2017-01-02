#!/bin/bash
#@AIM : Show all process and their children
#@AUTHORS : Benjamin PLIMMER
#@PARAMS : None

#AIM : Show tree from file (parent;enfant;name) 
#PARAMS : [INT] PID 
function CreateTree
{
	while IFS=":" read Enfant Parent Name
	do
		if [ "$Parent" == "$1" ] 
		then
			for (( i=0; i<$CurrentLevel; i++ ))
			do
				echo -e -n "|      "
			done
			echo -e "└------$Enfant($Name)"
			CurrentLevel=$((CurrentLevel+1))
			CreateTree $Enfant
			CurrentLevel=$((CurrentLevel-1))
		fi
	done < /tmp/info
}

File=$(ls /proc/ | grep "[0-9]")

#Save pid, ppid and name in file /tmp/info
#File format pid:ppid:name
for f in $File
do
	Name=$(more /proc/$f/status 2>/dev/null | grep "Name" | awk -F " " {'print $2'}) 
	IdParent=$(more /proc/$f/status 2>/dev/null | grep "PPid" |awk -F " " {'print $2'})
	echo "$f:$IdParent:$Name" >> /tmp/info
done

CurrentLevel=0

CreateTree 0

rm /tmp/info
