use starknet::ContractAddress;

#[starknet::interface]
trait ISimpleErc20<TContractState> {
    fn get_name(self: @TContractState) -> felt252;
    fn get_symbol(self: @TContractState) -> felt252;
    fn get_total_supply(self: @TContractState) -> felt252;
    fn balance_of(self: @TContractState, account: ContractAddress) -> felt252;
    fn allowance(
        self: @TContractState, owner: ContractAddress, spender: ContractAddress
    ) -> felt252;
    fn transfer(ref self: TContractState, recipient: ContractAddress, amount: felt252);
    fn transfer_from(
        ref self: TContractState,
        sender: ContractAddress,
        recipient: ContractAddress,
        amount: felt252
    );
    fn approve(ref self: TContractState, spender: ContractAddress, amount: felt252);
}

#[starknet::contract]
mod SimpleErc20 {
    // Importations nécessaires
    use starknet::{ContractAddress, get_caller_address};
    use starknet::legacy_map::LegacyMap;

    #[storage]
    struct Storage {
        // TODO: Déclarer les variables de stockage du token
    }

    #[constructor]
    fn constructor(ref self: ContractState, // TODO: Paramètres du constructeur ) {
        // TODO: Initialisation du token
    }

    #[abi(embed_v0)]
    impl SimpleErc20 of super::ISimpleErc20<ContractState> {
        // TODO: Implémenter les méthodes de l'interface ERC20
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        // TODO: Implémenter les méthodes internes nécessaires pour ERC20
    }
}
