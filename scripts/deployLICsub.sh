#!/usr/bin/env bash


CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)
SLSNAMESPACE="$1"


if [[ "$2" == "destroy" ]]; then
    echo "remove license subscription service..."
    kubectl delete ClusterServiceVersion ibm-sls.v3.2.3 -n ${SLSNAMESPACE}
    kubectl delete CustomResourceDefinition licenseservices.sls.ibm.com
    kubectl delete CustomResourceDefinition licenseclients.sls.ibm.com
else 
    echo "adding license subscription service..."
cat > "${CHARTS_DIR}/license_sub.yaml" << EOL
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ibm-sls
  namespace: ${SLSNAMESPACE}
spec:
  channel: 3.x
  installPlanApproval: Automatic
  name: ibm-sls
  source: ibm-operator-catalog
  sourceNamespace: openshift-marketplace
EOL
    kubectl apply -f  "${CHARTS_DIR}/license_sub.yaml" -n ${SLSNAMESPACE} --validate=false
fi

#wait for deployment
sleep 4m

