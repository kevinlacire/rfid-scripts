#!/bin/bash

function generateRandomCardDumpName {
    echo "/tmp/$(date +%s | sha256sum | base64 | head -c 32)"
}

function saveCardContent {
    CARD_NAME=$1
    RANDOM_CARD_NAME=$2

    read -p "Put the $CARD_NAME card on the reader. Press Enter when it's done." key
    echo "Current $CARD_NAME card data :"
    sudo nfc-list

    sudo mfoc -P 500 -O $RANDOM_CARD_NAME
    echo "$CARD_NAME card's content saved in file : $RANDOM_CARD_NAME"
}

echo "Deactivating USB standard mode"
sudo modprobe -r pn533_usb
sudo modprobe -r pn533

echo "Checking NFC reader"
sudo nfc-list

ORIGINAL_CARD_NAME=$(generateRandomCardDumpName)
saveCardContent "original" $ORIGINAL_CARD_NAME

CLONE_CARD_NAME=$(generateRandomCardDumpName)
saveCardContent "clone" $CLONE_CARD_NAME

echo "Applying Original content into the clone card"
sudo nfc-mfclassic W a $ORIGINAL_CARD_NAME $CLONE_CARD_NAME

echo "Done ! Now clone card content is :"
sudo nfc-list

exit 0;