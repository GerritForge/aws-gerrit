FROM jboss/keycloak:latest

COPY --chown=1000:1000 realm/dev-realm.json /tmp

ENV KEYCLOAK_IMPORT=/tmp/dev-realm.json
