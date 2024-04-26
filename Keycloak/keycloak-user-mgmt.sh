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
    dplt_pipeline)
        #Adding user to dplt_pipeline groups

        #Keycloak group ID -> Keycloak group name
        #19163472-53f9-4c54-89cd-54073b7dded0 -> dpro_jenkins_readonly
        #7f1efdb1-dbc1-413a-8c20-f82034273cef -> dplt_jenkins_readonly
        #f8612ce9-af5e-4ee5-a509-4f7b3573d8f2 -> nx-readonly
        groups_id='19163472-53f9-4c54-89cd-54073b7dded0 7f1efdb1-dbc1-413a-8c20-f82034273cef f8612ce9-af5e-4ee5-a509-4f7b3573d8f2'

        echo $groups_id

        IFS=$' '
        groups=($groups_id)

        for (( i=0; i<${#groups[@]}; i++ )); do
            /opt/keycloak/bin/kcadm.sh update users/$kcuserid/groups/${groups[$i]} -r $KEYCLOAK_USER_REALM -s realm=$KEYCLOAK_USER_REALM -s userId=$kcuserid -s groupId=${groups[$i]} -n --server $KEYCLOAK_URL --token $ACCESS_TOKEN
        done
        echo "User successfully added to dplt_pipeline groups"
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
    infra_admin)
        #Adding user to infra_admin groups

        #Keycloak group ID -> Keycloak group name
        #e9d185ea-f0a3-4229-8483-b4f281d4b5c5 -> dplt_jenkins_administrators
        #f41ec15a-095c-417d-a33e-e044d18a05e7 -> dpro_jenkins_administrators
        #013a8512-b75b-4c54-b5ec-bfc4de4d1708 -> nx-admin
        #ad0e465b-72c4-4336-8e1e-45fac25863f9 -> sonar-administrators
        groups_id='e9d185ea-f0a3-4229-8483-b4f281d4b5c5 f41ec15a-095c-417d-a33e-e044d18a05e7 013a8512-b75b-4c54-b5ec-bfc4de4d1708 ad0e465b-72c4-4336-8e1e-45fac25863f9'

        echo $groups_id

        IFS=$' '
        groups=($groups_id)

        for (( i=0; i<${#groups[@]}; i++ )); do
            /opt/keycloak/bin/kcadm.sh update users/$kcuserid/groups/${groups[$i]} -r $KEYCLOAK_USER_REALM -s realm=$KEYCLOAK_USER_REALM -s userId=$kcuserid -s groupId=${groups[$i]} -n --server $KEYCLOAK_URL --token $ACCESS_TOKEN
        done
        echo "User successfully added to infra_admin groups"
    ;;
    dpro_dplt_developer)
        #Adding user to avitech_slovakia groups

        #Keycloak group ID -> Keycloak group name
        #d3e9bc67-b197-4f54-874c-32667d63eff3 -> dpro_jenkins_developers
        #cb0359b0-5b79-4614-8e3d-bed79fea224d -> dplt_jenkins_developers
        #f8612ce9-af5e-4ee5-a509-4f7b3573d8f2 -> nx-readonly
        groups_id='d3e9bc67-b197-4f54-874c-32667d63eff3 cb0359b0-5b79-4614-8e3d-bed79fea224d f8612ce9-af5e-4ee5-a509-4f7b3573d8f2'

        echo $groups_id

        IFS=$' '
        groups=($groups_id)

        for (( i=0; i<${#groups[@]}; i++ )); do
            /opt/keycloak/bin/kcadm.sh update users/$kcuserid/groups/${groups[$i]} -r $KEYCLOAK_USER_REALM -s realm=$KEYCLOAK_USER_REALM -s userId=$kcuserid -s groupId=${groups[$i]} -n --server $KEYCLOAK_URL --token $ACCESS_TOKEN
        done
        echo "User successfully added to avitech_slovakia groups"
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
