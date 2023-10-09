#!/bin/sh

for i in $(dirname $(find .config) | grep ".config/" | sort -u) ; do 
mkdir -p ~/$i
done
for i in $(find .config -type f | grep ".config/" | sort -u) ; do
ln $i ~/$i
done


