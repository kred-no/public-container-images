#!/bin/env bash
set -e

if [ "$X_ENABLE_SECURE_ADMIN" ] || [ "$X_LOGBACK_CONFIG_FILE" ]; then
  echo "[INFO] Starting domain for online configuration."
  $PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE start-domain $DOMAIN_NAME
fi

if [ $X_ENABLE_SECURE_ADMIN ]; then
  echo "[INFO] Enabling secure admin."
  echo "y" | $PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE enable-secure-admin
fi

if [ $X_LOGBACK_CONFIG_FILE ]; then
  echo "[INFO] Creating Logback option."
  echo "y" | $PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE create-jvm-options "-Dlogback.configurationFile=${X_LOGBACK_CONFIG_FILE}" 
fi

echo "[INFO] Stopping domain (restart required).."
$PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE stop-domain --kill=true $DOMAIN_NAME
