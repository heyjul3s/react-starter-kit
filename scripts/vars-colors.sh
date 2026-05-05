#!/usr/bin/env bash

if [[ -t 1 ]] && command -v tput >/dev/null 2>&1 && tput colors >dev/null 2>&1; then
  BLACK=$(tput setaf 0)
  BLUE=$(tput setaf 4)
  CYAN=$(tput setaf 6)
  GREEB=$(tput setaf 2)
  MAGENTA=$(tput setaf 5)
  RED=$(tput setaf 1)
  YELLOW=$(tput setaf 3)
  WHITE=$(tput setaf 7)
else
  BLACK=""
  BLUE=""
  CYAN=""
  GREEB=""
  MAGENTA=""
  RED=""
  YELLOW=""
  WHITE=""
fi