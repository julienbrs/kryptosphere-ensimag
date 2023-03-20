# Scaffold-eth

Un makefile est mis à disposition pour vous aider à rapidement utiliser scaffold-eth avec docker. Il est conseillé à long terme d'utiliser scaffold-eth sans docker, c'est tout aussi simple.

## Quick launch

`make` - Lance la blockchain, déploie les contrats dans `scaffold-repo/packages/hardhat/contracts`, et sert le frontend reactjs dans `scaffold-repo/packages/react-app`. Vous pouvez changer le port du front dans le Makefile, et accéder au front sur [http://localhost:3000/](http://localhost:3000/)


## Targets

- `make container` - Lance un contenaire docker pour scaffold eth
- `make [chain/start]` - Lance la chain/le front en fond
- `make deploy` - Redéploie vos smart contracts
- `make logs-[all/front/hardhat]` - Affiche les logs des tâches de fond
- `make interactive` - lance une console interactive (en bash pas zsh...) dans le contenaire
- `make stop` - Stop le contenaire (sinon il mange votre port 3000 pour le front)
- `make rm` / `make rm-hard` - Supprime le contenaire docker
- `make reboot` - rm + all