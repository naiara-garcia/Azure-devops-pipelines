#!/bin/bash   

TOKEN=$1
REPO=$2
BRANCH=$3
REVIEWERS=$4

BRANCHTARGET="feature/$BRANCH"
BRANCHSOURCE="refs/heads/main"
PROJECT="ecl-ado-prj-iac"
ORGURL="https://dev.azure.com/ecl-ado-factory"
URIBRANCHSTATUS="$ORGURL/$PROJECT/_apis/git/repositories/$REPO/stats/branches?name=$BRANCHTARGET"
URICHECKACTIVEPR="$ORGURL/$PROJECT/_apis/git/repositories/$REPO/pullrequests?searchCriteria.targetRefName=$BRANCHTARGET&searchCriteria.sourceRefName=$BRANCHSOURCE"

echo "Create needed variables for the PR at $REPO repository"
STATUS=`curl -u :$TOKEN $URIBRANCHSTATUS | jq -r .aheadCount`
ACTIVEPR=`curl -u :$TOKEN $URICHECKACTIVEPR | jq -r .count`

echo "Install Azure Devops extension"
az config set extension.use_dynamic_install=yes_without_prompt
az extension add --name azure-devops

echo "Login to az devops to allow PR creation"
echo $TOKEN | az devops login

echo "Check that the branch has changes from main and also that the PR is not created previously before creating the new PR at $REPO repository"
if [[ $STATUS == '0' ]]
then
  echo "Current branch contains last changes from main in $REPO repository"
else
  if [[ $ACTIVEPR > '0' ]]
  then
    echo "PR exists already at $REPO repository"
  else
    az repos pr create -r $REPO -s $BRANCHTARGET -p $PROJECT --org $ORGURL --delete-source-branch true --description "## What does this PR do?" "This PR is to add/remove users indicated at ticket $BRANCH" "" "## Why is it necessary?" "Because the users need this access to perform his daily job." "" "## Pull request type" "- [ ] Bugfix" "- [ ] New feature" "- [X] IaC change" "- [ ] Add new alert" "- [ ] Alert modification" "" "## Related ticket" "$BRANCH" "" "Close or affect [this](https://jira.eurocontrol.int/browse/$BRANCH) ticket." "" "## CI Output" "" "N/A" "" "## Checks" "" "- [ ] The PR has a descriptive title" "- [ ] The changes section has been checked" "- [ ] A person has been assigned to this PR" "- [ ] Clear comments `<-- -->` from sections" --reviewer $REVIEWERS --title "Performed the actions requested at ticket $BRANCH"   
    echo "Checking the terraform code using tf pipeline"
    sleep 420
  fi
fi      

echo "Logout from Azure account"
az logout