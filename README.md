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

## Overview

The goal of Gerrit multi-master multi-site AWS Template is to provide a fully-functional
Gerrit installation that helps users deploying a complex Gerrit installation on AWS
by providing an out-of-the-box template.

With Gerrit multi-master multi-site AWS Template, developers and administrator
can create a production-ready Gerrit installation on the cloud in minutes and
in a repeatable way, allowing them to focus on fine tuning of the Gerrit configuration
to suit the user needs.

The provided CloudFormation template automates the entire creation and deployment
of the infrastructure. The template includes the following components:

**Gerrit**

Latest Gerrit version deployed using the official [Docker image](https://hub.docker.com/r/gerritcodereview/gerrit)

**Infrastructure**

Fargate components to run the application in ECS in a high-availability configuration.

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

![AWS Diagram](images/AWS-schema.png)

### High level components

#### Networking

* Single VPC
* 2 public Subnets
* 1 public NLB exposing port 8080 and 29418
* 1 Internet Gateway

#### Deployment type

* The Gerrit Service is deployed in ECS with Fargate

#### Logging

* Gerrit `error_log` is exported in a Log Group in CloudWatch
