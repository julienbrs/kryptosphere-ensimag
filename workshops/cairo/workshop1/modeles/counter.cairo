#[starknet::interface]
trait ISimpleCounter<TContractState> {
    fn increment(ref self: TContractState);
    fn decrement(ref self: TContractState);
    fn get_counter(self: @TContractState) -> u128;
}

#[starknet::contract]
mod SimpleCounter {
    #[storage]
    struct Storage {// TODO: Déclarer la variable de compteur
    }

    #[constructor]
    fn constructor(ref self: ContractState, init_value: u128) {// TODO: Initialiser la variable de compteur
    }

    #[abi(embed_v0)]
    impl SimpleCounter of super::ISimpleCounter<ContractState> {
        fn increment(ref self: ContractState) {// TODO: Implémenter la logique pour incrémenter la valeur du compteur
        }

        fn decrement(ref self: ContractState) {// TODO: Implémenter la logique pour décrémenter la valeur du compteur
        }
        fn get_counter(self: @ContractState) -> u128 {// TODO: Implémenter la logique pour lire la valeur du compteur
        }
    }
}
