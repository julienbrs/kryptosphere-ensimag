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