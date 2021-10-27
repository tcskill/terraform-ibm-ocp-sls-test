#!/usr/bin/env bash


CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)
SLSNAMESPACE="$1"


if [[ "$2" == "destroy" ]]; then
    echo "remove license csv..."
    kubectl delete ClusterServiceVersion ibm-sls.v3.2.3 -n ${SLSNAMESPACE}
else 
    echo "adding license csv..."
cat > "${CHARTS_DIR}/license_csv.yaml" << EOL
apiVersion: operators.coreos.com/v1alpha1
kind: ClusterServiceVersion
metadata:
  annotations:
    olm.skipRange: '>=3.2.0 <3.2.3'
    operators.operatorframework.io/builder: operator-sdk-v1.4.0+git
    operators.operatorframework.io/project_layout: ansible.sdk.operatorframework.io/v1
    olm.targetNamespaces: ${SLSNAMESPACE}
    operatorframework.io/properties: >-
      {"properties":[{"type":"olm.gvk","value":{"group":"sls.ibm.com","kind":"LicenseClient","version":"v1"}},{"type":"olm.gvk","value":{"group":"sls.ibm.com","kind":"LicenseService","version":"v1"}},{"type":"olm.package","value":{"packageName":"ibm-sls","version":"3.2.3"}}]}
    alm-examples: |-
      [
        {
          "apiVersion": "sls.ibm.com/v1",
          "kind": "LicenseService",
          "metadata": {
            "labels": {
              "app.kubernetes.io/instance": "ibm-sls",
              "app.kubernetes.io/managed-by": "olm",
              "app.kubernetes.io/name": "ibm-sls"
            },
            "name": "sls"
          },
          "spec": {
            "license": {
              "accept": true
            },
            "mongo": {
              "configDb": "admin",
              "nodes": [
                {
                  "host": "host1.domain.com",
                  "port": 30257
                }
              ],
              "secretName": "sls-mongo-credentials"
            },
            "rlks": {
              "storage": {
                "class": "ibmc-block-bronze",
                "size": "5G"
              }
            }
          }
        }
      ]
    capabilities: Full Lifecycle
    olm.operatorNamespace: ${SLSNAMESPACE}
    containerImage: >-
      icr.io/cpopen/ibm-sls@sha256:cc2910a7f55ce7d1efc4b141bbebcfc304b0d365a2c58a989bd27026689e6713
    operators.operatorframework.io/internal-objects: '["licenseclients.sls.ibm.com"]'
    operatorframework.io/suggested-namespace: ibm-sls
    description: >-
      Provides an API for a licensing system with RLKS as the backend
      technology.
    olm.operatorGroup: ibm-sls-operator-group
  selfLink: >-
    /apis/operators.coreos.com/v1alpha1/namespaces/ibm-sls/clusterserviceversions/ibm-sls.v3.2.3
  resourceVersion: '19570515'
  name: ibm-sls.v3.2.3
  uid: 81ac4691-f306-4f24-b2c7-cb5f4ec6c49f
  creationTimestamp: '2021-10-26T21:30:47Z'
  generation: 1
  managedFields:
    - apiVersion: operators.coreos.com/v1alpha1
      fieldsType: FieldsV1
      fieldsV1:
        'f:metadata':
          'f:annotations':
            'f:operators.operatorframework.io/internal-objects': {}
            'f:alm-examples': {}
            'f:description': {}
            'f:capabilities': {}
            'f:olm.skipRange': {}
            .: {}
            'f:containerImage': {}
            'f:operatorframework.io/suggested-namespace': {}
            'f:operators.operatorframework.io/project_layout': {}
            'f:operatorframework.io/properties': {}
            'f:operators.operatorframework.io/builder': {}
          'f:labels':
            .: {}
            'f:operatorframework.io/arch.amd64': {}
            'f:operatorframework.io/os.linux': {}
        'f:spec':
          'f:version': {}
          'f:maturity': {}
          'f:provider':
            .: {}
            'f:name': {}
            'f:url': {}
          'f:links': {}
          'f:install':
            .: {}
            'f:spec':
              .: {}
              'f:deployments': {}
            'f:strategy': {}
          'f:maintainers': {}
          'f:description': {}
          'f:installModes': {}
          'f:icon': {}
          'f:customresourcedefinitions':
            .: {}
            'f:owned': {}
            'f:required': {}
          .: {}
          'f:apiservicedefinitions': {}
          'f:replaces': {}
          'f:displayName': {}
          'f:keywords': {}
      manager: catalog
      operation: Update
      time: '2021-10-26T21:30:47Z'
    - apiVersion: operators.coreos.com/v1alpha1
      fieldsType: FieldsV1
      fieldsV1:
        'f:metadata':
          'f:annotations':
            'f:olm.operatorGroup': {}
            'f:olm.operatorNamespace': {}
            'f:olm.targetNamespaces': {}
          'f:labels':
            'f:olm.api.6883dd134213d19a': {}
            'f:olm.api.6acf921c81d23d3': {}
            'f:olm.api.eb398ce8dfd60b37': {}
            'f:operators.coreos.com/ibm-sls.ibm-sls': {}
        'f:status':
          .: {}
          'f:conditions': {}
          'f:lastTransitionTime': {}
          'f:lastUpdateTime': {}
          'f:message': {}
          'f:phase': {}
          'f:reason': {}
          'f:requirementStatus': {}
      manager: olm
      operation: Update
      time: '2021-10-26T21:32:39Z'
  namespace: ${SLSNAMESPACE}
  labels:
    olm.api.6883dd134213d19a: required
    olm.api.6acf921c81d23d3: provided
    olm.api.eb398ce8dfd60b37: provided
    operatorframework.io/arch.amd64: supported
    operatorframework.io/os.linux: supported
    operators.coreos.com/ibm-sls.ibm-sls: ''
spec:
  customresourcedefinitions:
    owned:
      - kind: LicenseClient
        name: licenseclients.sls.ibm.com
        version: v1
      - description: Represents the Suite License Service installation
        displayName: License Service
        kind: LicenseService
        name: licenseservices.sls.ibm.com
        resources:
          - kind: ConfigMap
            name: ''
            version: v1
          - kind: Deployment
            name: ''
            version: v1
          - kind: PersistentVolumeClaim
            name: ''
            version: v1
          - kind: Secret
            name: ''
            version: v1
          - kind: Service
            name: ''
            version: v1
          - kind: ServiceAccount
            name: ''
            version: v1
          - kind: Role
            name: ''
            version: rbac.authorization.k8s.io/v1
          - kind: RoleBinding
            name: ''
            version: rbac.authorization.k8s.io/v1
        specDescriptors:
          - description: >-
              Select to accept SLS license terms. License available at
              https://ibm.biz/SLS31-License
            displayName: Accept License
            path: license.accept
            value:
              - false
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:booleanSwitch'
          - description: >-
              Declares the top level domain that will be used for SLS. SLS will
              be exposed through a route if this is set at
              {name}.{namespace}.{domain}
            displayName: Domain
            path: domain
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:text'
          - description: RLKS Licensing Key Server
            displayName: RLKS Details
            path: rlks
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:fieldGroup:RLKS Configuration'
              - 'urn:alm:descriptor:com.tectonic.ui:object'
          - description: >-
              The name of the storage class to use for RLKS persistence. Must
              allow non-root users read and write capabilities.
            displayName: Storage Class
            path: rlks.storage.class
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:fieldGroup:RLKS Configuration'
              - 'urn:alm:descriptor:com.tectonic.ui:text'
          - description: >-
              The size of the PersistentVolumeClaim against the storage class
              provided
            displayName: Storage Size
            path: rlks.storage.size
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDB
                Configuration
              - 'urn:alm:descriptor:com.tectonic.ui:text'
          - description: MongoDB Details
            displayName: MongoDB Details
            path: mongo
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDB
                Configuration
              - 'urn:alm:descriptor:com.tectonic.ui:object'
          - description: To configure multiple nodes use the YAML editor
            displayName: Hostname
            path: 'mongo.nodes[0].host'
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDb
                Configuration
              - 'urn:alm:descriptor:com.tectonic.ui:text'
          - description: To configure multiple nodes use the YAML editor
            displayName: Port Number
            path: 'mongo.nodes[0].port'
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDb
                Configuration
              - 'urn:alm:descriptor:com.tectonic.ui:number'
          - description: ConfigDb to use for authentication
            displayName: ConfigDb
            path: mongo.configDb
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDb
                Configuration
              - 'urn:alm:descriptor:com.tectonic.ui:text'
          - description: Authentication mechanism to use for authentication
            displayName: Authentication Mechanism
            path: mongo.authMechanism
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDb
                Configuration
              - 'urn:alm:descriptor:com.tectonic.ui:select:DEFAULT'
              - 'urn:alm:descriptor:com.tectonic.ui:select:PLAIN'
          - description: Configurable retryable writes for mongo
            displayName: Retryable Writes
            path: mongo.retryWrites
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDb
                Configuration
              - 'urn:alm:descriptor:com.tectonic.ui:booleanSwitch'
          - description: Secret holding the MongoDb username and password
            displayName: Credentials Secret
            path: mongo.secretName
            x-descriptors:
              - >-
                urn:alm:descriptor:com.tectonic.ui:fieldGroup:MongoDb
                Configuration
              - 'urn:alm:descriptor:io.kubernetes:Secret'
          - description: License Terms
            displayName: License Terms
            path: license
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:object'
          - description: >-
              Select to accept SLS license terms. License available at
              https://ibm.biz/MAS84-License
            displayName: Accept License
            path: license.accept
            value:
              - false
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:booleanSwitch'
          - description: CA
            displayName: CA
            path: ca
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:fieldGroup:CA'
              - 'urn:alm:descriptor:com.tectonic.ui:advanced'
              - 'urn:alm:descriptor:com.tectonic.ui:object'
          - description: Settings
            displayName: Settings
            path: settings
            x-descriptors:
              - 'urn:alm:descriptor:com.tectonic.ui:fieldGroup:Settings'
              - 'urn:alm:descriptor:com.tectonic.ui:advanced'
              - 'urn:alm:descriptor:com.tectonic.ui:object'
        statusDescriptors:
          - description: SLS API URL
            displayName: SLS API URL
            path: url
            x-descriptors:
              - 'urn:alm:descriptor:org.w3:link'
          - description: SLS CA Certificate
            displayName: SLS CA Certificate
            path: ca.secretName
            x-descriptors:
              - 'urn:alm:descriptor:io.kubernetes:Secret'
          - description: >-
              SLS Registration Key. Used to authorize applications to register
              clients with SLS.
            displayName: SLS Registration Key
            path: registrationKey
            x-descriptors:
              - 'urn:alm:descriptor:text'
          - description: >-
              Suite Registration Info. Contains required properties to configure
              SLS for a suite.
            displayName: Suite Registration Info
            path: registrationInfo.cmName
            x-descriptors:
              - 'urn:alm:descriptor:io.kubernetes:ConfigMap'
          - description: SLS License ID. Maps to host ID value in License Key Center.
            displayName: SLS License ID
            path: licenseId
            x-descriptors:
              - 'urn:alm:descriptor:text'
          - description: SLS deployment conditions
            displayName: Deployment Conditions
            path: conditions
            x-descriptors:
              - 'urn:alm:descriptor:io.kubernetes.conditions'
        version: v1
    required:
      - description: Truststore desc via dep
        displayName: Truststore displayName via dep
        kind: Truststore
        name: truststores.truststore-mgr.ibm.com
        version: v1
  apiservicedefinitions: {}
  keywords:
    - ibm
    - sls
  displayName: IBM Suite License Service
  provider:
    name: IBM
    url: 'https://ibm.com'
  maturity: stable
  installModes:
    - supported: true
      type: OwnNamespace
    - supported: true
      type: SingleNamespace
    - supported: false
      type: MultiNamespace
    - supported: false
      type: AllNamespaces
  version: 3.2.3
  icon:
    - base64data: >-
        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
      mediatype: image/png
  links:
    - name: IBM
      url: 'https://ibm.com'
  install:
    spec:
      deployments:
        - name: ibm-sls-controller-manager
          spec:
            replicas: 1
            selector:
              matchLabels:
                app.kubernetes.io/instance: ibm-sls
                app.kubernetes.io/managed-by: olm
                app.kubernetes.io/name: ibm-sls
                control-plane: controller-manager
            strategy: {}
            template:
              metadata:
                annotations:
                  productId: c863fcafa34e460299d0b7a2174074a3
                  productMetric: FREE
                  productName: IBM Suite License Service
                creationTimestamp: null
                labels:
                  app.kubernetes.io/instance: ibm-sls
                  app.kubernetes.io/managed-by: olm
                  app.kubernetes.io/name: ibm-sls
                  control-plane: controller-manager
              spec:
                containers:
                  - env:
                      - name: WATCH_NAMESPACE
                        valueFrom:
                          fieldRef:
                            fieldPath: 'metadata.annotations[''olm.targetNamespaces'']'
                    image: >-
                      icr.io/cpopen/ibm-sls@sha256:cc2910a7f55ce7d1efc4b141bbebcfc304b0d365a2c58a989bd27026689e6713
                    imagePullPolicy: Always
                    livenessProbe:
                      exec:
                        command:
                          - ansible
                          - '--version'
                      failureThreshold: 3
                      periodSeconds: 60
                      successThreshold: 1
                      timeoutSeconds: 30
                    name: manager
                    readinessProbe:
                      exec:
                        command:
                          - ansible
                          - '--version'
                      failureThreshold: 3
                      initialDelaySeconds: 10
                      periodSeconds: 60
                      successThreshold: 1
                      timeoutSeconds: 30
                    resources:
                      limits:
                        cpu: '2'
                        memory: 2096Mi
                      requests:
                        cpu: 500m
                        memory: 512Mi
                    volumeMounts:
                      - mountPath: /var/lib/image-map
                        name: image-map
                imagePullSecrets:
                  - name: ibm-entitlement
                serviceAccount: ibm-sls-operator
                terminationGracePeriodSeconds: 10
                volumes:
                  - configMap:
                      defaultMode: 420
                      name: ibm-sls-image-map
                      optional: true
                    name: image-map
    strategy: deployment
  maintainers:
    - email: parkerda@uk.ibm.com
      name: David Parker
  description: >-
    # Introduction


    IBM Suite License Service (SLS) is a token-based licensing system based on
    Rational License Key Server (RLKS) with MongoDB as the data store.


    Capabilities:


    - License Mgmt APIs. Provides license management capabilities.

    - Token Pool APIs. Provides basic reporting stats on token usage.

    - Entitlement APIs. Provides the ability to configure and upload
    entitlements to the licensing system.

    - Reportings APIs. Provides historical reports on token usage, license
    usage, and auditing events.

    - Configuration APIs. Provides the ability to dynamically enforce or ignore
    compliance.

    - Registration APIs. Provides client registration capabilities.

    - Client Management APIs. Provides client management capabilities.


    # Details


    ## Prerequisites


    - Compute architecture required: 64-bit Intel/AMD x86

    - Supported cloud type: rhocp4 Red Hat OpenShift Container Platform 4

    - A MongoDB cluster that is accessible from the OpenShift cluster using TLS

    - An IBM Entitled Registry key


    ### Install cert-manager


    The version of cert-manager available from OperatorHub is out of date, you
    need to install cert-manager 1.1.0 (or newer)


    ```bash

    oc create namespace cert-manager

    oc apply -f
    https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.yaml

    ```


    For more information, refer to the [installation
    instructions](https://cert-manager.io/docs/installation/openshift/#installing-with-regular-manifests)


    ### Configure entitlement


    Create your namespace, for example, `ibm-sls` and create a Docker secret
    that is named `ibm-entitlement` containing your entitlement key for the IBM
    Entitled Registry:


    ```bash

    ER_KEY=<your-er-key>

    oc new-project ibm-sls

    oc -n ibm-sls create secret docker-registry ibm-entitlement \
      --docker-server=cp.icr.io \
      --docker-username=cp \
      --docker-password=$ER_KEY \
    ```


    ### Configure MongoDB credentials


    Create a secret in the namespace where you plan to deploy SLS that contains
    the MongoDB credentials:


    ```yaml

    apiVersion: v1

    kind: Secret

    type: Opaque

    metadata:
      name: sls-mongo-credentials
      namespace: ibm-sls
    stringData:
      username: '<username>'
      password: '<password>'
    ```


    ## Configuration


    ### License


    SLS requires acceptance of the license terms. If the license isn’t accepted,
    SLS is not deployed. Set the license accept flag in the LicenseService CR.


    ### Storage


    SLS requires a PVC to store the license file. Set the storage class and size
    of the PVC in the LicenseService CR.


    #### Requirements


    There are no specific performance requirements for the storage class and it
    requires only minimal capacity (less than 1 Gb).


    View a list of available storage classes in your cluster by executing the
    following command: `oc get storageclasses`. Choose the cheapest or lowest
    quality of service storage class available in your cluster, and set the size
    to the lowest value supported by the storage class.


    If you are using NFS backed storage, ensure that the storage class is rw
    accessible for non-root users. For example, in IBM Cloud use
    `ibmc-file-bronze-gid` instead of `ibmc-file-bronze`.


    #### Storage on IBM Cloud


    Due to the minimal requirements most storage classes are supported, but the
    following IBM Cloud storage classes have been tested with:


    - ibmc-file-bronze-gid

    - ibmc-block-bronze


    #### Encryption


    To protect your data, use storage with passive encryption enabled. No active
    encryption is performed by the licensing systems that use the persistent
    volume.


    ### MongoDB


    SLS requires MongoDB as a data store. Set the MongoDB hosts, credentials
    secret name, authentication mechanism, and authentication database in the
    LicenseService CR.


    ### Domain


    SLS can be configured to be externally accessible through a route by setting
    the domain property in the LicenseService CR. Set the domain if SLS is used
    by application suites that are installed in separate OpenShift clusters.


    ### CA


    SLS can be configured to use a provided CA keypair for generating
    certificates by adding the CA keypair to a secret in the SLS namespace and
    setting the CA keypair secret name in the LicenseService CR. SLS generates
    its own root CA if a CA keypair is not provided.


    ## Installing


    Complete the following LicenseService CR template based on the configuration
    steps.


    Bare Minimum:


    ```yaml

    apiVersion: sls.ibm.com/v1

    kind: LicenseService

    metadata:
      name: sls
      namespace: ibm-sls
    spec:
      license:
        accept: true
      mongo:
        configDb: admin
        nodes:
        - host: host1.domain.com
          port: 27017
        secretName: sls-mongo-credentials
      rlks:
        storage:
          class: ibmc-file-bronze-gid
          size: 5G
    ```


    All Filled:


    ```yaml

    apiVersion: sls.ibm.com/v1

    kind: LicenseService

    metadata:
      name: sls
      namespace: ibm-sls
    spec:
      license:
        accept: true
      domain: domain.com
      ca:
        secretName: ca-keypair
      mongo:
        configDb: admin
        nodes:
        - host: host1.domain.com
          port: 27017
        secretName: sls-mongo-credentials
        authMechanism: DEFAULT
        retryWrites: true
        certificates:
        - alias: mongoca
          crt: |-
            -----BEGIN CERTIFICATE-----
            ...
            -----END CERTIFICATE-----
      rlks:
        storage:
          class: ibmc-file-bronze-gid
          size: 5G
    ```


    Apply the LicenseService CR to deploy SLS.


    The SLS deployment can take up to 10 minutes. The SLS deployment is finished
    when it reports that it is `Ready`:


    ```sh

    kubectl get -n ibm-sls licenseservice sls


    NAME   RECONCILING   READY   INITIALIZED   LICENSEID      REGISTRATIONKEY

    sls    True          True    True          0242ac110002  
    44415453574841434b4a554c4553

    ```


    ## Application Suite Configuration


    Application suites such as Maximo Application Suite (MAS) configure the SLS
    integration by completing a registration process with SLS.


    The registration process adds the application suite to the SLS client
    registry and provisions an X.509 certificate for the application suite to
    use SLS APIs (SLS requires mutualTLS).


    The registration process requires an SLS API URL, an SLS registration key,
    and an SLS CA certificate. All properties can be found in the SLS status and
    in the Suite Registration CM:


    ```sh

    kubectl get -n ibm-sls cm sls-suite-registration -o yaml


    kind: ConfigMap

    apiVersion: v1

    metadata:
      name: sls-suite-registration
      namespace: ibm-sls
    data:
      url: <your-sls-api-url>
      registrationKey: <your-registration-key>
      ca: <your-sls-ca>
    ```


    ## Verification


    Save the SLS client key, cert, and CA (SLS requires mutualTLS):


    ```sh

    oc get secret -n ibm-sls sls-cert-client -o jsonpath='{.data.tls\.key}' |
    base64 -d -w 0 > tls.key

    oc get secret -n ibm-sls sls-cert-client -o jsonpath='{.data.tls\.crt}' |
    base64 -d -w 0 > tls.crt

    oc get secret -n ibm-sls sls-cert-client -o jsonpath='{.data.ca\.crt}' |
    base64 -d -w 0 > ca.crt

    ```


    Set up port forwarding to expose the internal API outside of the cluster:


    ```sh

    oc port-forward service/sls 7000:443

    ```


    ### Verify that the API is running


    ```sh

    curl -ik --cert tls.crt --key tls.key --cacert ca.crt
    https://localhost:7000/api/entitlement/config

    HTTP/2 200

    x-powered-by: Servlet/4.0

    content-type: application/json

    date: Mon, 19 Apr 2021 21:29:38 GMT

    content-language: en-GB


    {'rlks':{'configuration':'single','hosts':[{'id':'0242ac110002','hostname':'sls-rlks-0.rlks','port':27000}]}}

    ```


    ### Upload an entitlement File


    ```sh

    curl -ik --cert tls.crt --key tls.key --cacert ca.crt -X PUT -F
    'file=@entitlement.lic' https://localhost:7000/api/entitlement/file

    HTTP/1.1 100 Continue

    Content-Length: 0

    Date: Mon, 12 Oct 2020 08:56:59 GMT


    HTTP/1.1 200 OK

    Date: Mon, 12 Oct 2020 08:57:18 GMT

    X-Powered-By: Servlet/4.0

    Content-Length: 0

    Content-Language: en-GB

    ```


    ### Check token pool


    ```sh

    curl -ik --cert tls.crt --key tls.key --cacert ca.crt
    https://localhost:7000/api/tokens

    HTTP/1.1 200 OK

    X-Powered-By: Servlet/4.0

    Content-Type: application/json

    Date: Mon, 12 Oct 2020 09:02:02 GMT

    Content-Language: en-GB

    Transfer-Encoding: chunked


    [{'tokenId':'AppPoints','entitled':100,'used':0,'concurrent':0,'reserved':0,'expirationDate':'2023-08-30T00:00:00Z','available':100,'issuedDate':'2020-04-22T00:00:00Z'}]

    ```


    ## Resources Required


    Minimum scheduling capacity:


    | Software  | Memory (GB) | CPU (cores) | Disk (GB) | Nodes |

    | --------- | ----------- | ----------- | --------- | ----- |

    | **Total** |   0.6       |  900m       |  1        | 1     |


    ## Upgrades


    SLS supports in-place upgrades for patch and minor upgrades. It is
    recommended to complete the backup procedure before upgrading.


    Refer to the official Red Hat [documentation for upgrading operators
    installed using Operator Lifecycle
    Manager](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.6/html/operators/administrator-tasks#olm-upgrading-operators).


    ## Rollback


    SLS does not support downgrades as it is not supported by the Operator
    Lifecycle Manager. To rollback, reinstall SLS using the backup and restore
    procedure or contact IBM support for a potential hotfix.


    ## Backup


    ### Backup process:


    1. Back up a snapshot of the mongo database (all collections)


    2. Save the SLS CA keypair secret


    3. Make a note of the `licenseId` and `registrationKey`:


    ```sh

    kubectl get licenseservice/sls


    NAME   RECONCILING   READY   INITIALIZED   LICENSEID      REGISTRATIONKEY

    sls    True          True    True          0242ac110002  
    44415453574841434b4a554c4553

    ```


    ### Restore process:


    1. Restore the mongo database snapshot (all collections)


    2. Restore the SLS CA keypair secret, set the `ca.secretName` value in the
    LicenseService CR


    3. Create a secret that is called `sls-bootstrap` with the `licenseId` and
    `registrationKey` set:


    ```yaml

    apiVersion: v1

    kind: Secret

    metadata:
      name: sls-bootstrap
    stringData:
      licensingId: 0242ac110002
      registrationKey: 44415453574841434b4a554c4553
    ```


    4. Reapply the LicenseService CR


    5. Reupload the license file


    6. Reregister application suites


    ## Limitations


    - The operator supports only single namespace deployment

    - Multiple instances of the operator can be deployed in a single cluster

    - Multiple installations of the LicenseServer Instance cannot be deployed in
    the same namespace


    ## SecurityContextConstraints Requirements

    The operator uses the Openshift default `restricted` SCC (Security Context
    Constraints).
  replaces: ibm-sls.v3.2.0
status:
  conditions:
    - lastTransitionTime: '2021-10-26T21:30:47Z'
      lastUpdateTime: '2021-10-26T21:30:47Z'
      message: requirements not yet checked
      phase: Pending
      reason: RequirementsUnknown
    - lastTransitionTime: '2021-10-26T21:30:47Z'
      lastUpdateTime: '2021-10-26T21:30:47Z'
      message: one or more requirements couldn't be found
      phase: Pending
      reason: RequirementsNotMet
    - lastTransitionTime: '2021-10-26T21:30:47Z'
      lastUpdateTime: '2021-10-26T21:30:47Z'
      message: 'all requirements found, attempting install'
      phase: InstallReady
      reason: AllRequirementsMet
    - lastTransitionTime: '2021-10-26T21:30:48Z'
      lastUpdateTime: '2021-10-26T21:30:48Z'
      message: waiting for install components to report healthy
      phase: Installing
      reason: InstallSucceeded
    - lastTransitionTime: '2021-10-26T21:30:48Z'
      lastUpdateTime: '2021-10-26T21:30:48Z'
      message: >-
        installing: waiting for deployment ibm-sls-controller-manager to become
        ready: deployment "ibm-sls-controller-manager" not available: Deployment
        does not have minimum availability.
      phase: Installing
      reason: InstallWaiting
    - lastTransitionTime: '2021-10-26T21:32:39Z'
      lastUpdateTime: '2021-10-26T21:32:39Z'
      message: install strategy completed with no errors
      phase: Succeeded
      reason: InstallSucceeded
  lastTransitionTime: '2021-10-26T21:32:39Z'
  lastUpdateTime: '2021-10-26T21:32:39Z'
  message: install strategy completed with no errors
  phase: Succeeded
  reason: InstallSucceeded
  requirementStatus:
    - group: apiextensions.k8s.io
      kind: CustomResourceDefinition
      message: CRD is present and Established condition is true
      name: licenseclients.sls.ibm.com
      status: Present
      uuid: 9c5fc1e4-3b1e-4ac1-9656-a9406bc25900
      version: v1
    - group: apiextensions.k8s.io
      kind: CustomResourceDefinition
      message: CRD is present and Established condition is true
      name: licenseservices.sls.ibm.com
      status: Present
      uuid: eb728e7d-bcc3-4546-b205-73d3a9253b46
      version: v1
    - group: apiextensions.k8s.io
      kind: CustomResourceDefinition
      message: CRD is present and Established condition is true
      name: truststores.truststore-mgr.ibm.com
      status: Present
      uuid: 5535c8d3-1d94-4480-ae36-5c7123330e76
      version: v1
EOL
    kubectl create -f  "${CHARTS_DIR}/license_sls.yaml" -n ${SLSNAMESPACE}
fi

#wait for deployment
sleep 4m