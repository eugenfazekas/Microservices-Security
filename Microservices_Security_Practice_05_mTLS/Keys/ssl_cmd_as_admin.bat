d:

cd D:\Programing\Git\Micro_Services-Security\Microservices_Security_Practice_05_mTLS\keys


echo ######################## CERTIFICATE AUTHORITY ########################

echo ## Generates a private key for the certificate authority
openssl genrsa -aes256 -passout pass:"authoritypassword" -out export/ca/ca_key.pem 2048

echo ## Generates a public key for the certificate authority
openssl  req -new -passin pass:"authoritypassword" -key export/ca/ca_key.pem -x509 -days 3650 -out export/ca/ca_cert.pem -subj "/CN=localhost"










echo ######################## OrderProcessing Service ########################

echo ##Generates a private key for the OrderProcessing Service
openssl genrsa -aes256 -passout pass:"orderProcessingservicepassword" -out export/orderprocessing_service/app_key.pem 2048

echo ##Generates certificate signing request (CSR) for the OrderProcessing Service 
openssl req -passin pass:"orderProcessingservicepassword" -new -key export/orderprocessing_service/app_key.pem -out export/orderprocessing_service/csr-for-app -subj "/CN=localhost"  

echo ##Generates OrderProcessing Service certificate, which is signed by the CA	
openssl x509 -req -passin pass:"authoritypassword" -days 3650 -in export/orderprocessing_service/csr-for-app -CA export/ca/ca_cert.pem -CAkey export/ca/ca_key.pem -set_serial 01 -out export/orderprocessing_service/app_cert.pem 

echo ##Creates a Java keystore with OrderProcessing Service private/public keys
openssl rsa -passin pass:"orderProcessingservicepassword" -in export/orderprocessing_service/app_key.pem -out export/orderprocessing_service/app_key.pem

openssl pkcs12 -export -inkey export/orderprocessing_service/app_key.pem -in export/orderprocessing_service/app_cert.pem -out export/orderprocessing_service/app.p12 -password pass:orderProcessingservicepassword

keytool -importkeystore -srcstorepass orderProcessingservicepassword -srckeystore export/orderprocessing_service/app.p12 -srcstoretype pkcs12 -deststorepass orderProcessingservicepassword -destkeystore export/orderprocessing_service/orderprocessing_service.jks -deststoretype JKS

keytool -changealias -alias "1" -destalias "orderprocessing_service" -keystore export/orderprocessing_service/orderprocessing_service.jks -storepass orderProcessingservicepassword










echo ######################## Inventory Service ########################

echo ##Generates a private key for the Inventory Service
openssl genrsa -aes256 -passout pass:"inventoryservicepassword" -out export/inventory_service/app_key.pem 2048

echo ##Generates certificate signing request (CSR) for the Inventory Service 
openssl req -passin pass:"inventoryservicepassword" -new -key export/inventory_service/app_key.pem -out export/inventory_service/csr-for-app -subj "/CN=localhost"  

echo ##Generates Inventory Service certificate, which is signed by the CA	
openssl x509 -req -passin pass:"authoritypassword" -days 3650 -in export/inventory_service/csr-for-app -CA export/ca/ca_cert.pem -CAkey export/ca/ca_key.pem -set_serial 01 -out export/inventory_service/app_cert.pem 

echo ##Creates a Java keystore with Inventory Service private/public keys
openssl rsa -passin pass:"inventoryservicepassword" -in export/inventory_service/app_key.pem -out export/inventory_service/app_key.pem

openssl pkcs12 -export -inkey export/inventory_service/app_key.pem -in export/inventory_service/app_cert.pem -out export/inventory_service/app.p12 -password pass:inventoryservicepassword

keytool -importkeystore -srcstorepass inventoryservicepassword -srckeystore export/inventory_service/app.p12 -srcstoretype pkcs12 -deststorepass inventoryservicepassword -destkeystore export/inventory_service/inventory_service.jks -deststoretype JKS

keytool -changealias -alias "1" -destalias "inventory_service" -keystore export/inventory_service/inventory_service.jks -storepass inventoryservicepassword




echo #### Importing certificates to OrderProcessing Service Keystore

keytool -import -file export/inventory_service/app_cert.pem -alias inventory_service -noprompt   -keystore export/orderprocessing_service/orderprocessing_service.jks -storepass orderProcessingservicepassword




echo #### Importing certificates to Inventory Service Keystore

keytool -import -file export/orderprocessing_service/app_cert.pem -alias orderprocessing_service -noprompt  -keystore export/inventory_service/inventory_service.jks -storepass inventoryservicepassword


echo #### Deleting certificates to Inventory Service Keystore
keytool -delete -alias cat -storepass  changeit -keystore "C:/Program Files/Java/jdk-11.0.11/lib/security/cacerts" 

echo #### Adding to truststore

keytool -import -file export/ca/ca_cert.pem  -alias cat -storepass  changeit -keystore   "C:/Program Files/Java/jdk-11.0.11/lib/security/cacerts" 


copy  "C:\Program Files\Java\jdk-11.0.11\lib\security\cacerts" "D:\Programing\Git\Micro_Services-Security\Microservices_Security_Practice_05_mTLS\Practice_05_OrderProcessing_Service\"

copy  "C:\Program Files\Java\jdk-11.0.11\lib\security\cacerts" "D:/Programing/Git/Micro_Services-Security/Microservices_Security_Practice_05_mTLS/Practice_05_Inventory_Service/"

copy  "export\orderprocessing_service\orderprocessing_service.jks" "D:\Programing\Git\Micro_Services-Security\Microservices_Security_Practice_05_mTLS\Practice_05_OrderProcessing_Service\"

copy  "export\inventory_service\inventory_service.jks" "D:\Programing\Git\Micro_Services-Security\Microservices_Security_Practice_05_mTLS\Practice_05_Inventory_Service\"

pause





