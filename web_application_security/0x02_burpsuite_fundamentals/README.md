# 🛡️ Web Application Security – OWASP & Burp Suite Labs

Ce dépôt documente l’ensemble des **tasks 0 à 5** réalisées dans le cadre des projets **Web Application Security** et **Burp Suite Fundamentals** (Holberton School – Cyber Security).

Chaque task illustre une vulnérabilité ou une mauvaise pratique courante, avec une approche **offensive (pentest)** et une compréhension **défensive**.

---

## 🔹 Task 0 – Session Hijacking (Broken Access Control)

**Chemin** : `0x01_owasp_top_10/0-flag.txt`

### 🎯 Objectif

Exploiter une génération faible de cookies de session (`hijack_session`) afin de détourner une session valide.

### 🧠 Principe

* Le cookie contient :

  * un UUID fixe
  * un compteur incrémental
  * un timestamp
* À chaque nouvelle requête, le compteur s’incrémente
* Un compteur manquant correspond à une session valide d’un autre utilisateur

### 🛠️ Commande utilisée

```bash
for i in {1..10}; do
  curl -s -I http://web0x01.hbtn/a1/hijack_session/ | awk '/hijack_session/ {print $2}'
done
```

### ✅ Exploitation

* Identifier le compteur manquant
* Modifier manuellement le cookie `hijack_session`
* Se connecter avec des identifiants bidons
* Le flag apparaît après connexion

---

## 🔹 Task 1 – XOR Decoder (Cryptographic Failure)

**Chemin** : `0x01_owasp_top_10/1-xor_decoder.sh`

### 🎯 Objectif

Décoder un hash chiffré via **XOR + Base64** (WebSphere-like encoding).

### 🧠 Principe

* Retirer le préfixe `{xor}`
* Décoder en Base64
* XOR chaque octet avec la clé `0x5F`

### 🛠️ Script Bash

```bash
#!/bin/bash
python3 - <<EOF
import base64, sys
data = sys.argv[1].split('}',1)[1]
decoded = base64.b64decode(data)
print(''.join(chr(b ^ 95) for b in decoded))
EOF
```

---

## 🔹 Task 2 – Encoding Failure Login Bypass

**Chemin** : `0x01_owasp_top_10/2-flag.txt`

### 🎯 Objectif

Retrouver des identifiants de connexion via des **headers XHR**.

### 🧠 Principe

* Le header `Authorization: bearer` contient un token Base64
* Décodage → JSON avec `username` et `password_hash`
* Le `password_hash` est chiffré en XOR
* Utilisation du script de la task 1

### ✅ Résultat

Connexion réussie → accès au profil → récupération du flag

---

## 🔹 Task 3 – Stored XSS (Samy Worm Simulation)

**Chemin** : `0x01_owasp_top_10/3-flag.txt`

### 🎯 Objectif

Suivre automatiquement des profils pour déclencher un flag.

### 🧠 Principe

* Les IDs des profils sont visibles dans les réponses API
* Trois profils doivent être suivis
* Après les follows, un flag apparaît sur le profil utilisateur

### 🛠️ Endpoint utilisé

```http
GET /api/a3/xss_stored/profile
```

---

## 🔹 Task 4 – Discovering Vulnerable Input Field (Stored XSS)

**Chemin** : `0x01_owasp_top_10/4-vuln.txt`

### 🎯 Objectif

Identifier quel champ du profil est vulnérable au XSS stocké.

### 🧠 Principe

* Injection de `<script>alert('XSS')</script>` dans chaque champ
* Observation du DOM et du code source
* Le champ vulnérable est injecté sans échappement

### ✅ Résultat

Champ vulnérable identifié :

```text
bio
```

---

# 🔐 Burp Suite Fundamentals (0x02)

## 🔹 Task 0 – TLS Certificate Analysis

**Chemin** : `0x02_burpsuite_fundamentals/0-flag.txt`

### 🎯 Objectif

Trouver un flag caché dans le certificat TLS du serveur.

### 🧠 Principe

* Accès via Burp Suite
* Inspection du **Server TLS Certificate**
* Le flag est présent dans le champ **OU (Organizational Unit)**

---

## 🔹 Task 1 – Client TLS Authentication

**Chemin** : `0x02_burpsuite_fundamentals/1-flag.txt`

### 🎯 Objectif

Accéder à un contenu protégé par authentification TLS client.

### 🛠️ Étapes

* Télécharger le certificat `.p12`
* L’importer dans Burp Suite
* Mot de passe : `holberton`
* Recharger la page

### ✅ Résultat

Accès au contenu caché + flag

---

## 🔹 Task 2 – Response Tampering

**Chemin** : `0x02_burpsuite_fundamentals/2-flag.txt`

### 🎯 Objectif

Modifier une réponse serveur pour révéler un flag.

### 🧠 Principe

* Interception de la réponse `/task2`
* Modification du JSON ou du DOM
* Le frontend affiche alors le flag

---

## 🔹 Task 3 – Repeater Credential Guessing

**Chemin** : `0x02_burpsuite_fundamentals/3-flag.txt`

### 🎯 Objectif

Deviner des identifiants par défaut via Burp Repeater.

### 🧠 Principe

* Envoi de la requête de login au Repeater
* Test de credentials classiques (`admin/admin`)
* Ajustement des champs (role, remember)

---

## 🔹 Task 4 – Intruder ID Enumeration

**Chemin** : `0x02_burpsuite_fundamentals/4-flag.txt`

### 🎯 Objectif

Trouver un profil caché via brute-force d’ID.

### 🧠 Principe

* Intruder avec payload numérique
* Recherche d’un status `200`
* Le profil valide contient le flag dans la bio

---

## 🔹 Task 5 – Sequencer Session Analysis

**Chemin** : `0x02_burpsuite_fundamentals/5-flag.txt`

### 🎯 Objectif

Analyser la faiblesse d’un cookie de session via Burp Sequencer.

### 🧠 Principe

* Le cookie `hijack_session` contient un timestamp incrémental
* Un timestamp manquant correspond à une session valide
* Réutilisation du token manquant

### 🏁 Résultat

Accès à `/task5` → interaction → flag

---

## ✅ Conclusion

Ce projet couvre :

* Broken Access Control
* Cryptographic Failures
* Stored XSS
* TLS misconfiguration
* Session predictability

Il démontre l’importance :

* d’une bonne génération de tokens
* d’un encodage sécurisé
* d’une validation stricte côté serveur

🧠 **Think like an attacker to defend like a professional.**
