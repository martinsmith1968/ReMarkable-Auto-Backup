#!/bin/bash

! [ -d /files ] && echo "Creating /files" && mkdir /files
! [ -d /files/subfolder1 ] && echo "Creating /files/subfolder1" && mkdir /files/subfolder1
! [ -d /files/subfolder2 ] && echo "Creating /files/subfolder2" && mkdir /files/subfolder2
! [ -d /files/subfolder3 ] && echo "Creating /files/subfolder3" && mkdir /files/subfolder3

touch /files/info1.pdf

touch /files/subfolder1/doc1.pdf
touch /files/subfolder1/doc2.pdf

touch /files/subfolder2/doc3.pdf

touch /files/subfolder3/doc4.pdf
touch /files/subfolder3/doc5.pdf
touch /files/subfolder3/doc6.pdf
touch /files/subfolder3/doc7.pdf
