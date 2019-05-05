#!/bin/bash

. common.sh

deactivatingUSBStandardMode
nfcList

ORIGINAL_CARD_NAME=$(generateRandomCardDumpName)
saveCardContent "original" $ORIGINAL_CARD_NAME

CLONE_CARD_NAME=$(generateRandomCardDumpName)
saveCardContent "clone" $CLONE_CARD_NAME
overrideRFIDContent $ORIGINAL_CARD_NAME $CLONE_CARD_NAME

nfcList "Done ! Now clone card content is :"

exit 0;