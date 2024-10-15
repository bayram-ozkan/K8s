
#########################################################################################################################
# 1.adım
openssl genrsa -out developer.key 2048



#########################################################################################################################
# 2.adım
openssl req -new -key developer.key  -out developer.csr -subj "/CN=developer1@mail.com/O=DevTeam"



#########################################################################################################################
# 3.adım
---------------------------------------------------------------------------------------------------------------
## 1.yol
***


# developer.csr dosyasını base64 ile kodlayın:



# cat developer.csr | base64 | tr -d '\n'
# LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ2RUQ0NBVjBDQVFBd01ERWNNQm9HQTFVRUF3d1RaR1YyWld4dmNHVnlNVUJ0WVdsc0xtTnZiVEVRTUE0RwpBMVVFQ2d3SFJHVjJWR1ZoYlRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS3JtCkNwMjFwcjZHVU5xaEFKbnY1b1BjdzBXdFdYY0x2clUrdGlaYVJucjFoL2dyazVpcTc2VStvZnZjaDJaMExVRkQKSHlwbGxJVk82cHZsU0Q2UTlyTWxqb0swckM0M3JHT3lrT0U1SXEzYlhDV0ZIaFA2OFVwM2RsWFllSCtDNGxlagplYTRSSmYxeDI5aGVpblhueWdHdGk4VU9zU05tQVhPQUVMa0lPdHZLK2laTmVUdEVPZTUyUUV1T3pHNlVIOFpxCmtza3QzM01DQi9icXlKR3puaGlLSG94TjhiVjRJUUViTTUwV3NhSUFHdUgrc1JwZHE5bnl3b2c0Nzl6QTlOcXUKRnNQLytVWEJVNkw2WU1WK1FRaFdWVjh2OUJFQ2NIMkx4N2xISGFDMFIybms2dEZRN1dWd2p5dlBwcmN3VVdISgpNNzFSbGpoK09WeE5hZHI3NXA4Q0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQkN3VUFBNElCQVFCL04rdlJGa0xsCjNaZGx2WVNYMzdzN05rRm4zQmdjdElJUTMvWHMyVU1XWEs1MzZZc1lLTy9pQlpLRUVva21kQ1BmK0xRa2dWaUcKYVdPNkRuRXRVNVJiNm54ZU5jb2dhQ2c2eXhNSlZDbnVHSVBkaTlvL0w3Z0NJZlVLb2VwU2xuWHl5OG96UzNQcApQcGFDUHRCaDh6V29RWW1KMHJwbnM3aVV6amZ3QkRKTE13T3IzMmVyRkVtaWI2OHJYMDRhZlhHM296QXRLR3VICjVhOEZEcFlZVEJtZUU3eEp2bzkramgrcnl4bStBR3dUVjdGTUhCcUhLWlJIY0RqbnVUMW1lT3QxUnRNb0ZiN24KT08yV1VOdmdCSkZBRHV4RDBweFRBMEFCOENWMWw1RXVQTDRzVTQ1d05IWDJ1VU9lSzM3YlcyMU9mV2tGbXRsdwpsUXJpT3JxQzRsMlUKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==



# Çıktıyı kopyalayın ve user-crt.yml dosyasındaki request alanına yapıştırın. Ve yaml dosyası oluşturun 

# certificate oluşturalım
kubectl apply -f user-crt.yml 
#   certificatesigningrequest.certificates.k8s.io/testuser created



# listeyelim
kubectl get csr
#   NAME        AGE     SIGNERNAME                                    REQUESTOR              REQUESTEDDURATION   CONDITION
#   csr-hjkts   28m     kubernetes.io/kube-apiserver-client-kubelet   system:node:minikube   <none>              Approved,Issued
#   testuser    8m49s   kubernetes.io/kube-apiserver-client           minikube-user          <none>              Pending




--------------------------------------------------------------
## 2.yol


# certificate oluşturalım

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: testuser
spec:
  groups:
  - system:authenticated
  request: $(cat developer.csr | base64 | tr -d "\n")
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF


    # certificatesigningrequest.certificates.k8s.io/testuser created



# listeyelim
kubectl get csr
#   NAME        AGE     SIGNERNAME                                    REQUESTOR              REQUESTEDDURATION   CONDITION
#   csr-hjkts   28m     kubernetes.io/kube-apiserver-client-kubelet   system:node:minikube   <none>              Approved,Issued
#   testuser    8m49s   kubernetes.io/kube-apiserver-client           minikube-user          <none>              Pending





#########################################################################################################################
# 4.adım setfikayı imzalaylım

# sertifikayı onayladıktan sonra pending durumundan approved a geçicek
kubectl certificate approve testuser



kubectl get csr
#   NAME        AGE     SIGNERNAME                                    REQUESTOR              REQUESTEDDURATION   CONDITION
#   csr-hjkts   31m     kubernetes.io/kube-apiserver-client-kubelet   system:node:minikube   <none>              Approved,Issued
#   testuser    2m12s   kubernetes.io/kube-apiserver-client           minikube-user          <none>              Approved,Issued





#########################################################################################################################
# 5.adım 

# sertikayı yaml formatinda yazdırıyoruz lakin  certificate altında base64 de şifrelenmiş durumunda 

kubectl get csr testuser  -o yaml


kubectl get csr testuser -o jsonpath='{.status.certificate}'


kubectl get csr testuser -o jsonpath='{.status.certificate}'  |  base64 -d >> user-certificate.crt


#########################################################################################################################
#5.  kullanıcı set oluşturuldu



kubectl config set-credentials developer1@mail.com --client-certificate=user-certificate.crt --client-key=developer.key 
#  User "developer1@mail.com" set.


#########################################################################################################################
#6. minikube de yeni bir context oluştup bu context user ı birleştirdik

kubectl config set-contenxt  test-user --cluster=minikube --user=developer1@mail.com
# Context "test-user" created.




kubectl config use-context test-user 
# Switched to context "test-user".




kubectl get pods
# Error from server (Forbidden): pods is forbidden: User "developer1@mail.com" cannot list resource "pods" in API group "" in the namespace "default"
