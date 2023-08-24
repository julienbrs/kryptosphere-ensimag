# Workshop 2: ERC20 en Cairo

<p align="center">
  <img src="../assets/starknet-forest.jpeg" alt="Starknet forest" width="50%"style="margin-bottom: 20px;"/>
</p>


## Création d'une crypto-monnaie

Tout comme dans le workshop de Solidity, nous allons créer une crypto-monnaie avec Cairo, mais cette fois-ci avec plus de fonctionnalité.

Commencez par créer un nouveau projet Scarb et copiez le code du modèle [ici](modeles/erc20.cairo).

### Étapes à Suivre:

- Observez l'interface: prenez le temps de comprendre l'interface du contrat ERC20 qui vous est fournie.


#### Étape de Déclaration des Variables de Stockage

Pour créer votre token ERC20, vous devez d'abord déclarer un ensemble de variables de stockage dans votre contrat. Ces variables représentent les attributs essentiels de votre token.

**1. Variables à Déclarer dans le Storage:**

    a. **Nom (`name`):**
    - Type: `felt252`
    - Description: Le nom de votre token, par exemple "MyToken".

    b. **Symbole (`symbol`):**
    - Type: `felt252`
    - Description: Le symbole abrégé de votre token, comme "MTK".

    c. **Total de l'Offre (`total_supply`):**
    - Type: `felt252`
    - Description: La quantité totale de tokens en circulation.

    d. **Balances (`balances`):**
    - Type: `LegacyMap::<ContractAddress, felt252>`
    - Description: Un mapping associant les adresses des utilisateurs à la quantité de tokens qu'ils détiennent.
    - Conseil: Utilisez `LegacyMap` pour créer ce mapping.

    e. **Allowances (`allowances`):**
    - Type: `LegacyMap::<(ContractAddress, ContractAddress), felt252>`
    - Description: Un mapping qui enregistre les montants qu'une adresse (owner) autorise une autre adresse (spender) à utiliser.
    - Conseil: Le mapping doit associer une paire d'adresses (owner et spender) au montant autorisé.


**2. Construction du Constructeur:**

    Écrivez le constructeur pour initialiser votre token avec les valeurs de base et mint le total de l'offre à l'adresse du propriétaire. Vous pouvez utiliser une fonction interne pour mint, de la forme:
    `fn mint(ref self: ContractState, recipient: ContractAddress, amount: felt252) { TODO }`

- Implémentation des Fonctions ERC20 basiques: complétez les fonctions comme balance_of, transfer, etc. Gardez approve et transfer_from pour plus tard.


### Ajout de Fonctionnalités

#### Comprendre les "Decimals" dans un Token ERC20

- **Qu'est-ce que les Decimales?**
  - Dans le contexte d'un token ERC20, "decimals" désigne le nombre de chiffres qui peuvent apparaître après la virgule dans une quantité de token. Cela permet de diviser les tokens en fractions plus petites.
  - Par exemple, si un token a 18 décimales, cela signifie que vous pouvez avoir 0.000000000000000001 unités de ce token.

- **Pourquoi les Decimales sont-elles importantes?**
  - Les décimales offrent de la flexibilité dans les transactions et permettent une plus grande précision dans les échanges de tokens.
  - Ils sont particulièrement utiles pour les tokens ayant une grande valeur unitaire, permettant ainsi des transactions de montants très petits.

- **Comment les implémenter?**
  - Dans votre contrat ERC20, vous définirez une variable `decimals` qui stockera le nombre de décimales.
  - Ce nombre est utilisé pour calculer la représentation "réelle" des montants de tokens lors des transferts et autres opérations.
    - Ajoutezun attribut `decimals` qui stocke le nombre de décimales dans le Storage et une fonction `decimals` qui renvoie le nombre de décimales.

#### Approve et TransferFrom
- Allowance:
    L'allowance est un mécanisme qui permet à un propriétaire de tokens d'autoriser un autre compte (le "spender") à transférer jusqu'à un certain nombre de tokens en son nom.
    Cette fonctionnalité est utile dans les scénarios où vous souhaitez permettre à une tierce partie de gérer vos tokens, comme pour des dApp de swap ou de staking. 

- TransferFrom:
    La fonction transferFrom permet à un "spender" autorisé de transférer des tokens depuis le compte d'un propriétaire vers un autre compte.
    Cette fonction est souvent utilisée en conjonction avec l'allowance pour réaliser des transactions au nom d'un autre utilisateur, dans les limites de l'allowance fixée.


- Ajout de Méthodes Internes: développez des méthodes internes pour gérer les transferts et les allowances.

- Intégration des Événements: si nécessaire, ajoutez des événements pour Transfer et Approval.
