DOCKER_NAMESPACE=craigbarrau
PSM_VERSION := $(shell unzip -qql psmcli.zip | head -n1 | tr -s ' ' | cut -d ' ' -f5- | cut -d '-' -f2 | cut -d '/' -f1)

include environment

build: psmcli.zip
	docker build -t $(DOCKER_NAMESPACE)/psm-cli .

download: psmcli.zip
	@curl -X GET -u $(PSM_USERNAME):$(PSM_PASSWORD) -H X-ID-TENANT-NAME:$(PSM_IDENTITY_DOMAIN) https://psm.$(PSM_REGION).oraclecloud.com/paas/core/api/v1.1/cli/$(PSM_IDENTITY_DOMAIN)/client -o psmcli.zip
	@cp psmcli.zip `unzip -qql psmcli.zip | head -n1 | tr -s ' ' | cut -d ' ' -f5- | cut -d '/' -f1`.zip

show_latest:
	@curl -X GET -u $(PSM_USERNAME):$(PSM_PASSWORD) -H X-ID-TENANT-NAME:$(PSM_IDENTITY_DOMAIN) https://psm.$(PSM_REGION).oraclecloud.com/paas/core/api/v1.1/cli/$(PSM_IDENTITY_DOMAIN)/client -o temp
	@unzip -qql psmcli.zip | head -n1 | tr -s ' ' | cut -d ' ' -f5- | cut -d '/' -f1
	@rm temp

load_secrets:
	docker swarm init
	@printf $(PSM_IDENTITY_DOMAIN) | docker secret create psm.identitydomain -
	@printf $(PSM_USERNAME) | docker secret create psm.username -
	@printf $(PSM_PASSWORD) | docker secret create psm.password -

clean:
	rm psmcli*.zip

push:
	docker tag $(DOCKER_NAMESPACE)/psm-cli $(DOCKER_NAMESPACE)/psm-cli:$(PSM_VERSION)
	docker push $(DOCKER_NAMESPACE)/psm-cli:$(PSM_VERSION)
	docker push $(DOCKER_NAMESPACE)/psm-cli
