MAIL_SERVICE_TEMPLATE:=cf-mail-service.yml
AWS_REGION:=us-east-1
AWS_FC_COMMAND=export AWS_PAGER=;aws cloudformation
MAIL_SERVICE_STACK_NAME:=gerrit-mail-service
HOSTED_ZONE_NAME:=gerritforgeaws.com

.PHONY: mail-service delete-mail-service

mail-service:
	$(AWS_FC_COMMAND) create-stack \
		--stack-name $(MAIL_SERVICE_STACK_NAME) \
		--capabilities CAPABILITY_IAM  \
		--template-body file://`pwd`/$(MAIL_SERVICE_TEMPLATE) \
		--region $(AWS_REGION) \
		--parameters \
		ParameterKey=HostedZoneName,ParameterValue=$(HOSTED_ZONE_NAME)

delete-mail-service:
	$(AWS_FC_COMMAND) delete-stack \
	--stack-name $(MAIL_SERVICE_STACK_NAME) \
	--region $(AWS_REGION)
