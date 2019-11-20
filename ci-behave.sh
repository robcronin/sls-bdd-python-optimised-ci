#!/bin/bash

set -e

# Get a stack from the lock table
STACK_NAME=$(pipenv run python get-stack.py)

# Deploy the new code to the stack
yarn deploy --stackName $STACK_NAME
export ENDPOINT=$(yarn sls info --verbose --stackName $STACK_NAME | grep ServiceEndpoint | cut -d ' ' -f 2)
cp features/environment-dist.py features/environment.py
sed 's?{YOUR_DOMAIN_NAME_NO_TRAILING_SLASH}?\"'"$ENDPOINT"'\"?' features/environment-dist.py > features/environment.py

# Run BDD tests on the stack
set +e
yarn test:behave
BEHAVE_SUCESS=$?
set -e

# Release the stack for other jobs
curl -X PUT "${BDD_LOCK_ENDPOINT}/release-stack/${STACK_NAME}" -H "Authorization: ${BDD_LOCK_AUTH_TOKEN}"

exit $BEHAVE_SUCESS
