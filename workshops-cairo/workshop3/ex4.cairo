
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