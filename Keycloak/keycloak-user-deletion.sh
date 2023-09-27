#!/bin/bash

# Parameters
HOSTNAME=$1
KEYCLOAK_USER_REALM=$2
KEYCLOAK_PASSWORD=$3
USER_EMAIL=$4

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

# Searchin user
kcuserid=`/opt/keycloak/bin/kcadm.sh get users --server $KEYCLOAK_URL --realm $KEYCLOAK_USER_REALM --token $ACCESS_TOKEN -q email=$USER_EMAIL | grep id | awk '{print $3}' | awk -F'"' '{print $2}'`

if [ $? -eq 0 ]; then
    echo "User successfully loaded"
else
    echo "User is not created at Keycloak"
    exit 1
fi

# Deleting user
/opt/keycloak/bin/kcadm.sh delete users/$kcuserid --realm $KEYCLOAK_USER_REALM --server $KEYCLOAK_URL --token $ACCESS_TOKEN

if [ $? -eq 0 ]; then
    echo "User successfully deleted"
else
    echo "User has not been deleted"
    exit 1
fi
