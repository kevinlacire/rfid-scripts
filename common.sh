#!/bin/bash

function installDependencies {
    echo "Installing dependencies..."
    sudo apt-get install pcsc-tools pcscd libpcsclite-dev libpcsclite1 libusb-dev
    wget http://dl.bintray.com/nfc-tools/sources/libnfc-1.7.1.tar.bz2 
    tar xjf libnfc-1.7.1.tar.bz2 
    cd libnfc-1.7.1/ 
    ./configure --with-drivers=all 
    make
    sudo make install 
    sudo ldconfig

    wget https://github.com/nfc-tools/mfoc/archive/mfoc-0.10.7.tar.gz
    tar -xzvf mfoc-0.10.7.tar.gz
    cd mfoc-0.10.7
    autoreconf -vis
    ./configure
    sudo make
    sudo make install

    echo "Dependencies successfully installed !"
}

function generateRandomCardDumpName {
    echo "/tmp/$(date +%s | sha256sum | base64 | head -c 32)"
}
