#!/usr/bin/env bash

if [[ -z "${TMP_DIR}" ]]; then
  TMP_DIR="./.tmp"
fi
mkdir -p "${TMP_DIR}"

CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)
INGRESS="$1"
SLSNAMESPACE="$2"
SLSSTOR="$3"
MONGONAMESPACE="$4"
SVC="$5"

if [[ "$6" == "destroy" ]]; then
    echo "remove license service..."
    kubectl delete LicenseService sls -n ${SLSNAMESPACE}
else 
    echo "adding license service..."

    PODLIST=$(kubectl get pods --selector=app=mas-mongo-ce-svc -o=json -n mongo -o=jsonpath={.items..metadata.name})
    PODLIST=($PODLIST)
    PORT=$(kubectl get svc mas-mongo-ce-svc -n mongo -o=jsonpath='{.spec.ports[?(@.name=="mongodb")].port}')

cat > "${TMP_DIR}/license_sls.yaml" << EOL
apiVersion: sls.ibm.com/v1
kind: LicenseService
metadata:
  name: sls
  namespace: ${SLSNAMESPACE}
spec:
  license:
    accept: true
  domain: ${INGRESS}
#  ca:
#    secretName: ca-keypair
  mongo:
    configDb: admin
    nodes:
$(for podname in "${PODLIST[@]}"; do echo "      - host: "$podname.$SVC.$MONGONAMESPACE.svc$'\n        port: '$PORT; done)
    secretName: sls-mongo-credentials
    authMechanism: DEFAULT
    retryWrites: true
    certificates:
    - alias: mongoca
      crt: |
$(kubectl get ConfigMap mas-mongo-ce-cert-map -n ${MONGONAMESPACE} -o jsonpath='{.data.ca\.crt}' | awk '{printf "        %s\n", $0}')
  rlks:
    storage:
      class: ${SLSSTOR}
      size: 20G
EOL

    kubectl create -f  "${TMP_DIR}/license_sls.yaml" -n ${SLSNAMESPACE}
fi

#wait for deployment
sleep 5m

SLSKEY=$(kubectl get LicenseService sls -n ${SLSNAMESPACE} --output="jsonpath={..registrationKey}")
echo ${SLSKEY} > ${TMP_DIR}/sls-key
