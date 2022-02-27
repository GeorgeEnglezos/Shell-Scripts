#!/bin/bash

############### INSERT TASK ###################
InsertTask() { 
                
echo "Insert a task:"
read TaskName
echo "Would you like to give a future date ? (yes or no )"
read answer
echo $answer > Howmany
Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν

while (( $Words != 1 )) || [[ "$answer" != "yes"  &&  "$answer" != "no" ]] #Έλεγχος παραμέτρων 
 do

read -p 'Wrong input try again :' answer
echo $answer > Howmany
Words=$(wc -w Howmany |tr " " . | cut -d. -f1)

done
rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 

case $answer in
  "yes")
    echo "The finale Format will be DDMMYYYYHHMM"
    
    read -p 'Day: (Use numbers 1-31)' Day    ##### For the day #########################################################################
    echo $Day > Howmany
    Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν

    while [ $Day -gt 31 ] || [ $Day -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers from 1-31"
       read -p 'Try again: ' Day
       echo $Day > Howmany
       Words=$(wc -w Howmany |tr " " . | cut -d. -f1)
       
    done
    if [ $Day -lt 10 ]
    then 
    Day=0$Day
    fi
    rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 
    
    read -p 'Month: (Use numbers 1-12)' Month    ######For the month #################################################################################

    echo $Month > Howmany
    Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν

    while [ $Month -gt 12 ] || [ $Month -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers from 1-12"
       read -p 'Try again: ' Month
       echo $Month > Howmany
       Words=$(wc -w Howmany |tr " " . | cut -d. -f1)
       
    done
     if [ $Month -lt 10 ]
    then 
    Month=0$Month
    fi
    rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 
    
    read -p 'Year: ' Year      ######## For the year ###################################################################################

    echo $Year > Howmany
    Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν

    while [ $Year -gt 9999 ] || [ $Year -lt 2019 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers 2019-9999"
       read -p 'Try again: ' Year 
       echo $Year > Howmany
       Words=$(wc -w Howmany |tr " " . | cut -d. -f1)
       
    done
    
    rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 
    
    read -p 'Hour: (Use 1-24)' Hour #######for the hour ###############################################################################################

        echo $Hour > Howmany
    Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν

    while [ $Hour -gt 24 ] || [ $Hour -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers 1-24"
       read -p 'Try again: ' Hour 
       echo $Hour > Howmany
       Words=$(wc -w Howmany |tr " " . | cut -d. -f1)
       
    done
     if [ $Hour -lt 10 ]
    then 
    Hour=0$Hour
    fi
    rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 
    
    
    read -p 'Min: (Use 1-60)' Min      ######For the minutes ###########################################################################

            echo $Min > Howmany
    Words=$(wc -w Howmany |tr " " . | cut -d. -f1) #Πόσες λέξεις δόθηκαν

    while [ $Min -gt 60 ] || [ $Min -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers 1-60"
       read -p 'Try again: ' Min 
       echo $Min > Howmany
       Words=$(wc -w Howmany |tr " " . | cut -d. -f1)
       
    done
     if [ $Min -lt 10 ]
    then 
    Min=0$Min
    fi
    rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 

    Date=$(echo $Day$Month$Year$Hour$Min)
    HiddenDate=$(echo $Year$Month$Day$Hour$Min)
    ;;
  "no")
    Date=$(date +%d%m%Y%H%M) #Μεταβλητή που κρατάει την ημερομηνία σε φορμάτ ΗΗΜΜΕΕΕΕΩΩΛΛ
    HiddenDate=$(date +%Y%m%d%H%M) #Μεταβλητή που θα χρειαστεί στο preview tasks 
    ;;
esac



                          #https://www.lifewire.com/display-date-time-using-linux-command-line-4032698
echo "$HiddenDate:$Date:$TaskName"  >> todo.list #anakateuthinsh eisodou sto arxeio todo.list (krataei ta prohgoumena)
}

############### DELETE TASK ###################
DeleteTask() {

FILE=todo.list # Έλεγχος για το αν υπάρχει το αρχείο
if [ ! -f "$FILE" ]; then
    
    echo "You can't run options 2-6 if you don't have any tasks "
    exit 1
fi

#https://linuxize.com/post/bash-check-if-file-exists/

cat todo.list | cut -d: -f2,3
echo "Give the date or a 'key word' of the task you want to be deleted :"
read WantDeleted
sed -i "/$WantDeleted/"d ./todo.list
}

############## MODIFY TASK ####################

ModifyTask() {


FILE=todo.list
if [ ! -f "$FILE" ]; then
    
    echo "You can't run options 2-6 if you don't have any tasks "
    exit 1
fi



cat todo.list | cut -d: -f2,3
echo "give the date of the task you want to modify"
read WantModified
DateModify=$(grep $WantModified todo.list | cut -d: -f2)
HiddenDate=$(grep $WantModified todo.list | cut -d: -f1)
TaskModify=$(grep $WantModified todo.list | cut -d: -f3)



echo "Would you like to edit the Date , Task or Both ?"
read change
echo $change > Howmany
Words=$(wc -w Howmany |tr " " . | cut -d. -f1)

while (( $Words != 1 )) || [[ "$change" != "Date"  &&  "$change" != "Task" && "$change" != "Both" ]] #Έλεγχος παραμέτρων 
 do

read -p 'Wrong input try again :' change
echo $change > Howmany
Words=$(wc -w Howmany |tr " " . | cut -d. -f1)

done
rm Howmany #Σβήνω το αρχείο που φτιάχτηκε για την wc 

case $change in
  "Date") # Είναι ο ίδιος κώδικας με ρην Insert task απλά κρατάω το προηγούμενο task και διαγράφο την προηγούμενη μορφή του .
    
    read -p 'Day: (1-31)' Day    ##### For the day #########################################################################
    while [ $Day -gt 31 ] || [ $Day -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers 1-31"
       read -p 'Try again: ' Day

    done
    if [ $Day -lt 10 ]
    then 
    Day=0$Day
    fi

    
    read -p 'Month: (1-12)' Month    ######For the month #################################################################################

    while [ $Month -gt 12 ] || [ $Month -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers from 1-12"
       read -p 'Try again: ' Month

       
    done
     if [ $Month -lt 10 ]
    then 
    Month=0$Month
    fi

    
    read -p 'Year: ' Year      ######## For the year ###################################################################################

    while [ $Year -gt 9999 ] || [ $Year -lt 2019 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers from 2019 to 9999"
       read -p 'Try again: ' Year 

    done
    
    read -p 'Hour: ' Hour #######for the hour ###############################################################################################

    while [ $Hour -gt 24 ] || [ $Hour -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers 1-24"
       read -p 'Try again: ' Hour 

       
    done
     if [ $Hour -lt 10 ]
    then 
    Hour=0$Hour
    fi

    
    read -p 'Min: ' Min      ######For the minutes ###########################################################################

    while [ $Min -gt 60 ] || [ $Min -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers 1-60"
       read -p 'Try again: ' Min 
    done
     if [ $Min -lt 10 ]
    then 
    Min=0$Min
    fi


    DateModify=$Day$Month$Year$Hour$Min
    HiddenDate=$Year$Month$Day$Hour$Min
    
    sed -i "/$WantModified/"d ./todo.list
       echo "$HiddenDate:$DateModify:$TaskModify" >> todo.list
      ;;
  "Task")
  echo "insert new Task"
      read TaskModify
      sed -i "/$WantModified/"d ./todo.list
       echo "$HiddenDate:$DateModify:$TaskModify" >> todo.list
    ;;
  "Both")
      InsertTask #Αφού θέλω να αλλάξω και τα δύο απλά καλώ την Insert Task και φτιάχνω καινούργιο task
      sed -i "/$WantModified/"d ./todo.list
    ;;
esac


}

############### Search Task ###############

SearchTask() {


FILE=todo.list
if [ ! -f "$FILE" ]; then
    
    echo "You can't run options 2-6 if you don't have any tasks "
    exit 1
fi



echo "Give the Task or the Date to view the Task"
read answer
grep $answer todo.list | cut -d: -f2,3
}

############## Preview Task ##############

PreviewTasks() {


FILE=todo.list
if [ ! -f "$FILE" ]; then
    
    echo "You can't run options 2-6 if you don't have any tasks "
    exit 1
fi



sort todo.list > todosorted  
cat todosorted | cut -d: -f2,3
rm todosorted
}

########## Preview Daily Tasks ###########

PreviewDailyTasks() {


FILE=todo.list      
if [ ! -f "$FILE" ]; then
    
    echo "You can't run options 2-6 if you don't have any tasks "
    exit 1
fi



  cat todo.list | cut -d: -f2,3 > TCTD
read -p 'Give the Day: (1-31)  ' Day

    while [ $Day -gt 31 ] || [ $Day -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers from 1-31"
       read -p 'Try again: ' Day

       
    done
     if [ $Day -lt 10 ]
    then 
    Day=0$Day
    fi

  read -p 'Month: (1-12)' Month    ######For the month #################################################################################

    while [ $Month -gt 12 ] || [ $Month -lt 1 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert numbers from 1-12"
       read -p 'Try again: ' Month

       
    done
     if [ $Month -lt 10 ]
    then 
    Month=0$Month
    fi


    read -p 'Give the Year: ' Year

        

    while [ $Year -gt 9999 ] || [ $Year -lt 2019 ] #Έλεγχος παραμέτρων 
    do
        echo "Wrong input, you can only insert years 2019-9999"
       read -p 'Try again: ' Year

       
    done
  
    SeeDate=$Day$Month$Year
    egrep "$SeeDate[0-9]{4}" TCTD #
    rm TCTD
}

################# EXIT ###################

Quit() {
echo "Program closed Succesfully "
exit 1
}


#############################################
############################################
############  MAIN  #######################
i=1
while [ $i = 1 ]  #Για να γίνεται συνέχεια μέχρι ο χρήστης να πατήσει 7 
do
echo "1) insert "
echo "2) delete "
echo "3) edit  "
echo "4) search  "  
echo "5) preview" 
echo "6) daily"
echo "7) quit"
echo "What do you want to do?"
read answer ;

 case  "$answer"  in      # Case που καλούναι τις συναρτήσεις 
                1)           		    
                InsertTask
                  ;;
                2)
     		        DeleteTask 
                   ;;                 
                3)       
     		        ModifyTask
                 ;;
                4)       
     		        SearchTask 
                 ;;
                5)       
     		        PreviewTasks 
                 ;;
                6)       
     		        PreviewDailyTasks 
                 ;;
                7)
                Quit
                ;;
                *) echo "Invalid option"   # for wrong input
                ;;   
          esac 

done