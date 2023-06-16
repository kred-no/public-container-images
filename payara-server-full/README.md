# PAYARA SERVER (FULL)

Creates a new image, based on official Payara docker image builds, with the following changes:

```text
  1. Generate Norwegian locale (req. root privileges)
  2. Adds optional startup-scripts. Run by setting the corresponding environment variable(s):

    * X_ADMIN_PASSWORD => Change Admin-password
    * X_ENABLE_SECURE_ADMIN => Enables secure-admin
    * X_LOGBACK_CONFIG_FILE => Add Logback jvm-configuration-entry
```
