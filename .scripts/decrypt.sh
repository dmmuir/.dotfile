#!/bin/sh

in_file=$1
out_file=$(echo $1 | sed 's/.enc//')
libressl-openssl aes-256-cbc -d -in $in_file -out $out_file

