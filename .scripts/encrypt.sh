#!/bin/sh

filename=$1
openssl aes-256-cbc -in $filename -out ${filename}.enc
rm $filename
