 # 🛡️ Web Application Security – OWASP Top 10 (0x01)

Ce dossier contient une série d’exercices pratiques illustrant plusieurs vulnérabilités du **OWASP Top 10**, à travers un environnement volontairement vulnérable. Chaque task vise à comprendre, identifier et exploiter une faille de sécurité web réelle.

---

## 📌 Task 1 – A2: Cryptographic Failures

**XOR Decoder (WebSphere-like)**

### 🎯 Objectif

Créer un script Bash capable de décoder une chaîne encodée en **Base64 + XOR**.

### 🔍 Description

Certaines applications utilisent encore des mécanismes faibles pour “chiffrer” des données sensibles.
Dans ce cas :

* les données sont encodées en Base64,
* puis chaque octet est XORé avec une clé fixe (`95`).

Le script doit :

* accepter une chaîne en argument,
* retirer le préfixe `{xor}`,
* décoder la chaîne,
* appliquer l’opération XOR,
* afficher le texte en clair.

### 🧠 Vulnérabilité OWASP

**A2 – Cryptographic Failures**

### 📁 Fichier attendu

* `1-xor_decoder.sh`

---

## 📌 Task 2 – A2: Cryptographic Failures

**Encoding Failure – Retrieve Credentials**

### 🎯 Objectif

Récupérer des identifiants de connexion en analysant les requêtes réseau de l’application.

### 🔍 Description

Lors d’une tentative de connexion :

* un header `Authorization: bearer ...` est envoyé,
* ce token est encodé en Base64,
* il contient un JSON avec un `username` et un `password_hash`,
* le mot de passe est encodé via le mécanisme XOR vu à la task précédente.

Étapes :

1. Intercepter le bearer token (Fetch/XHR).
2. Le décoder (Base64).
3. Décoder le mot de passe (XOR).
4. Se connecter avec les identifiants récupérés.
5. Accéder au profil pour obtenir le flag.

### 🧠 Vulnérabilité OWASP

**A2 – Cryptographic Failures**

### 📁 Fichier attendu

* `2-flag.txt`

---

## 📌 Task 3 – A3: Injection

**Stored XSS – Samy Worm Inspired**

### 🎯 Objectif

Identifier et exploiter une vulnérabilité de **Cross-Site Scripting stockée**.

### 🔍 Description

L’exercice est inspiré du célèbre **Samy Worm (MySpace, 2005)**.

#### Étapes :

1. Identifier des profils spécifiques à suivre.
2. Suivre ces profils pour déclencher un premier flag.
3. Observer l’activité des profils dans l’API `/api/a3/xss_stored/profile`.
4. Retourner sur son propre profil afin de récupérer le flag.

### 🧠 Vulnérabilité OWASP

**A3 – Injection (Stored XSS)**

### 📁 Fichier attendu

* `3-flag.txt`

---

## 📌 Task 4 – A3: Injection

**Discovering a Vulnerable Input Field**

### 🎯 Objectif

Identifier quel champ du formulaire d’édition de profil est vulnérable à une **XSS stockée**.

### 🔍 Description

Sur la page d’édition du profil (`/a3/xss_stored/edit`), plusieurs champs sont proposés.
L’objectif est de tester chaque champ avec une payload XSS simple :

```html
<script>alert('XSS')</script>
```

Le champ vulnérable est celui dont la valeur est réinjectée dans le HTML **sans échappement**, ce qui permet l’exécution du JavaScript lors de l’affichage du profil.

L’analyse du code source HTML généré montre que le champ suivant est vulnérable :

```
f_name
```

### 🧠 Vulnérabilité OWASP

**A3 – Injection (Stored XSS)**

### 📁 Fichier attendu

* `4-vuln.txt` (contient le nom du champ vulnérable)

---

## ✅ Conclusion

Ces exercices permettent de comprendre concrètement :

* pourquoi les **cookies de session doivent être imprévisibles**,
* pourquoi **Base64 ≠ chiffrement**,
* pourquoi les **chiffrements faibles (XOR)** sont dangereux,
* comment une **XSS stockée** peut se propager,
* et pourquoi **faire confiance au client est une erreur critique**.

Ils couvrent des failles **réelles**, encore présentes dans de nombreuses applications modernes.
