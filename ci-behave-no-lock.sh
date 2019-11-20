#!/bin/bash

set -e

# Deploy a brand new stack
yarn deploy --stackName 'circle-'"${CIRCLE_BUILD_NUM}"'-'"${CIRCLE_BRANCH}"
export ENDPOINT=$(yarn sls info --verbose --stackName 'circle-'"${CIRCLE_BUILD_NUM}"'-'"${CIRCLE_BRANCH}" | grep ServiceEndpoint | cut -d ' ' -f 2)
cp features/environment-dist.py features/environment.py
sed 's?{YOUR_DOMAIN_NAME_NO_TRAILING_SLASH}?\"'"$ENDPOINT"'\"?' features/environment-dist.py > features/environment.py

# Run BDD tests on the stack
set +e
yarn test:behave
BEHAVE_SUCESS=$?
set -e

# Teardown stack
yarn teardown --stackName 'circle-'"${CIRCLE_BUILD_NUM}"'-'"${CIRCLE_BRANCH}"

exit $BEHAVE_SUCESS
