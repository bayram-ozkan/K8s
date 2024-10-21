# Kubernetes (K8s)

Kubernetes (K8s), containerlaştırılmış uygulamaları otomatik olarak dağıtmak (deploy), ölçeklendirmek (scale) ve yönetmek için kullanılan bir **Infrastructure as Code (IaC)** açık kaynaklı bir container orchestrator aracıdır. Google tarafından geliştirilen bu sistem, container yönetimini ve orkestrasyonunu basitleştirir ve çeşitli bulut ortamlarında veya yerel sunucularda çalışabilir. Ana bileşenleri şunlardır:

---

## Cluster

Kubernetes platformunun temel yapı taşıdır ve birden fazla fiziksel veya sanal makineden oluşur.

---

### Node

Kubernetes cluster'ındaki temel bileşenlerden biridir. Cluster içinde çalışan bir veya birden fazla pod'un bulunduğu fiziksel veya sanal makinedir. Master ve worker node olarak ikiye ayrılır.

#### Master Node

Master node, Kubernetes cluster'ını yöneten node'dur ve yönetim görevlerini üstlenir. İçinde birçok bileşen barındırır.

##### Control Plane

Kubernetes cluster'ının merkezi yönetim birimidir. Cluster’ın genel durumu buradan yönetilir.

###### API Server
Tüm yönetim ve kontrol işlemleri API Server üzerinden gerçekleştirilir. Kullanıcılar veya araçlar API Server’a doğrudan erişebilir ve Kubernetes nesnelerini oluşturabilir, güncelleyebilir veya silebilir.

###### etcd
Kubernetes'in tutarlı ve dağıtılmış bir **key-value store** olarak kullanılan veritabanıdır. Cluster'ın durum bilgilerini saklar.

###### Controller Manager
Cluster'daki kaynakların belirlenen durumda kalmasını sağlar. Kaynakları izler ve gerektiğinde yeniden başlatma veya ölçeklendirme işlemleri yapar.

###### Scheduler
Yeni oluşturulan pod'ların hangi node'da çalışacağını belirler. Cluster içindeki kaynakların verimli kullanımını sağlar.

---

#### Worker Node

Uygulamaların çalıştığı, Kubernetes objelerinin gerçekten barındığı node'lardır. Worker node şu bileşenleri içerir:

##### Kubelet
Her worker node'da bulunan temel bileşendir. Pod'ların çalıştırılmasından sorumludur. Pod'un sağlık durumunu ve kaynak kullanımını takip eder ve durumu Control Plane'e rapor eder.

##### Kube-proxy
Kubernetes'deki ağ trafiğini yönetir. Cluster servisleri için bağlantı yönlendirme ve yük dengeleme işlemlerini gerçekleştirir. Kube-proxy, farklı modlarda çalışabilir:

- **Userspace**: Eski ve daha az verimli bir yöntemdir. Bağlantı yönlendirme işlemleri kullanıcı alanında gerçekleşir.
- **iptables**: Daha verimli bir yöntemdir. Ağ kuralları iptables kullanılarak uygulanır.
- **ipvs** (varsayılan, destekleniyorsa): IP Virtual Server (ipvs) kullanılarak yapılan yük dengeleme, yüksek performans ve daha fazla özelleştirme seçeneği sunar.

##### Container Runtime
Containerları çalıştıran bileşendir. Kubernetes, CRI (Container Runtime Interface) uyumlu bir runtime kullanır. Örnek container runtimelar şunlardır:

- Containerd
- CRI-O
- Rkt
- Kata Containers (eski adıyla Clear Containers ve Hyper)
- Virtlet

---

Bu dokümantasyon, Kubernetes'in temel bileşenlerini ve işleyişini anlamaya yönelik bir rehberdir. Daha detaylı bilgi için Kubernetes'in [resmi dokümantasyonunu](https://kubernetes.io/docs/home/) inceleyebilirsiniz.
