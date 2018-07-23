#!/bin/sh
source docker-expand-env.sh

: ${PSM_IDENTITY_DOMAIN?"Need to set PSM_IDENTITY_DOMAIN"}
: ${PSM_USERNAME?"Need to set PSM_USERNAME"}
: ${PSM_PASSWORD?"Need to set PSM_PASSWORD"}
: ${PSM_REGION?"Need to set PSM_REGION"}
PSM_OUTPUT="${PSM_OUTPUT:-json}"

PSM_CONFIG=$(cat <<ENDOFTEMPLATE
{
    "username":"${PSM_USERNAME}",
    "password":"${PSM_PASSWORD}",
    "identityDomain":"${PSM_IDENTITY_DOMAIN}",
    "region":"${PSM_REGION}",
    "outputFormat":"json"
}
ENDOFTEMPLATE
)

echo $PSM_CONFIG > /tmp/psm.json
psm setup -c /tmp/psm.json > /dev/null
rm /tmp/psm.json
exec "$@"
