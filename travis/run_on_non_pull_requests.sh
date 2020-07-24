#!/bin/bash
set -ev

sfdx force:org:list

# Authenticate with your playground or sandbox environment
sfdx force:auth:jwt:grant --setdefaultdevhubusername --clientid $CONSUMERKEY --jwtkeyfile assets/server.key --username $USERNAME
sfdx force:config:set defaultusername=$USERNAME

# Deploy changes and run all local tests
sfdx force:source:deploy -x manifest/package-to-deploy.xml -l RunLocalTests