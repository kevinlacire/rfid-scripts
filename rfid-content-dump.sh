#!/bin/bash

. common.sh

CARD_PATH=$(generateRandomCardDumpName)

for i in "$@"; do
  case $i in
    -o=*|--output=*)
      CARD_PATH="${i#*=}"
    shift
    ;;
    -h|--help)
      printInfo "Creates a card dump"
      printInfo "-o|--output : path where the dump should be saved"
      exit 0;
    shift
    ;;
    *)
      printError "Unknown parameter '$i'"
      exit 0;
    ;;
  esac
done

deactivatingUSBStandardMode
nfcList
saveCardContent "original" $CARD_PATH

exit 0;