script="$0"
basename="$(dirname $script)"
cd $basename
ls -latr

DEPLOYMENT_NAME=$DEPLOYMENT_NAME
kubectl get deployment $DEPLOYMENT_NAME -o name > /dev/null 2>&1 > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "Upgrading deployment"
    #This is to force update deployment as I am changing docker image labels
    kubectl patch deployment $DEPLOYMENT_NAME -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
else
    echo "Creating K8s Objects with image $1"
    sed -i "s/#LOGGERIMAGE#/$1/g" k8s.yml
    cat k8s.yml
    kubectl apply -f k8s.yml
fi
kubectl get all

