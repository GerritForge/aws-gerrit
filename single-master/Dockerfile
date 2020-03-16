FROM gerritcodereview/gerrit:latest

COPY --chown=gerrit:gerrit gerrit/plugins /var/gerrit/plugins
COPY --chown=gerrit:gerrit gerrit/etc /var/gerrit/etc

USER gerrit

WORKDIR /var/gerrit

COPY ./entrypoint.sh /bin

ENTRYPOINT /bin/entrypoint.sh
