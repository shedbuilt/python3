#!/bin/bash
# Symlink python to python3 if none exists
if [ ! -e /usr/bin/python ]; then
    ln -s python3 /usr/bin/python || exit 1
fi
# Install Python 3's package manager
python3 -m ensurepip
