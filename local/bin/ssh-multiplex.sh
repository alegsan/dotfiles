#!/bin/bash

CONTROL_PATH_FOLDER="/tmp"
CONTROL_PATH_PREFIX="ssh-"

SSH_HOSTS=()

print_help() {
    echo "-p | print only activate ssh multiplex sessions"
}

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -h | --help )
    print_help
    exit
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

regex='\/tmp\/ssh-[[:alnum:]]*@(.*):[[:digit:]]+'

for session in "${CONTROL_PATH_FOLDER}/${CONTROL_PATH_PREFIX}"*; do
  if [[ ${session} =~ $regex ]]; then
    SSH_HOSTS+=("${BASH_REMATCH[1]}")
  fi
done

if [[ ${#SSH_HOSTS[@]} -eq 0 ]]; then
  echo "No active ssh muliplex session open"
  exit
fi

if [[ ${print} -eq 1 ]]; then
  printf '%s\n' "${SSH_HOSTS[@]}"
else
  for hostname in "${SSH_HOSTS[@]}"; do
    if ssh -O check "${hostname}" &> /dev/null; then
      echo "Closing ssh connection to ${hostname}"
      ssh -O cancel "${hostname}" &> /dev/null
      ssh -O exit "${hostname}" &> /dev/null
    fi
  done
fi
