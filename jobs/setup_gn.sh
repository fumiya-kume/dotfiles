#!/bin/bash
mkdir ~/tmp
git clone https://gn.googlesource.com/gn ~/tmp/gn -q
python ~/tmp/gn/build/gen.py
ninja -C ~/tmp/gn/out > /dev/null

mkdir -p ~/.bin
cp ~/tmp/gn/out/gn ~/.bin
rm -rf ~/tmp
