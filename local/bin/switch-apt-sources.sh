#!/bin/bash

APT_BASE_PATH="/etc/apt"
SOURCESD_PATH="${APT_BASE_PATH}/sources.list.d"
SOURCE_LIST=( "${APT_BASE_PATH}/sources.list" 
	      "${SOURCESD_PATH}/devt-debian-prod.list" 
	      "${SOURCESD_PATH}/docker.list" 
	      "${SOURCESD_PATH}/google-chrome-wago.list" 
	      "${SOURCESD_PATH}/onedrive.list" 
	      "${SOURCESD_PATH}/teams.list" 
	      "${SOURCESD_PATH}/virtualbox.list" 
	      "${SOURCESD_PATH}/wagoit.list"
	    )

print_help() {
    echo "-e | enable disabled sources"
    echo "-d | disable enabled sources"
    echo "-p | print configured sources list"
}

if [[ $# -eq 0 ]]; then
  print_help
  exit
fi

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -h | --help )
    print_help
    exit
    ;;
  -e | --enable )
    enable=1
    ;;
  -d | --disable )
    disable=1
    ;;
  -p | --print )
    print=1
    ;;
  * )
    print_help
    exit
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

if [[ ${print} -eq 1 ]]; then
   printf '%s\n' "${SOURCE_LIST[@]}"
fi

if [[ ${disable} -eq 1 ]]; then
   for file in "${SOURCE_LIST[@]}"; do
      sudo mv "${file}" "${file}.disabled"
   done
fi

if [[ ${enable} -eq 1 ]]; then
   for file in "${SOURCE_LIST[@]}"; do
      sudo mv "${file}.disabled" "${file}"
   done
fi
