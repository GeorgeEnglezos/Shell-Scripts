#!/bin/bash

find $HOME -type f -exec du -h {} + | sort -h -r | head 
# find -type f = βρήσκει τα αρχεία στο Home directory και τα subdirectories του  
#du -h = disk usage in human readable (k,m ,g... )
#sort -h -r = sorts by human numeric sort and in reverse ( Δοκίμασα -nr numeric sort αλλά δεν δούλευε ) 
#head = τα πρώτα 10 αποτελέσματα

