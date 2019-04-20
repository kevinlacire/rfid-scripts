#!/bin/bash

. common.sh

mfoc -P 500 -O dumb.bin
xxd dumb.bin

nfc-mfclassic w B dump_modified.bin dump1.bin