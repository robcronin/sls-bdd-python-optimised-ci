#!/bin/bash

set -e
STACK_NAME=$(curl -X GET ${BDD_LOCK_ENDPOINT}/get-available/sls-bdd | python get-stack.py)
if [ "$STACK_NAME" == "NO STACKS" ]
then
    RAND=$(openssl rand -base64 12)
    STACK_NAME="circle-$RAND"
    curl -X POST https://wxc3te4blc.execute-api.eu-west-2.amazonaws.com/dev/create-stack \
        -d "{
            \"stackName\": \"${STACK_NAME}\",
            \"repoName\": \"sls-bdd\",
            \"isAvailable\": false
        }"
else
    CLAIM=$(curl -X PUT ${BDD_LOCK_ENDPOINT}/claim-stack/${STACK_NAME} | python check-claim.py)
    if [ "$CLAIM" == "KO" ]
    then
        echo "Stack already claimed - bad luck"
        exit 1
    fi
fi


yarn deploy --stackName $STACK_NAME
export ENDPOINT=$(yarn sls info --verbose --stackName $STACK_NAME | grep ServiceEndpoint | cut -d ' ' -f 2)
cp features/environment-dist.py features/environment.py
sed 's?{YOUR_DOMAIN_NAME_NO_TRAILING_SLASH}?\"'"$ENDPOINT"'\"?' features/environment-dist.py > features/environment.py

set +e
yarn test:behave
BEHAVE_SUCESS=$?
set -e

curl -X PUT "${BDD_LOCK_ENDPOINT}/release-stack/${STACK_NAME}"

exit $BEHAVE_SUCESS