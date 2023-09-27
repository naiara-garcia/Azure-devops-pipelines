#!/bin/bash

# Parameters
HOSTNAME=$1
KEYCLOAK_USER_REALM=$2 #KEYCLOAK_USER_REALM=factory-dev
KEYCLOAK_PASSWORD=$3
USER_EMAIL=$4
USER_FISTNAME=$5
USER_LASTNAME=$6
USER_AD_ID=$7

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

#Check that the user is not created previously
kcuserid=`/opt/keycloak/bin/kcadm.sh get users --server $KEYCLOAK_URL --realm $KEYCLOAK_USER_REALM --token $ACCESS_TOKEN -q email=$USER_EMAIL | grep id | awk '{print $3}' | awk -F'"' '{print $2}'`
if [[ -z "$kcuserid" ]]; then
    # Creating user
    echo "Creating user"
    /opt/keycloak/bin/kcadm.sh create users --server $KEYCLOAK_URL -s email=$USER_EMAIL -s username=$USER_EMAIL -s firstName=$USER_FISTNAME -s lastName=$USER_LASTNAME -s enabled=true --realm $KEYCLOAK_USER_REALM --token $ACCESS_TOKEN

    #Linking with Azure AD
    echo "Linking with Azure AD"
    /opt/keycloak/bin/kcadm.sh create $KEYCLOAK_URL/admin/realms/$KEYCLOAK_USER_REALM/users/$kcuserid/federated-identity/microsoft \
    --server $KEYCLOAK_URL --realm $KEYCLOAK_USER_REALM --token $ACCESS_TOKEN \
    -s userId=$USER_AD_ID -s userName=$USER_EMAIL

    if [ $? -eq 0 ]; then
        echo "User created"
    else
        echo "User has not been created"
        exit 1
    fi
else
    echo "User was created previously and it has the following Keycloak userID: $kcuserid"
fi
