# SMTP server

This is a set of Cloud Formation Templates and scripts to spin up a simple test 
SMTP server service based on [MailHog](https://github.com/mailhog/MailHog).

MailHog is an email testing tool for developers:

* Configure your application to use MailHog for SMTP delivery
* View messages in the web UI, or retrieve them with the JSON API
* Optionally release messages to real SMTP servers for delivery

It can be used to provide a simple SMTP server instance to be used to 
test integration with any Gerrit setup in the different cookbooks.

## How to run it

### Prerequisites

As a prerequisite to run this stack, you will need a registered and correctly
configured domain in [Route53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/getting-started.html)

### Getting Started

* Create a key pair to access the EC2 instances in the cluster:

```
aws ec2 create-key-pair --key-name gerrit-cluster-keys \
  --query 'KeyMaterial' --output text > gerrit-cluster.pem
```

*NOTE: the EC2 key pair are useful when you need to connect to the EC2 instances
for troubleshooting purposes. Store them in a `pem` file to use when ssh-ing into your
instances as follow: `ssh -i yourKeyPairs.pem <ec2_instance_ip>`*

* Create the SMTP server stack:

```
make mail-service HOSTED_ZONE_NAME=mycompany.com
```

The `HOSTED_ZONE_NAME` value is the Hosted Zone Name where a DSN route pointing
to the SMTP server service will be created.

### Cleaning up

```
make delete-mail-service
```

### Access your SMTP server instance

* SMTP Service:
 * **URI**: gerrit-mail-service.mycompany.com
 * **Port**: 1025
*  SMTP Service UI:
 * **URI**: https://gerrit-mail-service.mycompany.com
 * **Port**: 8025
