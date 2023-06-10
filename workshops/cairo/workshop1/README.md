# Découverte de Cairo1 et Starknet

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

---

#### Squelette du Contrat de Compteur


**Étapes à Suivre: **

- Compléter la Déclaration de la Variable de Compteur
    Ajoutez la déclaration de la variable counter dans la structure Storage.

- Initialiser la Variable de Compteur
    Implémentez le constructeur pour initialiser la variable counter avec init_value.

- Lire la Valeur du Compteur
    Complétez la fonction get_current_count pour retourner la valeur actuelle du compteur.

- Incrémenter le Compteur
    Écrivez la logique pour augmenter la valeur du compteur dans la fonction increment.

- Décrémenter le Compteur
    Développez la fonction decrement pour réduire la valeur du compteur.

