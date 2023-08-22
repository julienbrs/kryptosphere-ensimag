# Workshop 2: ERC20 en Cairo

## Création d'une crypto-monnaie

Tout comme dans le workshop de Solidity, nous allons créer une crypto-monnaie avec Cairo, mais cette fois-ci avec plus de fonctionnalité.

Commencez par créer un nouveau projet Scarb et copiez le code du modèle [ici](modeles/erc20.cairo).

### Étapes à Suivre:

- Observez l'interface: prenez le temps de comprendre l'interface du contrat ERC20 qui vous est fournie.

- Déclaration des Variables de Stockage: déclarez les variables comme le nom, le symbole, le total de l'offre et les mappings pour les balances et les allowances.

- Construction du Constructeur: écrivez le constructeur pour initialiser votre token avec les valeurs de base et mint le total de l'offre à l'adresse du propriétaire. Vous pouvez utiliser une fonction interne pour mint, de la forme:
`fn mint(ref self: ContractState, recipient: ContractAddress, amount: felt252) { TODO }`

- Implémentation des Fonctions ERC20 basiques: complétez les fonctions comme balance_of, transfer, etc. Gardez approve et transfer_from pour plus tard.


### Ajout de Fonctionnalités
- Allowance:
    L'allowance est un mécanisme qui permet à un propriétaire de tokens d'autoriser un autre compte (le "spender") à transférer jusqu'à un certain nombre de tokens en son nom.
    Cette fonctionnalité est utile dans les scénarios où vous souhaitez permettre à une tierce partie de gérer vos tokens, comme pour des dApp de swap ou de staking. 

- TransferFrom:
    La fonction transferFrom permet à un "spender" autorisé de transférer des tokens depuis le compte d'un propriétaire vers un autre compte.
    Cette fonction est souvent utilisée en conjonction avec l'allowance pour réaliser des transactions au nom d'un autre utilisateur, dans les limites de l'allowance fixée.


- Ajout de Méthodes Internes: développez des méthodes internes pour gérer les transferts et les allowances.

- Intégration des Événements: si nécessaire, ajoutez des événements pour Transfer et Approval.
