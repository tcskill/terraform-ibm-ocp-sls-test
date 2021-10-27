#!/usr/bin/env bash


CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)
INGRESS="$1"
SLSNAMESPACE="$2"
SLSSTOR="$3"

if [[ "$4" == "destroy" ]]; then
    echo "remove license service..."
    kubectl delete LicenseService sls -n ${SLSNAMESPACE}
else 
    echo "adding license service..."
    CACERT=$(kubectl get ConfigMap mas-mongo-ce-cert-map -n mongo -o jsonpath='{.data.ca\.crt}' | awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}')
    #CACERT=awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' ${CACERT}
    echo "cacert: ${CACERT}"
    echo "ingress sub: ${INGRESS}"

cat > "${CHARTS_DIR}/license_sls.yaml" << EOL
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
      - host: mas-mongo-ce-0.mas-mongo-ce-svc.mongo.svc
        port: 27017
      - host: mas-mongo-ce-1.mas-mongo-ce-svc.mongo.svc
        port: 27017
      - host: mas-mongo-ce-2.mas-mongo-ce-svc.mongo.svc
        port: 27017
    secretName: sls-mongo-credentials
    authMechanism: DEFAULT
    retryWrites: true
    certificates:
    - alias: mongoca
      crt: |-8
        ${CACERT}
  rlks:
    storage:
      class: ${SLSSTOR}
      size: 20G
EOL

    kubectl create -f  "${CHARTS_DIR}/license_sls.yaml" -n ${SLSNAMESPACE}
fi

#wait for deployment
#sleep 1m

