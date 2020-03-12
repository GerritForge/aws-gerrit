CLUSTER_STACK_NAME:=gerrit-cluster
CLUSTER_TEMPLATE:=cf-cluster.yml
SERVICE_TEMPLATE:=cf-service.yml
SERVICE_STACK_NAME:=gerrit-service
AWS_REGION:=us-east-2
AWS_PROFILE:=aws-dev

.PHONY: create-all delete-all cluster service wait-for-cluster-creation wait-for-service-deletion

create-all: cluster wait-for-cluster-complete service

cluster:
	aws cloudformation create-stack \
		--stack-name $(CLUSTER_STACK_NAME) \
		--capabilities CAPABILITY_IAM  \
		--template-body file://`pwd`/$(CLUSTER_TEMPLATE) \
		--region $(AWS_REGION)

service:
	aws cloudformation create-stack \
		--stack-name $(SERVICE_STACK_NAME) \
		--capabilities CAPABILITY_IAM  \
		--template-body file://`pwd`/$(SERVICE_TEMPLATE) \
		--region $(AWS_REGION)

wait-for-cluster-creation:
	aws cloudformation wait stack-create-complete \
	--stack-name $(CLUSTER_STACK_NAME) \
	--region $(AWS_REGION)

wait-for-service-deletion:
	aws cloudformation wait stack-delete-complete \
	--stack-name $(SERVICE_STACK_NAME) \
	--region $(AWS_REGION)

delete-cluster:
	aws cloudformation delete-stack \
	--stack-name $(CLUSTER_STACK_NAME) \
	--region $(AWS_REGION)

delete-service:
	aws cloudformation delete-stack \
	--stack-name $(SERVICE_STACK_NAME) \
	--region $(AWS_REGION)

delete-all: delete-service wait-for-service-deletion delete-cluster
