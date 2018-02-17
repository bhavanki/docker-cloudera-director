#!/bin/bash

CLOUDERA_DIRECTOR_HOME=/home/director
DIRECTOR_SERVER_HOME="${CLOUDERA_DIRECTOR_HOME}/cloudera-director-server-2.7.0"
DB_DIR="${CLOUDERA_DIRECTOR_HOME}/db"
ETC_DIR="${DIRECTOR_SERVER_HOME}/etc"
PID_DIR="${DIRECTOR_SERVER_HOME}"
export LOG_DIR="${CLOUDERA_DIRECTOR_HOME}/logs"
export PLUGIN_DIR="${DIRECTOR_SERVER_HOME}/plugins"

MAIN_CONFIG="${ETC_DIR}/application.properties"
LOGGING_CONFIG="${ETC_DIR}/logback.xml"
ACCESS_LOGGING_CONFIG="${ETC_DIR}/logback-access.xml"

CLASSPATH="$(find "${DIRECTOR_SERVER_HOME}/lib" -name "launchpad-server-*-exec.jar")"

JAVA_OPTS=("-XX:+CMSClassUnloadingEnabled"
    "-Xms512m"
    "-Xmx1g")

echo "Starting Cloudera Director Server"
cd "${DIRECTOR_SERVER_HOME}" || exit "Failed to cd to ${DIRECTOR_SERVER_HOME}"
java "${JAVA_OPTS[@]}" \
    -Dpid.file="${PID_DIR}/application.pid" \
    -Djava.awt.headless=true \
    -Djava.net.preferIPv4Stack=true \
    -Dlogging.config="${LOGGING_CONFIG}" \
    -Dlogback.configurationFile="${LOGGING_CONFIG}" \
    -Dloader.path="lib/" \
    -cp "${CLASSPATH}" \
    org.springframework.boot.loader.PropertiesLauncher \
    --spring.config.additional-location="${MAIN_CONFIG}" \
    --lp.access.logging.config.file="${ACCESS_LOGGING_CONFIG}" \
    --lp.database.h2.defaultPath="${DB_DIR}/state" "$@"

#echo Starting bash
#exec bash
