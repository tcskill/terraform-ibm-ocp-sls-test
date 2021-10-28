#!/usr/bin/env bash


CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)

if [[ "$1" == "destroy" ]]; then
    echo "remove catalog..."
    kubectl delete -f  "${CHARTS_DIR}/catalog.yaml"
    #kubectl delete ClusterServiceVersion service-binding-operator.v0.8.0 -n openshift-operators
   
else 
    echo "adding catalog..."
    kubectl apply -f  "${CHARTS_DIR}/catalog.yaml"
fi

#wait for deploy or destroy to complete
sleep 1m
