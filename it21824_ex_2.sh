
#!/bin/bash
echo "Enter Your user's name";
read name;#User's name 

echo $name > Howmany
Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν

while (( $Words != 1 )) #Έλεγχος παραμέτρων 
 do
echo "Wrong input you can only insert one word"
read name
echo $name > Howmany
Words=$(wc -w Howmany |tr " " . | cut -d. -f1)
echo $Words
done
rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 

RESULT=$(grep -c '^'$name'' /etc/passwd) #Δίνει το πλήθος των γραμμών με την λέξη στην μεταβλιτή name
if [ "$RESULT" = "1" ];                                                     #Ελέγχει αν το όνομα υπάρχει στο /etc/passwd
then 
echo "The User:$(grep  '^'$name':' /etc/passwd | cut -d: -f1) is local"     # Λέει ότι ο χρήστης είναι τοπικός

echo "User ID info : $(grep  '^'$name':' /etc/passwd | cut -d: -f5)"        #Εκτυπώνει μόνο την πέμπτη στήλη που αποθηκευμένο το user info
else
getent passwd | grep '^'$name'' > /dev/null     # Για να πάρω το exit status ώστε να ελέγξω αν το όνομα βρέθηκε ή όχι στην λίστα των απομακρυσμένων χρηστών 
status=$?
    if [ $status = 0 ] # 0 = Exists 1-255 = Doesnt exist 
    then 
        echo "The User:$(getent passwd |grep '^'$name''| cut -d: -f1) isn't local"  #ομοίος με πάνω 
        echo "User ID info : $(getent passwd |grep '^'$name''| cut -d: -f5)"    #ομοίος με πάνω 

    else 
        echo "User $name doesn't exist" 
    fi
fi 