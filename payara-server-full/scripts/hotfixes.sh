#!/bin/env bash
set -e

# ISSUE:
#   > https://github.com/payara/Payara/issues/2267 & https://github.com/payara/Payara/issues/5192
# FIXED:
#   > https://github.com/payara/Payara/pull/5193 (Payara 6.x)
if [ "$X_HOTFIX_1_ENABLED" ]; then
  echo "[INFO] Adding hostname to hosts-file"
  echo 127.0.0.1 `cat /etc/hostname` | tee -a $HOME_DIR/.hosts
  export HOSTALIASES="$HOME_DIR/.hosts"
fi
