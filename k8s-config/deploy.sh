script="$0"
basename="$(dirname $script)"
cd $basename
ls -latr

#Generating CSR and Keys
openssl genrsa -out demo.key 2048
openssl req -new -key demo.key -out demo.csr -subj "/CN=demo.com"
openssl x509 -req -days 365 -in demo.csr -signkey demo.key -out demo.crt

kubectl create secret tls appsecret --cert demo.crt --key demo.key --dry-run=client -o yaml > secret.yml

kubectl apply -f .