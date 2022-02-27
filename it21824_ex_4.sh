#!/bin/bash
if ! hash write 2>/dev/null #https://scripter.co/check-if-a-command-exists-from-shell-script/
then
    echo "Write isn't installed in this PC"
    else
    echo "Write is installed"
    read -p 'Username: ' name
    
    echo $name > Howmany
    Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν
    while (( $Words != 1 )) #Έλεγχος παραμέτρων 
     do
        echo "Wrong input, you can only insert one word"
        read -p 'try again: ' name
        echo $name > Howmany
        Words=$(wc -w Howmany |tr " " . | cut -d. -f1)
        
    done
    rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 

fi

#Έλεγχος για το αν ο χρήστης υπάρχει
RESULT=$(grep -c '^'$name'' /etc/passwd) #Δίνει RESULT 1 αν ο χρήστης υπάρχει και 0 αν δεν υπάρχει
if [ "$RESULT" = "1" ];                                                     #Ελέγχει αν ο χρήστης υπάρχει ως τοπικός χρήστης . 
then
echo "The User:$(grep  '^'$name':' /etc/passwd | cut -d: -f1) exists"     
Exists=True
else
getent passwd | grep '^'$name'' > /dev/null # Για να πάρω το exit status και να δω αν υπάρχει ο χρήστης 
status=$?
    if [ $status = 0 ] # 0 = Exists 1-255 = Doesnt exist
    then
        echo "The User:$(getent passwd |grep '^'$name''| cut -d: -f1) exists"  #Εκτυπώνει ότι ο χρήστης υπάρχει (αππομακρισμένος)
        Exists=True

    else
        echo "User $name doesn't exist"
        Exists=False
    fi
fi

#Αν ο χρήστης υπάρχει ελέγχει αν είναι συνδεδεμένος
if [ $Exists = True ]
then
    RESULT=$(who | grep -c '^'$name'') #Ομοίος με πάνω 
    if [[ $RESULT > 0 ]];              #ελέγχω με την εντολή who ποιος είναι συνδεδεμένος 
        then
        echo "The User: $name is online "     #Αν είναι online 
        echo -n "Give message :"
        write $name > /dev/null
        message=$?
        
        if [ $message = 0 ];
        then
            echo "message sent!"
        else 
            echo "couldn't reach the user!"
        fi
    else                                    #Αν δεν είναι online 
        echo "The User isn't available right now"
    fi
fi
