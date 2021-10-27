#!/usr/bin/env bash


CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)
SLSNAMESPACE="$1"


if [[ "$2" == "destroy" ]]; then
    echo "remove license csv..."
    #kubectl delete ClusterServiceVersion ibm-sls.v3.2.3 -n ${SLSNAMESPACE}
else 
    echo "adding license csv..."
    #kubectl create -f  "${CHARTS_DIR}/slscsv.yaml" -n ${SLSNAMESPACE}
fi

#wait for deployment
sleep 4m
