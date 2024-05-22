#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: add-user-keycloak.sh <username> <password>"
    exit 1
fi

USERNAME=$1
PASSWORD=$2

/opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user $USERNAME --password $PASSWORD
/opt/jboss/keycloak/bin/kcadm.sh create users -r master -s username=$USERNAME -s enabled=true -s emailVerified=true -s "email=$USERNAME@example.com" -s "firstName=$USERNAME" -s "lastName=LastName" -s "credentials=[{\"type\":\"password\",\"value\":\"$PASSWORD\",\"temporary\":false}]"