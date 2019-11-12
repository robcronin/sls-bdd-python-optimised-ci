#!/bin/bash

set -e
STACK_NAME=$(curl -X GET ${BDD_LOCK_ENDPOINT}/get-available/sls-bdd | python claim-stack.py)
yarn deploy --stackName $STACK_NAME
export ENDPOINT=$(yarn sls info --verbose --stackName $STACK_NAME | grep ServiceEndpoint | cut -d ' ' -f 2)
cp features/environment-dist.py features/environment.py
sed 's?{YOUR_DOMAIN_NAME_NO_TRAILING_SLASH}?\"'"$ENDPOINT"'\"?' features/environment-dist.py > features/environment.py

set +e
yarn test:behave
BEHAVE_SUCESS=$?
set -e

exit $BEHAVE_SUCESS