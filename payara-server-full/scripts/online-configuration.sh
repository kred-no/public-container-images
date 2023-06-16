#!/bin/env bash
set -e

COMMAND="$PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE"

if [ "$X_DISABLE_SECURE_ADMIN" ] || [ "$X_LOGBACK_CONFIG_FILE" ] || [ "$X_ENABLE_HAZELCAST" ]; then
  echo "[INFO] Starting online configuration."
  echo "y" | $COMMAND start-domain $DOMAIN_NAME
fi

if [ $X_DISABLE_SECURE_ADMIN ]; then
  echo "[INFO] Disable secure admin."
  echo "y" | $COMMAND disable-secure-admin
fi

if [ $X_ENABLE_HAZELCAST ]; then
  echo "[INFO] Enable Hazelcast DataGrid."
  echo "y" | $COMMAND set-hazelcast-configuration --enabled=true
fi

if [ $X_LOGBACK_CONFIG_FILE ]; then
  echo "[INFO] Create Logback option."
  echo "y" | $COMMAND create-jvm-options "-Dlogback.configurationFile=${X_LOGBACK_CONFIG_FILE}" 
fi

echo "[INFO] Stopping domain (online configuration finished)."
$COMMAND stop-domain --kill=true $DOMAIN_NAME

unset COMMAND
