echo ##### CERTIFICATE AUTHORITY #####

echo ## Generates a private key for the certificate authority
openssl genrsa -aes256 -passout pass:"authoritypassword" -out export/ca/ca_key.pem 2048

echo ## Generates a public key for the certificate authority
openssl  req -new -passin pass:"authoritypassword" -key export/ca/ca_key.pem -x509 -days 3650 -out export/ca/ca_cert.pem -subj "/CN=localhost"

keytool -import -storepass authoritypassword -noprompt -file export/ca/ca_cert.pem -alias ca -keystore export/ca/truststore.jks

echo ##### Kafka #####

echo ##Generates a private key for the Kafka
openssl genrsa -aes256 -passout pass:"kafkaserverpassword" -out export/kafka_server/app_key.pem 2048

echo ##Generates certificate signing request (CSR) for the Kafka 
openssl req -passin pass:"kafkaserverpassword" -new -key export/kafka_server/app_key.pem -out export/kafka_server/csr-for-app -subj "/CN=localhost"  

echo ##Generates Kafka certificate, which is signed by the CA	
openssl x509 -req -passin pass:"authoritypassword" -days 3650 -in export/kafka_server/csr-for-app -CA export/ca/ca_cert.pem -CAkey export/ca/ca_key.pem -set_serial 01 -out export/kafka_server/app_cert.pem

echo ##Creates a Java keystore with Kafka private/public keys
openssl rsa -passin pass:"kafkaserverpassword" -in export/kafka_server/app_key.pem -out export/kafka_server/app_key.pem

openssl pkcs12 -export -inkey export/kafka_server/app_key.pem -in export/kafka_server/app_cert.pem -out export/kafka_server/app.p12 -password pass:kafkaserverpassword

keytool -importkeystore -srcstorepass kafkaserverpassword -srckeystore export/kafka_server/app.p12 -srcstoretype pkcs12 -deststorepass kafkaserverpassword -destkeystore export/kafka_server/kafka_server.jks -deststoretype JKS

keytool -changealias -alias "1" -destalias "kafka_server" -keystore export/kafka_server/kafka_server.jks -storepass kafkaserverpassword

keytool -import -file export/ca/ca_cert.pem -alias ca -noprompt  -keystore export/kafka_server/kafka_server.jks -storepass kafkaserverpassword



echo ##### Order Processing #####

echo ##Generates a private key for the Order Processing
openssl genrsa -aes256 -passout pass:"orderprocessingpassword" -out export/order_processing/app_key.pem 2048

echo ##Generates certificate signing request (CSR) for the Order Processing 
openssl req -passin pass:"orderprocessingpassword" -new -key export/order_processing/app_key.pem -out export/order_processing/csr-for-app -subj "/CN=localhost"  

echo ##Generates Order Processing certificate, which is signed by the CA	
openssl x509 -req -passin pass:"authoritypassword" -days 3650 -in export/order_processing/csr-for-app -CA export/ca/ca_cert.pem -CAkey export/ca/ca_key.pem -set_serial 01 -out export/order_processing/app_cert.pem

echo ##Creates a Java keystore with Order Processing private/public keys
openssl rsa -passin pass:"orderprocessingpassword" -in export/order_processing/app_key.pem -out export/order_processing/app_key.pem

openssl pkcs12 -export -inkey export/order_processing/app_key.pem -in export/order_processing/app_cert.pem -out export/order_processing/app.p12 -password pass:orderprocessingpassword

keytool -importkeystore -srcstorepass orderprocessingpassword -srckeystore export/order_processing/app.p12 -srcstoretype pkcs12 -deststorepass orderprocessingpassword -destkeystore export/order_processing/order_processing.jks -deststoretype JKS

keytool -changealias -alias "1" -destalias "order_processing" -keystore export/order_processing/order_processing.jks -storepass orderprocessingpassword

keytool -import -file export/ca/ca_cert.pem -alias ca -noprompt  -keystore export/order_processing/order_processing.jks -storepass orderprocessingpassword



echo ##### Buying History #####

echo ##Generates a private key for the Buying History
openssl genrsa -aes256 -passout pass:"buyinghistorypassword" -out export/buying_history/app_key.pem 2048

echo ##Generates certificate signing request (CSR) for the Buying History 
openssl req -passin pass:"buyinghistorypassword" -new -key export/buying_history/app_key.pem -out export/buying_history/csr-for-app -subj "/CN=localhost"  

echo ##Generates Buying History certificate, which is signed by the CA	
openssl x509 -req -passin pass:"authoritypassword" -days 3650 -in export/buying_history/csr-for-app -CA export/ca/ca_cert.pem -CAkey export/ca/ca_key.pem -set_serial 01 -out export/buying_history/app_cert.pem

echo ##Creates a Java keystore with Buying History private/public keys
openssl rsa -passin pass:"buyinghistorypassword" -in export/buying_history/app_key.pem -out export/buying_history/app_key.pem

openssl pkcs12 -export -inkey export/buying_history/app_key.pem -in export/buying_history/app_cert.pem -out export/buying_history/app.p12 -password pass:buyinghistorypassword

keytool -importkeystore -srcstorepass buyinghistorypassword -srckeystore export/buying_history/app.p12 -srcstoretype pkcs12 -deststorepass buyinghistorypassword -destkeystore export/buying_history/buying_history.jks -deststoretype JKS

keytool -changealias -alias "1" -destalias "buying_history" -keystore export/buying_history/buying_history.jks -storepass buyinghistorypassword

keytool -import -file export/ca/ca_cert.pem -alias ca -noprompt  -keystore export/buying_history/buying_history.jks -storepass buyinghistorypassword

pause

