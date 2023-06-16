#!/bin/env bash
set -e

COMMAND="$PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE"

if [ "$X_ENABLE_SECURE_ADMIN" ] || [ "$X_LOGBACK_CONFIG_FILE" ] || [ "$X_DISABLE_HAZELCAST" ]; then
  echo "[INFO] Starting domain for online configuration."
  $COMMAND start-domain $DOMAIN_NAME
fi

if [ $X_ENABLE_SECURE_ADMIN ]; then
  echo "[INFO] Enabling secure admin."
  echo "y" | $COMMAND enable-secure-admin
fi

if [ $X_LOGBACK_CONFIG_FILE ]; then
  echo "[INFO] Creating Logback option."
  echo "y" | $COMMAND create-jvm-options "-Dlogback.configurationFile=${X_LOGBACK_CONFIG_FILE}" 
fi

if [ $X_DISABLE_HAZELCAST ]; then
  echo "[INFO] Disables Hazelcast DataGrid."
  echo "y" | $COMMAND set-hazelcast-configuration --enabled=false
fi

echo "[INFO] Stopping domain (restart required).."
$COMMAND stop-domain --kill=true $DOMAIN_NAME
