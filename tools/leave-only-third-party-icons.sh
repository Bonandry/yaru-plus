#!/bin/sh

cd ../
home="$(pwd)"

sizes=(16x16 24x24 32x32 48x48 scalable)
directories=(actions apps categories devices emblems mimetypes places status)

echo "PHASE 1 – Locate the directories of original Yaru"

function main() 
{
    getDirectories

    for size in "${sizes[@]}"
    do
        # check if a directory doesn't exist:
        if [ ! -d "$size" ]; then
          mkdir $size
        fi
        for directory in "${directories[@]}"
        do
            fileList $size $directory
       done
   done
   cd $home
}

function getDirectories() 
{                             # get all directories in the elementary icon folder
    local current=''
    cd /usr/share/icons/Yaru

    for directory in */
    do
        current="$(echo $directory)"                    # directory name include /
        directory_name=${current::-1}                   # exclude last char '/'
        if [ "$directory_name" != "cursors" ]           # it doesn't include cursor folder
        then
            directories+=($directory_name)
        fi
    done
}

echo "PHASE 2 – Generate output files without extension"

function fileList() 
{
    local directory=$1
    local size=$2
    local search_file=( $(find /usr/share/icons/Yaru/$size/$directory/) )
    if [ $search_file ]
    then
        for entry in "${search_file[@]}"
        do
          for i in *; do echo "${i%.png}"; done > $size-$directory.txt
        done
    fi
}

echo "PHASE 3 – Remove the files that already exist in Canonical's original Yaru"

function removeList()
{
  # rm $(cat $size-$directory.txt | xargs).svg
  rm $(awk '{ print $0".svg" }' $size-$directory.txt)
}

main