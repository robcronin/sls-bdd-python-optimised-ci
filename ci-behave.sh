#!/bin/bash

set -e

STACK_NAME=$(pipenv run python get-stack.py)

yarn deploy --stackName $STACK_NAME
export ENDPOINT=$(yarn sls info --verbose --stackName $STACK_NAME | grep ServiceEndpoint | cut -d ' ' -f 2)
cp features/environment-dist.py features/environment.py
sed 's?{YOUR_DOMAIN_NAME_NO_TRAILING_SLASH}?\"'"$ENDPOINT"'\"?' features/environment-dist.py > features/environment.py

set +e
yarn test:behave
BEHAVE_SUCESS=$?
set -e

curl -X PUT "${BDD_LOCK_ENDPOINT}/release-stack/${STACK_NAME}" -H "Authorization: ${BDD_LOCK_AUTH_TOKEN}"

exit $BEHAVE_SUCESS