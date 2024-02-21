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
        groups_id='7050adbd-d402-41a1-92da-884e9e2e569e'

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
        groups_id='5be0dbc0-6ace-49c4-89dc-1a2ddfad186e 6a49503e-3757-4bc1-bae8-ac9d0cfa0036 c8119fa8-0a0d-405d-9e2e-16630ad9d3b8'

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
        groups_id='0b637195-305b-434c-9672-e26831846487 c8119fa8-0a0d-405d-9e2e-16630ad9d3b8'

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
        groups_id='887b69df-b9a3-4543-818c-bd06458e3322 357526b3-7ff8-4e2d-8b83-aa3b31c92909 caf82e4a-c8fe-49c9-8ecb-461135326aca 9cb95afe-44f3-4484-bedd-4ad4868e27f6'

        echo $groups_id

        IFS=$' '
        groups=($groups_id)

        for (( i=0; i<${#groups[@]}; i++ )); do
            /opt/keycloak/bin/kcadm.sh update users/$kcuserid/groups/${groups[$i]} -r $KEYCLOAK_USER_REALM -s realm=$KEYCLOAK_USER_REALM -s userId=$kcuserid -s groupId=${groups[$i]} -n --server $KEYCLOAK_URL --token $ACCESS_TOKEN
        done
        echo "User successfully added to infra_admin groups"
    ;;
    avitech_slovakia)
        #Adding user to avitech_slovakia groups
        groups_id='7050adbd-d402-41a1-92da-884e9e2e569e c8119fa8-0a0d-405d-9e2e-16630ad9d3b8'

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
