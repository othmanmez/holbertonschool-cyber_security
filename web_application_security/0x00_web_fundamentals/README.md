# 🛡️ Sécurité des Applications Web — 0x00 Web Fundamentals

## 📌 Présentation du projet

Ce projet consiste à réaliser un **test d’intrusion (pentest)** sur une application web développée rapidement avec l’aide d’une IA.
L’objectif est d’identifier et d’exploiter plusieurs vulnérabilités courantes des applications web.

Application cible :
👉 [http://web0x00.hbtn](http://web0x00.hbtn)

Environnement de test : Kali Linux

---

## 🎯 Objectifs

* Explorer l’application web
* Identifier des failles de sécurité
* Exploiter les vulnérabilités
* Documenter les résultats et proposer des corrections

---

## 🌐 Informations sur la cible

* Domaine : web0x00.hbtn
* IP : 10.42.81.123
* Endpoints découverts :

  * /login
  * /reset_password
  * /home

---

# 🚨 Vulnérabilités trouvées

---

## 🔴 Vulnérabilité 1 — Énumération d’utilisateurs

### 📍 Endpoint

/reset_password

### 📖 Description

L’application retourne des messages différents selon que l’email existe ou non.

* Email invalide → « Email provided not found »
* Email valide → « An e-mail was successfully sent to … »

### 🧪 Preuve de concept

```
test@test.com        → Email provided not found  
abdou@web0x00.hbtn   → An e-mail was successfully sent to abdou@web0x00.hbtn
```

### 💥 Impact

Permet à un attaquant d’identifier les comptes valides et de préparer des attaques ciblées.

### 🛠️ Correction

Toujours afficher un message générique, par exemple :
« Si l’email existe, un lien de réinitialisation a été envoyé. »

---

## 🔴 Vulnérabilité 2 — Divulgation d’informations

### 📍 Emplacement

Page de réinitialisation du mot de passe & code source HTML

### 📖 Description

Des informations sensibles internes sont exposées :

Emails internes découverts :

* [yosri@web0x00.hbtn](mailto:yosri@web0x00.hbtn)
* [maroua@web0x00.hbtn](mailto:maroua@web0x00.hbtn)
* [abdou@web0x00.hbtn](mailto:abdou@web0x00.hbtn)

Commentaire trouvé dans le code :

```html
<!-- Last Modification made by: yosri Don't forget to delete comments before production ! -->
```

### 💥 Impact

Facilite l’ingénierie sociale, le phishing et les attaques ciblées.

### 🛠️ Correction

* Supprimer les commentaires en production
* Ne jamais exposer d’informations internes

---

## 🔴 Vulnérabilité 3 — Host Header Injection / Password Reset Poisoning

### 📍 Endpoint

POST /reset_password

### 📖 Description

L’application utilise directement le header HTTP `Host` pour générer des liens. En modifiant ce header, un attaquant peut injecter un domaine malveillant et empoisonner les liens de réinitialisation de mot de passe.

### 🧪 Preuve de concept

```bash
curl -X POST http://web0x00.hbtn/reset_password \
-H "Host: evil.com" \
-d "email=abdou@web0x00.hbtn"
```

Lien généré dans la réponse :

```html
<a href="http://evil.com/login">
```

### 💥 Impact

* Redirection vers un site malveillant
* Vol de jetons de réinitialisation
* Attaques de phishing
* Compromission de comptes utilisateurs

### 🛠️ Correction

* Ne jamais faire confiance au header `Host`
* Définir l’URL du site côté serveur
* Mettre en place une whitelist de domaines
* Valider les headers HTTP

---

## 🔴 Vulnérabilité 4 — Mauvaise conception du système de réinitialisation

### 📍 Endpoint

POST /reset_password

### 📖 Description

La fonctionnalité de réinitialisation permet des tentatives illimitées et révèle des informations sensibles sur l’existence des comptes.

### 💥 Impact

* Énumération de comptes
* Abus du système de reset
* Préparation d’attaques ciblées

### 🛠️ Correction

* Mettre en place un rate limiting
* Ajouter un CAPTCHA
* Journaliser et surveiller les tentatives

---

## 🔴 Vulnérabilité 4 — Exposition de fonctionnalités sensibles

### 📍 Emplacement

Système de réinitialisation de mot de passe

### 📖 Description

Une fonctionnalité critique est accessible sans protections suffisantes.

### 💥 Impact

* Attaques automatisées
* Abus de service
* Ciblage de comptes

### 🛠️ Correction

* Ajouter des contrôles de sécurité
* Protéger les endpoints sensibles
* Renforcer les mécanismes d’authentification

---

# 🧰 Outils utilisés

* Kali Linux
* Firefox Developer Tools
* curl

---

# ✅ Conclusion

Cette application présente plusieurs failles liées à l’authentification, à la divulgation d’informations et à la logique métier.
Elle démontre qu’une application développée rapidement sans bonnes pratiques de sécurité n’est pas « hack-proof ».
