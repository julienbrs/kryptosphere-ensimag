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