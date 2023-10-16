# Workshop n°3: Approfondissement de Cairo1

<p align="center">
  <img src="../assets/Cairo-V1.webp" alt="Starknet forest" width="50%"style="margin-bottom: 20px;"/>
</p>

Ce workshop, contrairement aux précédents, se veut interactif. Il n'y a pas de code à écrire, mais des exercices à résoudre. C'est l'occasion d'approfondir vos connaissances en Cairo1 et de voir des fonctionnalités plus avancées, pour pouvoir ensuite vous lancer dans la création de smart contracts plus complexes pour le prochain workshop.

Plus que la résolution des exercices, l'objectif est d'analyser des parties de code moins triviales et de comprendre comment elles fonctionnent. Vous pouvez vous aider de la [documentation officielle de Cairo1](https://book.cairo-lang.org/) pour résoudre les exercices.

## Prérequis:
    - Connaissance de base de la blockchain et des smart contracts.
    - Compréhension élémentaire du langage Cairo1 (variables, fonctions, types de données).
    - Environnement de développement avec Cairo1 installé.



### Exercice 1: Déclaration et affichage de variable

```rust
fn main() {
    // Initialiser une variable 'nombre' pour stocker un entier
    if nombre == 15 {
        // Afficher 'Le nombre est quinze!'
    } else {
        // Afficher 'Le nombre n'est pas quinze!'
    }
}
```

**Attendu :** Corrigez le code pour déclarer correctement la variable nombre et l'initialiser avec une valeur. Ensuite, modifiez le code pour afficher correctement le message en fonction de la valeur de `nombre`.


### Exercice 2: Utilisation d'Enum

```rust
#[derive(Copy, Drop)]
enum Commande {
    // ???
}

fn main() {
    let mut commandes: Array<Commande> = ArrayTrait::new();
    commandes.append(Commande::Stopper(()));
    commandes.append(Commande::Crier("Getting Starkpilled"));
    commandes.append(Commande::Teleporter((20, 40)));
    commandes.append(Commande::Colorier((255, 0, 0)));
}
```

**Attendu :** Définissez correctement les variantes de l'Enum Commande utilisées dans le code. Assurez-vous que le code compile et fonctionne comme prévu.


### Exercice 3: Array

```rust
use array::ArrayTrait;
use option::OptionTrait;

fn creer_tableau() -> Array<felt252> {
    let b = ArrayTrait::new();
    b.append(3.5);
    b.append(4);
    b.append(5);
    b.pop_front().unwrap();
    b
}
```

**Attendu :** Identifiez et corrigez les erreurs dans ce code pour que la fonction creer_tableau fonctionne correctement. Assurez-vous que le tableau est correctement manipulé.

### Exercice 4: Utilisation de Move

```rust

use array::ArrayTrait;
use array::ArrayTCloneImpl;
use array::SpanTrait;
use clone::Clone;
use debug::PrintTrait;

fn main() {
    let arr0 = ArrayTrait::<felt252>::new();

    let mut arr1 = remplir_tableau(arr0);

    arr1.clone().print();

    arr1.append(99);

    arr1.clone().print();
}

// `remplir_tableau()` ne devrait plus prendre `arr: Array<felt252>` en argument
fn remplir_tableau(arr: Array<felt252>) -> Array<felt252> {
    let mut arr = arr;

    arr.append(33);
    arr.append(55);
    arr.append(77);

    arr
}
```

**Attendu :** Réécrivez le code pour que la fonction `remplir_tableau` crée le tableau en interne et le renvoie, plutôt que de le prendre en argument. Assurez-vous que le code fonctionne comme prévu.


### Exercice 5: Utilisation des Options

```rust
use option::OptionTrait;
use debug::PrintTrait;

#[test]
fn test_options() {
    let cible = 'Starkpilling';
    let option_some = Option::Some(cible);
    let option_none: Option<felt252> = Option::None;
    option_simple(option_some);
    option_simple(option_none);
}

fn option_simple(option_cible: Option<felt252>) {
    // TODO: Utilisez les méthodes `is_some` et `is_none` pour vérifier si `option_cible` contient une valeur.
    // Placez l'assertion et l'instruction d'impression ci-dessous dans les blocs appropriés.
    assert(option_cible.unwrap() == "Starkpilling" 'err1');
    ("option est vide !").print();
}
```

**Attendu :** Modifiez le code pour utiliser correctement les méthodes `is_some` et `is_none`, et placez les instructions dans les blocs appropriés.

### Exercice 6: Constructor - Identifier et Corriger l'Erreur

```rust
#[starknet::contract]
mod ExempleConstructeur {
    use starknet::ContractAddress;

    #[storage]
    struct Stockage {
        noms: LegacyMap::<ContractAddress, felt252>,
    }

    fn constructeur(ref self: ContractState, nom: felt252, adresse: ContractAddress) {
        self.noms.write(adresse, nom);
    }
}
```

**Attendu :** Identifiez et corrigez les problèmes dans le constructeur. Assurez-vous que le constructeur initialise correctement le stockage avec les valeurs données.


### Exercice 7: Appel d'un Contrat via un Autre - Identifier l'Élément Manquant

```rust

use starknet::{ContractAddress, ClassHash};

#[starknet::interface]
trait IUsineCompteur<TContractState> {
    fn creer_compteur(ref self: TContractState) -> ContractAddress;
    fn creer_compteur_avec(ref self: TContractState, valeur_init: u128) -> ContractAddress;
    fn mettre_a_jour_valeur_init(ref self: TContractState, valeur_init: u128);
    fn mettre_a_jour_hash_classe_compteur(ref self: TContractState, hash_classe_compteur: ClassHash);
}

#[starknet::contract]
mod UsineCompteur {
    use starknet::{ContractAddress, ClassHash};
    use starknet::syscalls::deploy_syscall;

    #[storage]
    struct Stockage {
        /// Stocker les arguments du constructeur du contrat à déployer
        valeur_init: u128,
        /// Stocker le hash de classe du contrat à déployer
        hash_classe_compteur: ClassHash,
    }

    #[constructor]
    fn constructeur(ref self: ContractState, valeur_init: u128, hash_classe: ClassHash) {
        self.valeur_init.write(valeur_init);
        self.hash_classe_compteur.write(hash_classe);
    }

    impl Usine of super::IUsineCompteur<ContractState> {
        fn creer_compteur_avec(ref self: ContractState, valeur_init: u128) -> ContractAddress {
            // Arguments du constructeur
            let mut donnees_constructeur: Array::<felt252> = array![valeur_init.into()];

            // Déploiement du contrat
            let (adresse_deployee, _) = deploy_syscall(
                self.hash_classe_compteur.read(), 0, donnees_constructeur.span(), false
            )
                .expect('échec du déploiement du compteur');

            adresse_deployee
        }

        fn creer_compteur(ref self: ContractState) -> ContractAddress {
            self.creer_compteur_avec(self.valeur_init.read())
        }

        fn mettre_a_jour_valeur_init(ref self: ContractState, valeur_init: u128) {
            self.valeur_init.write(valeur_init);
        }

        fn mettre_a_jour_hash_classe_compteur(ref self: ContractState, hash_classe_compteur: ClassHash) {
            self.hash_classe_compteur.write(hash_classe_compteur);
        }
    }
}
```

**Attendu :** Identifiez ce qui manque ou ce qui est incorrect dans le code pour permettre à un contrat d'appeler un autre contrat. Corrigez les erreurs pour que la fonctionnalité soit complète et fonctionnelle.