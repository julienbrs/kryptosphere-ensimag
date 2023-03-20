# Workshop n°1, Découverte de Solidity
![](https://i.imgur.com/EODjjU5.jpg)


## Notions à avoir en tête
### Une blockchain c'est quoi ?
Une blockchain est un système de stockage et de transfert d’informations décentralisé, sécurisé et transparent. Les informations sont réparties sur un réseau d’ordinateurs appelés nœuds, qui vérifient et valident les transactions selon des règles prédéfinies. Chaque transaction est enregistrée dans un bloc qui contient un lien vers le bloc précédent, formant ainsi une chaîne de blocs.

### Ethereum
Ethereum est une blockchain permettant de créer et d'exécuter des smart-contracts. Ethereum dispose aussi de sa propre monnaie numérique, appelée ether (ETH), qui sert à payer les frais de fonctionnement du réseau (le gas) et à récompenser les mineurs qui valident les blocs.!


### Un smart-contract c'est quoi ?
Un smart-contract est un programme informatique qui s’exécute automatiquement sur la blockchain selon des conditions préétablies. Il permet de créer des applications décentralisées (DApps) qui interagissent avec la blockchain sans intermédiaire. Par exemple, un smart-contract peut représenter un contrat de vente, une loterie, un vote ou une assurance.

### Solidity, le langage d'Ethereum
Solidity est un langage orienté objet et de haut niveau pour la mise en œuvre de contrats intelligents sur la blockchain Ethereum. Il est influencé par le C++, le Python et le JavaScript. Voici quelques concepts importants à connaître en Solidity :
- Les types de données : Il existe des types numériques (uint, int), des booléens (bool), des chaînes de caractères (string), des énumérés (enum), des tableaux (array), des structurés (struct), des dictionnaires (mapping) ou encore des adresses (address).
- Les fonctions : Les fonctions en Solidity ont des spécificateurs de visibilité (public, private, internal, external) et de mutabilité (pure, view, payable), nous y reviendrons plus tard.
- Les événements : Solidity permet de définir des événements qui sont des notifications émises par les contrats lorsqu’une action importante se produit. Ces événements sont stockés sur la blockchain.
- Les modificateurs : Solidity permet de définir des modificateurs qui sont des conditions préalables à l’exécution d’une fonction. Les modificateurs peuvent être utilisés pour vérifier certaines propriétés du contrat ou du message appelant la fonction.

## Workshop

### Premier smart-contract sous Remix

Remix est un outil en ligne qui permet de développer, tester et déployer des smart contracts en Solidity. Nous allons utiliser Remix pour créer notre tout premier smart contract : un compteur qui peut être incrémenté ou décrémenté.

#### Environnement
- Ouvrez le site https://remix.ethereum.org/ dans votre navigateur
- Cliquez sur le bouton “+” en haut à gauche pour créer un nouveau Workspace. Dans le dossier contracts créer un nouveau fichier "Counter.sol"

#### Compteur
Nous allons utiliser Remix pour créer notre tout premier smart contract : un compteur qui pourra être incrémenté ou décrémenté.

La documentation de Solidity est disponible [ici](https://docs.soliditylang.org/en/v0.8.19/structure-of-a-contract.html).


1. Commencez par indiquer la licence du contrat (MIT) et la version du compilateur Solidity (^0.8.0). Vous pouvez prendre exemple sur les autres contrats du dossier.
2. Déclarez le contrat Counter avec le mot-clé contract
3. Déclarez une variable d’état count de type uint256 qui va stocker le compteur. Doit-elle être publique ou privée ?
4. Déclarez un constructeur à un paramètre servant à initialiser le compteur. Le constructeur est appelé automatiquement lors du déploiement du contract sur la blockchain.
5. Déclarez une fonction publique increment qui incrémente le compteur de 1, ainsi qu'une fonction decrement.

Votre contrat est prêt ! 
- Cliquez sur la 3ème icône de la navbar  à gauche et cliquez sur “Compile Counter.sol”
- Pour déployer votre contract, cliquez sur la 4ème icône à gauche et sélectionnez “Remix VM London” comme environnement.
- Entrez une valeur initiale pour le compteur (par exemple 0) dans le champ “Deploy”, puis cliquez sur "Deploy"
- Dans l'onglet "Deployed Contracts", cliquez sur le contrat déployé pour appeler les fonctions et consulter la variable count.

### Déploiement sur Testnet
#### Les différents types de blockchains
Vous venez de déployer votre contract sur Remix VM London. Remix VM London est un environnement de test qui simule une blockchain locale dans votre navigateur. Cela vous permet de tester vos contrats sans utiliser de vraie monnaie ni les exposer à d’autres personnes. Mais si vous voulez que votre contrat soit accessible au public et interagisse avec d’autres applications décentralisées, vous devez le déployer sur une vraie blockchain.

Ethereum est la blockchain la plus utilisée pour les smart contracts. Elle dispose de plusieurs réseaux : le réseau principal (mainnet) et les réseaux de test (testnets). Le mainnet est le réseau officiel où les transactions sont réelles et impliquent l'utilisation de vrais fonds. Les testnets sont des réseaux expérimentaux où les transactions sont gratuites et sans conséquence. Ils servent à tester des applications décentralisées avant de les lancer sur le mainnet. Nous utiliserons le testnet Goerli

#### Metamask
Pour cela, nous allons utiliser Metamask : une extension pour navigateur qui permet d’interagir avec la blockchain Ethereum.

Metamask est une extension pour navigateur qui permet d’interagir avec la blockchain Ethereum. C’est aussi un portefeuille numérique qui vous permet de gérer vos propres clés privées et publiques. Vos clés privées sont des codes secrets qui vous donnent le contrôle total de vos fonds sur la blockchain. Vos clés publiques sont des adresses qui vous identifient sur la blockchain et qui permettent de recevoir ou d’envoyer des transactions.

L’intérêt de Metamask est que vous possédez réellement votre argent et que vous n’avez pas besoin de faire confiance à un tiers (comme une banque) pour gérer vos fonds. Vous êtes votre propre banque ! Cela implique aussi plus de responsabilité : si vous perdez vos clés privées ou votre phrase secrète, vous perdez l’accès à vos fonds et personne ne peut vous les restituer.

Metamask est donc un outil indispensable pour tout développeur ou utilisateur de la blockchain Ethereum.

**Voici les étapes à suivre pour l'installation :**

1. Installez Metamask depuis [ce lien](https://metamask.io/download/) selon votre navigateur
2. Créez un compte Metamask en choisissant un mot de passe et en sauvegardant votre phrase secrète (seed). Attention : ne perdez pas cette phrase secrète car elle vous permettra de restaurer votre compte si vous changez d’appareil ou si vous perdez vos données.
3. Ajoutez puis sélectionnez le réseau Goerli (appelez un membre ou bien suivez ce [rapide tuto](https://blog.cryptostars.is/goerli-g%C3%B6rli-testnet-network-to-metamask-and-receiving-test-ethereum-in-less-than-2-min-de13e6fe5677))
4. Cliquez sur “Ajouter des jetons” puis “Jeton personnalisé” et entrez l’adresse du contrat Token que vous avez déployé en local dans Remix
Vous devriez voir apparaître votre token dans votre portefeuille Metamask avec sa quantité totale
Félicitations ! Vous avez ajouté votre token à Metamask ! 🙌

Mais il nous manque encore quelque chose : des Ether (ETH) pour payer les frais de transaction (gas) lors du déploiement ou des appels au smart contract.

Pour obtenir des ETH gratuits sur Goerli, demandez à un membre de l'association de vous en envoyer, ou bien recevez en gratuitement via un [faucet](https://goerlifaucet.com/).

**Déploiement:**
- Vous pouvez revenir sur Remix. Choisissez maintenant "Injected Web3" pour l'environnement, en vous assurant que le réseau Goerli est bien sélectionné dans Metamask.
- Entrez les mêmes paramètres que pour le déploiement local dans le champ “Deploy”, puis cliquez sur “Deploy”. Vous devriez voir une fenêtre Metamask s’ouvrir pour confirmer la transaction. Cliquez sur “Confirmer” et attendez que la transaction soit validée par le réseau (cela peut prendre quelques minutes).
- Dans l’onglet “Deployed Contracts”, cliquez sur le contrat déployé pour appeler les fonctions et consulter les variables d’état. Vous pouvez aussi vérifier l’état de votre contrat sur [Etherscan](https://goerli.etherscan.io/), un explorateur de blocs qui permet de visualiser les transactions et les contrats sur la blockchain Ethereum.

### Ma première cryptomonnaie

Les cryptomonnaies permettent de réaliser des transactions sécurisées, décentralisées et transparentes sans avoir besoin d’un intermédiaire centralisé. Il existe de nombreuses cryptomonnaies différentes, chacune ayant ses propres caractéristiques et usages.

Nous allons créer notre propre cryptomonnaie (=token) en Solidity. Notre token aura un nom, un symbole, une quantité totale et une fonction de transfert. En fait, toutes les propriétés énnoncées précédement sont communes aux tokens. Pour que le votre en soit un, il faut qu'il implémente aussi le standard [ERC20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/).

Les ERCs sont des ressources qui rassemblent les propositions d'amélioration apportées par la communauté. Des ERCs connues sont par exemple l'[ERC20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) pour les tokens, l'[ERC721](https://eips.ethereum.org/EIPS/eip-721) pour les NFT ou l'[ERC1155](https://ethereum.org/fr/developers/docs/standards/tokens/erc-1155/) pour les DAOs (à voir plus tard..).

- Créez un nouveau fichier .sol et déclarez votre nouveau contrat Token
- Déclarez les variables d’état name (string), symbol (string), totalSupply (uint256).
- De plus, créez un mapping nommé balances, qui associe chaque adresse avec le nombre de jetons qui lui sont associés. Ce mapping nous permettra de suivre la quantité de jetons détenue par chaque adresse.
- Déclarez le constructeur de votre contrat si cela vous semble judicieux.
- Déclarez une fonction publique transfer qui prend deux paramètres : l’adresse du destinataire (_to) et le montant (_value) à transférer. Cette fonction doit vérifier que l’émetteur a suffisamment de tokens dans son solde, déduire le montant de son solde, ajouter le montant au solde du destinataire
- Faites en sorte que la fonction transfer émette un événement Transfer avec les informations du transfert. ([Rappel Doc Solidity ici](https://docs.soliditylang.org/en/v0.8.19/structure-of-a-contract.html#events))

Votre contrat est prêt à être déployé ! 
Vous avez créé votre propre cryptomonnaie en Solidity ! 🎉
Mais ce n’est pas fini ! Nous allons maintenant déployer notre smart contract sur un réseau testnet : Goerli.


### Pour aller plus loin

Nous allons modifier notre contrat Token pour ajouter une fonctionnalité supplémentaire : un rôle d’administrateur. Le rôle d’administrateur va permettre à une adresse spéciale de créer ou détruire des tokens.

Pour cela, nous allons utiliser un modifier. Un modifier est une clause qui peut être ajoutée à une fonction pour modifier son comportement ou ses conditions d’exécution. Par exemple, on peut utiliser un modifier pour restreindre l’accès à la fonction à certaines adresses.

1. Créez un nouveau fichier .sol et copiez le code de votre contrat Token précédent
2. Déclarez une variable d’état nommée admin qui représente l’adresse de l’administrateur du contrat
3. Déclarez un modifier nommé onlyAdmin qui ne prend pas de paramètre. Ce modifier doit vérifier que l’adresse qui appelle la fonction est égale à l’adresse admin. Si ce n’est pas le cas, le modifier doit annuler la transaction avec revert()
4. Déclarez deux fonctions publiques mint et burn qui prennent chacune deux paramètres : l’adresse du bénéficiaire (_to) et le montant (_value) en nombre de tokens. Ces fonctions doivent permettre à l’administrateur respectivement 1)de créer des nouveaux tokens et les ajouter au solde du bénéficiaire 2)de détruire des tokens existants du solde du bénéficiaire . Ajoutez le modifier onlyAdmin à ces fonctions

Votre contrat est prêt à être testé ! Vous avez ajouté un modifier à votre contrat Token pour créer un rôle d’administrateur ! 🎉
