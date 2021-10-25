#!/usr/bin/env bash


CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)
INGRESS="$2"

if [[ "$1" == "destroy" ]]; then
    echo "remove license service..."
    #kubectl delete -f  "${CHARTS_DIR}/catalog.yaml"
   
else 
    echo "adding license service..."
    cacrt=$(kubectl get ConfigMap mas-mongo-ce-cert-map -n mongo -o jsonpath='{.data.ca\.crt}')
    echo "ingress sub: ${INGRESS}"

    #kubectl apply -f  "${CHARTS_DIR}/catalog.yaml"
fi

#wait for deployment
#sleep 1m

