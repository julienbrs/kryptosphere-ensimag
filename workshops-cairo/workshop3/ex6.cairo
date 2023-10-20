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