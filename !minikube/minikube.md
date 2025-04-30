# 🐳 Minikube Komutları ve Kullanım Rehberi

Bu rehber, **Minikube** ile Kubernetes ortamını yerel olarak yönetmek isteyen kullanıcılar için temel komutları ve açıklamalarını içermektedir.


## 🚀 Başlangıç

### Minikube Başlatma

```
minikube start
```

 * Varsayılan ayarlarla tek node lu bir Kubernetes kümesi başlatır.

```
minikube start --driver=docker
```
 * Docker kullanarak küme başlatır. Sanallaştırma desteği gerektirmez.



```
minikube start --driver=virtualbox
```

 * VirtualBox kullanarak küme başlatır. BIOS ta sanallaştırma desteği (VMX/SVM) açık olmalıdır.


####  🧪 Sanallaştırma Kontrolü (Virtualization)

```
 egrep -c  '(vmx|svm)' /proc/cpuinfo
```

 * Çıktı 0 ise sanallaştırma kapalıdır ve VirtualBox gibi sürücüler çalışmaz. Docker önerilir.

```
minikube config set driver docker
```

 * Dockerı varsayılan sürücü olarak ayarlar.  minikube start komutunda tekrar belirtmeye gerek kalmaz.


## 👥 Çok Node lu Cluster

```
minikube start --nodes=3
```

 * 1 control plane + 2 worker node içeren toplam 3 node lu  bir küme başlatır.


```
minikube node add
```

 * Var olan kümeye yeni bir worker node ekler.

```
minikube node delete <node-adı>
```

 * Belirtilen node u kümeden siler.  

```
minikube node delete minikube-m02
```


```
minikube node list
```

 * Mevcut node ları listeler.


## 🧹 Küme Temizleme

```
minikube delete
```

 * Tüm Minikube kümesini ve ilişkili kaynakları siler.



## 🔌 Addons (Eklenti) Yönetimi

```
minikube addons list
```
 * Tüm mevcut eklentileri ve durumlarını listeler.


```
minikube addons enable ingress
```


 * Ingress Controller ı etkinleştirir (dışarıdan HTTP yönlendirme için kullanılır).


## 🌐 Servis Erişimi

```
minikube service <servis-adı>
```

 * Belirtilen servisi varsayılan tarayıcıda açar.

```
minikube service --url <servis-adı>
```

 * Servisin URL ini verir.


```
minikube service --url frontend
```


```
minikube tunnel
```

 * LoadBalancer tipindeki servislerin harici IP ile erişilmesini sağlar. Terminal açık kalmalıdır.

---





---

> ✍️ Bu rehber, yerel Kubernetes geliştirme süreçlerinde Minikube kullanımını kolaylaştırmak için hazırlanmıştır.
