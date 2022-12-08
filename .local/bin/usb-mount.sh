#!/bin/sh

drives=$(lsblk -nrpo 'name,type,size,mountpoint,label' | grep -v 'disk' | sed 's/ $//' | grep -vEe '(\/boot\/efi)|(\[SWAP\])|(\/home)|(\/)$')

if [ -z "$1" ]; then
   echo "$drives"
else
   selected_drive=$(echo "drives" | grep "$1" | cut -d' ' -f1)
   
   # Test if mounted
   if [ -z $(echo "$drives" | grep -e "$1" | cut -d' ' -f4) ]; then
      udisksctl mount -b "$selected_drive" 
      echo "$selected_drive Mounted drive: $selected_drive at: "
   else
      udisksctl unmount -b "$selected_drive"
      echo "$selected_drive Unmounted drive: $selected_drive"
   fi
   # echo "drives: $drives \n \n drive: $1, select: $selected_drive mounted: $is_mounted"
fi
exit 0
