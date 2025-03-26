#!/bin/bash

TOKEN=$1
REPO=$2
BRANCH=$3

BRANCHTARGET="feature/$BRANCH"
PROJECT="<project>"
ORGURL="https://dev.azure.com/<organization>"

echo "Login to az devops to allow PR approvation and merged"
echo $TOKEN | az devops login --organization $ORGURL

echo "Get the PR ID to perform the merge action"
PRID=`az repos pr list --org $ORGURL -p $PROJECT -r $REPO -s $BRANCHTARGET | grep codeReviewId | awk '{print $2}' | cut -d',' -f1`

if [[ -z "$PRID" ]]
then
  echo "PR does not exist"
  exit 1
else
  echo "Approve the PR created"
  az repos pr set-vote --org $ORGURL --id $PRID --vote approve
fi

echo "Logout from Azure account"
az logout