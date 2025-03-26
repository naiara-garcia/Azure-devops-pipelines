#!/bin/bash

# Parameters
HOSTNAME=$1
KEYCLOAK_USER_REALM=$2
KEYCLOAK_PASSWORD=$3
USER_EMAIL=$4
OPTION=$5

# Keycloak parameters
KEYCLOAK_URL=https://$HOSTNAME/auth
KEYCLOAK_REALM=master
KEYCLOAK_CLIENT=admin-cli
KEYCLOAK_USER=admin

#Login to keycloak
ACCESS_TOKEN=`curl -s $KEYCLOAK_URL/realms/$KEYCLOAK_REALM/protocol/openid-connect/token \
    -d client_id=$KEYCLOAK_CLIENT \
    -d grant_type=password \
    -d username=$KEYCLOAK_USER \
    -d password=$KEYCLOAK_PASSWORD \
    | cut -d',' -f1 | cut -d':' -f2 | awk -F'"' '{print $2}'`

# Searching user
kcuserid=`/opt/keycloak/bin/kcadm.sh get users --server $KEYCLOAK_URL --token $ACCESS_TOKEN -r $KEYCLOAK_USER_REALM -q email=$USER_EMAIL | grep id | awk '{print $3}' | awk -F'"' '{print $2}'`
echo "User successfully loaded"
echo $kcuserid

case $OPTION in
    dpro_developer)
        #Adding user to dpro_developer groups

        #Keycloak group ID -> Keycloak group name
        #d3e9bc67-b197-4f54-874c-32667d63eff3 -> dpro_jenkins_developers
        #f8612ce9-af5e-4ee5-a509-4f7b3573d8f2 -> nx-readonly
        groups_id='d3e9bc67-b197-4f54-874c-32667d63eff3 f8612ce9-af5e-4ee5-a509-4f7b3573d8f2'

        echo $groups_id

        IFS=$' '
        groups=($groups_id)

        for (( i=0; i<${#groups[@]}; i++ )); do
            /opt/keycloak/bin/kcadm.sh update users/$kcuserid/groups/${groups[$i]} -r $KEYCLOAK_USER_REALM -s realm=$KEYCLOAK_USER_REALM -s userId=$kcuserid -s groupId=${groups[$i]} -n --server $KEYCLOAK_URL --token $ACCESS_TOKEN
        done
        echo "User successfully added to dpro_developer groups"
    ;;
    dplt_developer)
        #Adding user to dplt_developer groups

        #Keycloak group ID -> Keycloak group name
        #cb0359b0-5b79-4614-8e3d-bed79fea224d -> dplt_jenkins_developers
        #f8612ce9-af5e-4ee5-a509-4f7b3573d8f2 -> nx-readonly
        groups_id='cb0359b0-5b79-4614-8e3d-bed79fea224d f8612ce9-af5e-4ee5-a509-4f7b3573d8f2'

        echo $groups_id

        IFS=$' '
        groups=($groups_id)

        for (( i=0; i<${#groups[@]}; i++ )); do
            /opt/keycloak/bin/kcadm.sh update users/$kcuserid/groups/${groups[$i]} -r $KEYCLOAK_USER_REALM -s realm=$KEYCLOAK_USER_REALM -s userId=$kcuserid -s groupId=${groups[$i]} -n --server $KEYCLOAK_URL --token $ACCESS_TOKEN
        done
        echo "User successfully added to dplt_developer groups"
    ;;
    remove_user)
        #Removing user from groups
        groups_id=`/opt/keycloak/bin/kcadm.sh get users/$kcuserid/groups -r $KEYCLOAK_USER_REALM --server $KEYCLOAK_URL --token $ACCESS_TOKEN | grep id | awk '{print $3}' | awk -F'"' '{print $2}'`

        echo $groups_id

        IFS=$'\n'
        groups=($groups_id)

        for (( i=0; i<${#groups[@]}; i++ )); do
            /opt/keycloak/bin/kcadm.sh delete users/$kcuserid/groups/${groups[$i]} -r $KEYCLOAK_USER_REALM --server $KEYCLOAK_URL --token $ACCESS_TOKEN
        done
        echo "User sucessfully removed from groups"
    ;;
    *)
        echo "Bad option"
    ;;
esac
