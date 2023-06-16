ARG base_image_name
ARG base_image_tag

FROM "${base_image_name:-payara/server-full}:${base_image_tag:-'6.2023.6-jdk17'}"

USER root

# Generate Norwegian locale-files
RUN set -x \
  && sed -i "/nb_NO/s/^# \?//g" /etc/locale.gen \
  && locale-gen

USER payara

ENV X_ADMIN_PASSWORD= \
    X_DISABLE_SECURE_ADMIN= \
    X_ENABLE_HAZELCAST= \
    X_LOGBACK_CONFIG_FILE=

ENV X_HOTFIX_1_ENABLED= \
    X_HOTFIX_2_ENABLED=

RUN set -x \
  && COMMAND="$PAYARA_DIR/bin/asadmin --user $ADMIN_USER --passwordfile=$PASSWORD_FILE" \
  && $COMMAND start-domain $DOMAIN_NAME \
  && $COMMAND enable-secure-admin \
  && $COMMAND set-hazelcast-configuration --enabled=false \
  && $COMMAND stop-domain --kill=true $DOMAIN_NAME \
  && unset COMMAND

COPY --chown=payara:payara --chmod=0550 [ "./scripts/offline-configuration.sh", "/opt/payara/scripts/init_2_offline-configuration.sh" ]
COPY --chown=payara:payara --chmod=0550 [ "./scripts/online-configuration.sh", "/opt/payara/scripts/init.d/online-configuration.sh" ]
COPY --chown=payara:payara --chmod=0550 [ "./scripts/hotfixes.sh", "/opt/payara/scripts/init.d/hotfixes.sh" ]
