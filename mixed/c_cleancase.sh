#!/bin/bash -l

echo "Remove compilation files? [y/n]"
read -n 1 input
[[ "$input" == "y" || "$input" == "Y" ]] && {
   rm box.nmsh
   rm neko
   rm USER.mod
}

echo "Remove output files? [y/n]"                                                                                               
read -n 1 input
[[ "$input" == "y" || "$input" == "Y" ]] && {
    rm -r output/*
}



