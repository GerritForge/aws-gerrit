CLUSTER_STACK_NAME:=gerrit-cluster
CLUSTER_TEMPLATE:=cf-cluster.yml
SERVICE_TEMPLATE:=cf-service.yml
SERVICE_STACK_NAME:=gerrit-service
AWS_REGION:=us-east-2
AWS_PROFILE:=aws-dev
AWS_FC_COMMAND=export AWS_PAGER=;aws cloudformation

.PHONY: create-all delete-all cluster service wait-for-cluster-creation wait-for-service-deletion

create-all: cluster wait-for-cluster-complete service

cluster:
	$(AWS_FC_COMMAND) create-stack \
		--stack-name $(CLUSTER_STACK_NAME) \
		--capabilities CAPABILITY_IAM  \
		--template-body file://`pwd`/$(CLUSTER_TEMPLATE) \
		--region $(AWS_REGION)

service:
	$(AWS_FC_COMMAND) create-stack \
		--stack-name $(SERVICE_STACK_NAME) \
		--capabilities CAPABILITY_IAM  \
		--template-body file://`pwd`/$(SERVICE_TEMPLATE) \
		--region $(AWS_REGION) \
		--parameters  ParameterKey=ClusterStackName,ParameterValue=$(CLUSTER_STACK_NAME)

wait-for-cluster-creation:
	$(AWS_FC_COMMAND) wait stack-create-complete \
	--stack-name $(CLUSTER_STACK_NAME) \
	--region $(AWS_REGION)

wait-for-service-deletion:
	$(AWS_FC_COMMAND) wait stack-delete-complete \
	--stack-name $(SERVICE_STACK_NAME) \
	--region $(AWS_REGION)

delete-cluster:
	$(AWS_FC_COMMAND) delete-stack \
	--stack-name $(CLUSTER_STACK_NAME) \
	--region $(AWS_REGION)

delete-service:
	$(AWS_FC_COMMAND) delete-stack \
	--stack-name $(SERVICE_STACK_NAME) \
	--region $(AWS_REGION)

delete-all: delete-service wait-for-service-deletion delete-cluster