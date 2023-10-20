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
    assert(option_cible.unwrap() == 'Starkpilling', 'err1');
    ('option est vide !').print();
}