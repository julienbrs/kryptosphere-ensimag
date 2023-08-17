# Workshop 2: ERC20 en Cairo

## Création d'une crypto-monnaie

Tout comme dans le workshop de Solidity, nous allons créer une crypto-monnaie avec Cairo, mais cette fois-ci avec plus de fonctionnalité.

Commencez par créer un nouveau projet Scarb et copiez le code du modèle [ici](modeles/erc20.cairo).

### Étapes à Suivre:
  - Observez l'interface: prenez le temps de comprendre l'interface du contrat ERC20 qui vous est fournie.

  - Déclaration des Variables de Stockage: déclarez les variables comme le nom, le symbole, le total de l'offre et les mappings pour les balances et les allowances.

  - Construction du Constructeur: écrivez le constructeur pour initialiser votre token avec les valeurs de base.

  - Implémentation des Fonctions ERC20: complétez les fonctions comme balance_of, transfer, approve, transfer_from, etc.

  - Ajout de Méthodes Internes: développez des méthodes internes pour gérer les transferts et les allowances.

  - Intégration des Événements: si nécessaire, ajoutez des événements pour Transfer et Approval.