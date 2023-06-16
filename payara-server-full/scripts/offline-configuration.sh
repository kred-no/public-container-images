#!/bin/env bash
set -e

echo "[INFO] If the 'X_ADMIN_PASSWORD' is set, then admin password will be changed to this value."
if [ $X_ADMIN_PASSWORD ]; then
  echo "[INFO] Updating administrator password"
  
  touch $PASSWORD_FILE
  printf "%s\n%s\n" "AS_ADMIN_PASSWORD=$ADMIN_PASSWORD" "AS_ADMIN_NEWPASSWORD=$X_ADMIN_PASSWORD" > $PASSWORD_FILE
  $PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE change-admin-password --domain_name=$DOMAIN_NAME
  printf "%s\n" "AS_ADMIN_PASSWORD=$X_ADMIN_PASSWORD" > $PASSWORD_FILE
fi

echo "[INFO] Finished."
