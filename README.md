## Gerrit multi-master multi-site AWS Template
Those are a collection of [AWS CloudFormation](https://aws.amazon.com/cloudformation/)
templates and scripts to deploy a Gerrit multi-master multi-site setup in AWS ECS
using [Fargate](https://aws.amazon.com/fargate/).

The aim is to provide some guidelines on a way to deploy a complex Gerrit installation
in the Cloud using AWS as provider.

Since the installation we are aiming to is complex, we will iteratively add components
and complexity to the setup.

## Outline

- [Overview](#overview)
- [Instructions](#instructions)
  - [Getting started](#getting-started)
  - [Cleaning up](#cleaning-up)
- [Architecture](#architecture)
  - [High level components](#high-level-components)
  - [Gerrit setup](#gerrit-setup)

## Overview

The goal of Gerrit multi-master multi-site AWS Template is to provide a fully-functional
Gerrit installation that helps users deploying a complex Gerrit installation on AWS
by providing an out-of-the-box template.

With Gerrit multi-master multi-site AWS Template, developers and administrator
can create a production-ready Gerrit installation on the cloud in minutes and
in a repeatable way, allowing them to focus on fine tuning of the Gerrit configuration
to suit the user needs.

The provided CloudFormation template automates the entire creation and deployment
of the infrastructure and the application.

## Instructions

To get the full stack up and running in your AWS you will have to install and
setup [AWS CLI](https://aws.amazon.com/cli/) to point to your account.

### Getting Started

```
aws cloudformation create-stack \
  --stack-name gerrit-ecs \
  --capabilities CAPABILITY_IAM  \
  --template-body file://<full_path_to_the_template>/aws-gerrit/cf-fargate-networking-and-gerrit-stack.yml \
  --parameters  ParameterKey=HostedZoneName,ParameterValue="gerritforgeaws.com."
```

### Cleaning up

```
aws cloudformation delete-stack --stack-name gerrit-ecs
```

## Architecture

### High level components

#### Networking

* Single VPC:
 * CIDR: 10.0.0.0/16
* Single Availability Zone
* 2 public Subnets:
 * CIDR: 10.0.0.0/24 and 10.0.1.0/24
* 1 public NLB exposing:
 * HTTP on port 8080
 * SSH on port 29418
* 1 Internet Gateway

#### Deployment type

* Latest Gerrit version deployed using the official [Docker image](https://hub.docker.com/r/gerritcodereview/gerrit)
* Application deployed in ECS with Fargate

#### Logging

* Gerrit `error_log` is exported in a Log Group in CloudWatch

#### Monitoring

* Standard CloudWatch monitoring metrcis for each component

### Gerrit setup

Gerrit is currently deployed as single master. The aim is to evolve to a
multi-master multi-site configuration in multi Availability Zones.
