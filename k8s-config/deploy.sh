script="$0"
basename="$(dirname $script)"
cd $basename
ls -latr

kubectl get ingress app-ingress -o name > /dev/null 2>&1
if [ $? -ne 0 ]
then
    #Generating CSR and Keys
    echo "Generating Key, CSR, Cert for SSL. And creating secret.yml"
    openssl genrsa -out demo.key 2048
    openssl req -new -key demo.key -out demo.csr -subj "/CN=demo.com"
    openssl x509 -req -days 365 -in demo.csr -signkey demo.key -out demo.crt
    kubectl create secret tls appsecret --cert demo.crt --key demo.key --dry-run=client -o yaml > secret.yml
else 
    echo "Ingress available. Skipping Key, CSR, Cert generation"
fi

kubectl get deployment demoapp-deployment -o name > /dev/null 2>&1 > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "Upgrading deployment"
    #This is to force update deployment as I am changing docker image labels
    kubectl patch deployment demoapp-deployment -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
else
    echo "Creating K8s Objects"
    kubectl apply -f app-deploy.yml
    kubectl apply -f app-cip-service.yml
    kubectl apply -f app-deploy-default-backend.yml
    kubectl apply -f app-cip-service-db.yml
    kubectl apply -f secret.yml
    kubectl apply -f ingress-service.yml
fi
kubectl wait --namespace default --for=condition=ready pod --selector=app=demoapp,app=demoappdb --timeout=120s
kubectl get all 
kubectl get ingress

