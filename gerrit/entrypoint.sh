#!/bin/bash -e

if [ ! -d /var/gerrit/git/All-Projects.git ] || [ "$1" == "init" ]
then
  rm -fr /var/gerrit/plugins/*
  echo "Initializing Gerrit site ..."
  java -jar /var/gerrit/bin/gerrit.war init --batch --install-all-plugins -d /var/gerrit
  java -jar /var/gerrit/bin/gerrit.war reindex -d /var/gerrit
  git config -f /var/gerrit/etc/gerrit.config --add container.javaOptions "-Djava.security.egd=file:/dev/./urandom"
fi

git config -f /var/gerrit/etc/gerrit.config gerrit.canonicalWebUrl "${CANONICAL_WEB_URL:-http://$HOSTNAME}"
git config -f /var/gerrit/etc/gerrit.config httpd.listenUrl "${HTTPD_LISTEN_URL:-http://*:8080/}"

if [ "$1" != "init" ]
then
  /tmp/setup_gerrit.py
  echo "Running Gerrit ..."
  exec /var/gerrit/bin/gerrit.sh run
fi
