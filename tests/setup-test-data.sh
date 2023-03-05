#!/bin/bash

function create-folder() {
    ! [ -d "${1}" ] && echo "Creating ${1}" && mkdir "${1}"
}

rm -r /files/backup

create-folder "/files"
create-folder "/files/subfolder1"
create-folder "/files/subfolder2"
create-folder "/files/subfolder3"
create-folder "/files/subfolder4"

#! [ -d /files ] && echo "Creating /files" && mkdir /files
#! [ -d /files/subfolder1 ] && echo "Creating /files/subfolder1" && mkdir /files/subfolder1
#! [ -d /files/subfolder2 ] && echo "Creating /files/subfolder2" && mkdir /files/subfolder2
#! [ -d /files/subfolder3 ] && echo "Creating /files/subfolder3" && mkdir /files/subfolder3
#! [ -d /files/subfolder4 ] && echo "Creating /files/subfolder4" && mkdir /files/subfolder4

touch /files/info1.pdf

touch /files/subfolder1/doc1.pdf
touch /files/subfolder1/doc2.pdf
touch /files/subfolder1/notes1.txt

touch /files/subfolder2/doc3.pdf
touch /files/subfolder2/image1.png
touch /files/subfolder2/notes2.txt

touch /files/subfolder3/doc4.pdf
touch /files/subfolder3/doc5.pdf
touch /files/subfolder3/doc6.pdf
touch /files/subfolder3/doc7.pdf

touch /files/subfolder4/image1.png
