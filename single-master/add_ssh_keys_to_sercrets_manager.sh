#!/bin/bash -e

KEYS_DIRECTORY=$1
if [ -z "$KEYS_DIRECTORY" ];
then
  echo "Keys directory must be specified"
  exit 1
fi

# Avoid to open output in less for each AWS command
export AWS_PAGER=;
KEY_PREFIX=gerrit_secret

aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ecdsa_384_key \
    --description "Gerrit ssh_host_ecdsa_384_key" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ecdsa_384_key
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ecdsa_384_key.pub \
    --description "Gerrit ssh_host_ecdsa_384_key.pub" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ecdsa_384_key.pub
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ecdsa_521_key \
    --description "Gerrit ssh_host_ecdsa_521_key" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ecdsa_521_key
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ecdsa_521_key.pub \
    --description "Gerrit ssh_host_ecdsa_521_key.pub" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ecdsa_521_key.pub
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ecdsa_key \
    --description "Gerrit ssh_host_ecdsa_key" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ecdsa_key
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ecdsa_key.pub \
    --description "Gerrit ssh_host_ecdsa_key.pub" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ecdsa_key.pub
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ed25519_key \
    --description "Gerrit ssh_host_ed25519_key" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ed25519_key
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_ed25519_key.pub \
    --description "Gerrit ssh_host_ed25519_key.pub" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_ed25519_key.pub
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_rsa_key \
    --description "Gerrit ssh_host_rsa_key" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_rsa_key
aws secretsmanager create-secret --name ${KEY_PREFIX}_ssh_host_rsa_key.pub \
    --description "Gerrit ssh_host_rsa_key.pub" \
    --secret-string file://$KEYS_DIRECTORY/ssh_host_rsa_key.pub
