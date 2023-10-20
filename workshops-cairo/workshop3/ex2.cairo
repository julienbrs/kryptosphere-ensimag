#[derive(Copy, Drop)]
enum Commande {
    // ???
}

fn main() {
    let mut commandes: Array<Commande> = ArrayTrait::new();
    commandes.append(Commande::Stopper(()));
    commandes.append(Commande::Crier('Getting Starkpilled'));
    commandes.append(Commande::Teleporter((20, 40)));
    commandes.append(Commande::Colorier((255, 0, 0)));
}