#!/usr/bin/env bash

if [[ -t 1 ]] && command -v tput >/dev/null 2>&1 && tput colors >dev/null 2>&1; then
  BOLD=$(tput bold)
  NORMAL=$(tput sgr0)
else
  BOLD=""
  NORMAL=""
fi