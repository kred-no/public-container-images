# PAYARA SERVER (FULL)

```text
Official Image: https://hub.docker.com/r/payara/server-full

Builds (DockerHub): https://hub.docker.com/r/kdsda/payara-server-full
Dockerfile (Github): https://raw.githubusercontent.com/kred-no/public-container-images/main/payara-server-full/Dockerfile
```

## Description

Creates a new image, based on official Payara docker image builds, with the following changes:

```text
  1. Generate Norwegian locale (req. root privileges)
  2. Adds optional startup-scripts. Run by setting the corresponding environment variable(s):

    * X_ADMIN_PASSWORD => Change Admin-password
    * X_ENABLE_SECURE_ADMIN => Enables secure-admin
    * X_LOGBACK_CONFIG_FILE => Add Logback jvm-configuration-entry
```

## Example use

```bash
# Run container
docker run --name payara --rm -d \
  -e "LC_ALL=nb_NO.ISO-8859-1" \
  -e "TZ=Europe/Oslo" \
  -p 8080:8080 -p 4848:4848  \
  kdsda/payara-server-full:6.2023.6-jdk17

# Stop/Cleanup
docker stop payara
```
