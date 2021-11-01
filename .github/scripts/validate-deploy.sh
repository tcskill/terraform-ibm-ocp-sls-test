#!/usr/bin/env bash

KUBECONFIG=$(cat ./kubeconfig)
NAMESPACE=$(cat ./sls_namespace)

#wait for the deployments to finish
sleep 5m

kubectl rollout status deployment/ibm-sls-controller-manager -n ${NAMESPACE}
if [[ $? -ne 0 ]]; then
    echo "deployment failed with exit code $? in namespace ${NAMESPACE}"
    exit 1
fi
