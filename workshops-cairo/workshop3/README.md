# Workshop n°3: Approfondissement de Cairo1

<p align="center">
  <img src="../assets/Cairo-V1.webp" alt="Starknet forest" width="50%"style="margin-bottom: 20px;"/>
</p>

Ce workshop, contrairement aux précédents, se veut interactif. Il n'y a pas de code à écrire, mais des exercices à résoudre. C'est l'occasion d'approfondir vos connaissances en Cairo1 et de voir des fonctionnalités plus avancées, pour pouvoir ensuite vous lancer dans la création de smart contracts plus complexes pour le prochain workshop.

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