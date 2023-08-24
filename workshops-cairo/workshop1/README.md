# Découverte de Cairo1 et Starknet

<p align="center">
  <img src="../assets/starknet-quantum-leap.jpg" alt="Starknet quantum leap" width="50%"style="margin-bottom: 20px;"/>
</p>

Premier workshop sur StarkNet et Cairo1. Pour rappel, Starknet est un Layer2 d'Ethereum et Cairo1, son langage de programmation dédié. Conçus pour surmonter les limitations d'Ethereum, Cairo1 permet d'aborder le concept de Zero-Knowledge

### Starknet

#### 1. Technologie et Architecture:

StarkNet utilise la technologie zk-Rollup pour exécuter les transactions et les calculs hors chaîne avant de soumettre une preuve unique à Ethereum.
Cette approche réduit les coûts de gaz et améliore la scalabilité par rapport aux smart contracts sur Ethereum.

#### 2. Exécution et Vérification:

Les smart contracts StarkNet sont exécutés et vérifiés off-chain (pas sur la blockchain). Seule une preuve succincte générée off-chain et vérifiable est soumise à Ethereum.

#### 3. Réduction des Coûts de Gaz:

La plupart des calculs ayant lieu hors chaîne, les coûts de gaz sont considérablement réduits, rendant les transactions plus abordables.

### Cairo : Le Langage de StarkNet

Langage Spécifique:

Cairo a été conçu spécifiquement pour Starknet, offrant des fonctionnalités uniques pour la vérification efficace des calculs. C'est donc une grande barrière à l'entrée, mais une fois maîtrisé, Cairo offre de très grandes possibilités.

#### Avantages et Défis

**Avantages de StarkNet et Cairo:**

- Scalabilité: StarkNet améliore grandement la capacité de traitement des transactions d'Ethereum.
- Coût-Efficacité: Les frais de transaction sont généralement plus bas sur StarkNet.
- Confidentialité: Les transactions sur StarkNet peuvent rester confidentielles.
- Sécurité de la Couche 1: StarkNet profite de la sécurité et de la décentralisation d'Ethereum tout en fonctionnant comme une - solution de couche 2.

** Défis à Surmonter:**

- Courbe d'Apprentissage: L'apprentissage de Cairo peut être plus exigeant comparé à Solidity.
- Adoption du Réseau: En tant que technologie émergente, StarkNet est encore en phase d'adoption initiale.

Ce workshop vise à vous familiariser avec les concepts de StarkNet et Cairo. C'est un langage très similaire à Rust et pas forcément évident au premier abord, mais il est très puissant et permet de faire des choses très intéressantes 🚀

---

#### Prérequis

- Compréhension basique de la blockchain et des smart contracts.
- IDE pour Cairo (VSCode recommandé).

---

#### Configuration de l'Environnement de Développement

Contrairement à Solidity où nous avions commencé sur Remix, nous allons ici utiliser VSCode et Scarb pour compiler et déployer nos smart contracts.

#### Installation de Scarb

Scarb est le compilateur et le gestionnaire de paquets pour Cairo, inspiré de Cargo de Rust. Il simplifie la compilation de votre code Cairo et la gestion des dépendances.

**1. Prérequis**:

- Assurez-vous que vous avez bien Git d'installé.

**2. Installation de Scarb**:

- Exécutez la commande suivante dans votre terminal pour installer Scarb:
  ```
  curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh
  ```
- Vérifiez l'installation en exécutant `scarb --version`.

#### Installation de l'Extension VSCode pour Cairo

**1. Extension VSCode**:

- Installez l'extension Cairo pour VSCode depuis le Marketplace de VSCode.
- Dans les paramètres de l'extension, activez les options 'Enable Language Server' et 'Enable Scarb'.

---

#### Hello world en Cairo

**1. Création du Répertoire du Projet**:

- Créez un répertoire pour vos projets Cairo:
  ```
  mkdir ~/cairo_projects
  cd ~/cairo_projects
  ```

**2. Utilisation de Scarb pour Créer un Projet**:

- Dans votre répertoire de projets, exécutez:
  ```
  scarb new nom_du_projet
  ```
- Ceci crée un nouveau projet nommé `nom_du_projet`.

**3. Structure du Projet**:

- Un projet Scarb typique contient un fichier `Scarb.toml` et un répertoire `src` avec un fichier `lib.cairo` à l'intérieur.
- Scarb initialise également un dépôt Git avec un fichier `.gitignore`. Vous pouvez supprimer le répertoire `.git` si vous ne souhaitez pas utiliser Git (`rm -rf .git`).

**4. Configuration du Projet**:

- Ouvrez `Scarb.toml` et configurez les détails de votre projet, comme le nom et les dépendances.

---

#### Construire et Exécuter un Projet Scarb

**1. Construction du Projet**:

- Dans le répertoire `nom_du_projet`, exécutez:
  ```
  scarb build
  ```
- Ceci compile votre projet Cairo.

**2. Exécution du Projet**:

- Pour exécuter le projet, utilisez:
  ```
  scarb cairo-run
  ```
- Vérifiez la sortie de votre programme Cairo.

**3. Exécution des Tests**:

- Pour exécuter les tests, utilisez:
  ```
  scarb test
  ```
- Vérifiez la sortie des tests.

---

## Création d'un SC Compteur

Comme pour le workshop 1 de Solidity, nous allons créer un smart contract Compteur pour nous familiariser avec Cairo et sa syntaxe.
Le squelette du code est disponible [ici](modeles/counter.cairo).
Pour vous aider, vous pouvez vous référer à la documentation de Cairo [ici](https://book.cairo-lang.org/title-page.html), spécifiquement sur les chapitres 2.1 et 2.2. Nous les survolerons ensemble en début de workshop.

**Étapes à Suivre: **

- Compléter la Déclaration de la Variable de Compteur: ajoutez la déclaration de la variable counter dans la structure Storage.

- Initialiser la Variable de Compteur: implémentez le constructeur pour initialiser la variable counter avec init_value.

- Lire la Valeur du Compteur: complétez la fonction get_current_count pour retourner la valeur actuelle du compteur.

- Incrémenter le Compteur: écrivez la logique pour augmenter la valeur du compteur dans la fonction increment.

- Décrémenter le Compteur: développez la fonction decrement pour réduire la valeur du compteur.
