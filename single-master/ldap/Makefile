include ../setup.env

docker-registry-login:
	aws ecr get-login-password --region $(AWS_REGION) \
		| docker login --username AWS --password-stdin $(DOCKER_REGISTRY_URI)/aws-gerrit/keycloak

ldap-build:
	docker build -t aws-gerrit/keycloak .
	docker tag aws-gerrit/keycloak:latest $(DOCKER_REGISTRY_URI)/aws-gerrit/keycloak:latest

ldap-publish: docker-registry-login ldap-publish
	docker push $(DOCKER_REGISTRY_URI)/aws-gerrit/keycloak:latest
