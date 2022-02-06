D:

cd D:\Programing\Git\Micro_Services-Security\Microservices_Security_Practice_09_Istio\deploy\2.Ingress Gateway

echo ## Generates a private key for the certificate authority
openssl genrsa -passout pass:"authoritypassword" -out gateway-keys/ca_key.pem 2048

echo ## Generates a public key for the certificate authority
openssl  req -new -passin pass:"authoritypassword" -key gateway-keys/ca_key.pem -x509 -days 3650 -out gateway-keys/ca_cert.pem -subj "/CN=ecomm.com" 

echo ##Generates a private key for the Ingress
openssl genrsa -passout pass:"ingresspassword" -out gateway-keys/app_key.pem 2048

echo ##Generates certificate signing request (CSR) for the Ingress 
openssl req -passin pass:"ingresspassword" -new -key gateway-keys/app_key.pem -out gateway-keys/csr-for-app -subj "/CN=sts.ecomm.com" 

echo ##Generates Ingress certificate, which is signed by the CA	
openssl x509 -req -passin pass:"authoritypassword" -days 3650 -in gateway-keys/csr-for-app -CA gateway-keys/ca_cert.pem -CAkey gateway-keys/ca_key.pem -set_serial 01 -out gateway-keys/app_cert.pem 

kubectl delete secret  ecomm-credential -n istio-system

kubectl create secret tls ecomm-credential --key=gateway-keys\app_key.pem --cert=gateway-keys/app_cert.pem -n istio-system

del /S /F /Q gateway-keys\*

pause