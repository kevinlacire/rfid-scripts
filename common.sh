#!/bin/bash

. display-utils.sh

function nfcList {
  printInfo "Checking NFC reader"
  sudo nfc-list
}

function saveCardContent {
  CARD_NAME=$1
  DUMP_PATH=$2

  printInfo "Put the $CARD_NAME card on the reader. Press Enter when it's done"
  read key
  nfcList "Current $CARD_NAME card data :"

  printInfo "Card content about to be dumped at : $DUMP_PATH"
  sudo mfoc -P 500 -O $DUMP_PATH
  printSuccess "$CARD_NAME card's content saved at : $DUMP_PATH"
}

function overrideRFIDContent {
  printInfo "Applying Original content into the clone card"
  sudo nfc-mfclassic W a $1 $2
}

function installDependencies {
  printInfo "Installing dependencies..."
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

  printSuccess "Dependencies successfully installed !"
}

function generateRandomCardDumpName {
  echo "/tmp/$(date +%s | sha256sum | base64 | head -c 32)"
}

function deactivatingUSBStandardMode {
  printInfo "Deactivating USB standard mode"
  sudo modprobe -r pn533_usb
  sudo modprobe -r pn533
}