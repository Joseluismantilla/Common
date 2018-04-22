#!/bin/bash

imageFile=$(yad --file --title="Select the image file")

dialog=$(yad --title "Bash Resize" --form --field="Resize parameter" --field="Quality")

size=$(echo $dialog | awk 'BEGIN {FS="|" } { print $1 }')
quality=$(echo $dialog | awk 'BEGIN {FS="|" } { print $2 }')

convert "$imageFile" -resize "$size" -quality "$quality"% "$imageFile"

yad --title="Status" --width=300  --button="gtk-ok:0"  --text="All done. Yay!"
