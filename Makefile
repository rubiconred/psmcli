build: psmcli.zip
	docker build -t craigbarrau/psm-cli .

psmcli.zip:
	curl -X GET -u ${PSM_USERNAME}:${PSM_PASSWORD} -H X-ID-TENANT-NAME:${PSM_IDENTITY_DOMAIN} https://psm.${PSM_REGION}.oraclecloud.com/paas/core/api/v1.1/cli/${PSM_IDENTITY_DOMAIN}/client -o psmcli.zip

run:
	docker run -ti \
	-e PSM_IDENTITY_DOMAIN=${PSM_IDENTITY_DOMAIN} \
	-e PSM_USERNAME=${PSM_USERNAME} \
	-e PSM_PASSWORD=${PSM_PASSWORD} \
	-e PSM_REGION=${PSM_REGION} \
	craigbarrau/psm-cli /bin/sh

clean:
	rm psmcli.zip	