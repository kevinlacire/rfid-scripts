#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;36m'
PURPLE='\033[1;35m'
RESET='\033[0m'

function printMessage(){
  if [ $1 != 0 ]; then
    echo -e "${RED}$2 ${RESET}";
    exit 1;
  else
    echo -e "${GREEN}$2 ${RESET}";
  fi
}

function printError(){
  echo -e "${RED}$1 ${RESET}";
  exit 1;
}

function printInfo(){
  echo -e "${BLUE}$1 ${RESET}";
}

function printSuccess(){
  echo -e "${GREEN}$1 ${RESET}";
}