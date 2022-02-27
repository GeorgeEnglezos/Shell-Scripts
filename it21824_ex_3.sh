#!/bin/bash

Total=$(du -sh $Home )        #du -ch | grep total  ή du -s για bytes
Num=$(echo $Total | tr -d -c 0-9)    #Δίχνει μόνο το νούμερο στην μεταβλητή Total
Letter=$(echo $Total | sed 's/[^A-Z?]*//g') #Δίχνει μόνο το γράμμα στην ματαβλητή Total
#Πιστεύω δεν έχει νόημα να κάνω έλεγχο για kb

if [ "$Letter" = "M" ]
    then 
    Percent=$(bc <<<"scale=2;$Num/50") #VAR=$(echo "scale=2;$Num/50") or VAR=$(bc <<<"scale=2;$Num/50")
    Num=$(echo "scale=3;$Num/1000"|bc)
    echo "Using $Percent% of quota (0$Num/5.0 GB)"
elif [ "$Letter" = "G" ]
	then 
    
    Num=$(echo $Num | tr "," .)
    Percent=$(bc <<<"scale=2;$Num/5") 
    Percent=$(echo $Percent | cut -d. -f2 )

    HowMany=$(awk -F '[0-9]' '{print NF-1}' <<< "$Num") #βλέπω πόσα νούμερα υπάρχουν μέσα στην μεταβλητή Num
    if [[ $HowMany = 2 ]] 
        then
        Num1=${Num:0:1} #Σπάω το νούμερο ώστε να βάλω το κόμμα ανάμεσα 
        Num2=${Num:1:2}
        Num=$Num1.$Num2
       
    fi
    

 
    echo "Using $Percent% of quota ($Num/5.0 GB)"
    
fi
#https://stackoverflow.com/questions/12722095/how-do-i-use-floating-point-division-in-bash
https://unix.stackexchange.com/questions/434964/how-do-i-the-extract-the-first-digit-from-a-number-variable-in-a-bash-script
#https://www.unix.com/shell-programming-and-scripting/164835-bash-keep-only-certain-characters.html