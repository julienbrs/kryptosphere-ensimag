#[starknet::interface]
trait ISimpleCounter<TContractState> {
    fn increment(ref self: TContractState);
    fn decrement(ref self: TContractState);
    fn get_counter(self: @TContractState) -> u128;
}

#[starknet::contract]
mod SimpleCounter {
    #[storage]
    struct Storage {
        counter: u128, 
    }

    #[constructor]
    fn constructor(ref self: ContractState, init_value: u128) {
        self.counter.write(init_value);
    }

    #[abi(embed_v0)]
    impl SimpleCounter of super::ISimpleCounter<ContractState> {
        fn increment(ref self: ContractState) {
            let counter = self.counter.read() + 1;
            self.counter.write(counter);
        }
        fn decrement(ref self: ContractState) {
            let counter = self.counter.read() - 1;
            self.counter.write(counter);
        }
        fn get_counter(self: @ContractState) -> u128 {
            return self.counter.read();
        }
    }
}
