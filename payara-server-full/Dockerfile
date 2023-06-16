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
    X_ENABLE_SECURE_ADMIN= \
    X_LOGBACK_CONFIG_FILE=

COPY --chown=payara:payara [ "./scripts/offline-configuration.sh", "/opt/payara/scripts/init_2_offline-configuration.sh" ]
COPY --chown=payara:payara [ "./scripts/online-configuration.sh", "/opt/payara/scripts/init_3_online-configuration.sh" ]
COPY --chown=payara:payara [ "./scripts/hotfixes.sh", "/opt/payara/scripts/init.d/hotfixes.sh" ]
