struct Inputs {
    secret_country: Field,
    pub set0: Field,
    pub set1: Field,
    pub set2: Field,
    pub set3: Field,
    pub set4: Field,
}

fn main(inputs: Inputs) {
    // Compare secret_country to each public set element
    let cond0 = inputs.secret_country == inputs.set0;
    let cond1 = inputs.secret_country == inputs.set1;
    let cond2 = inputs.secret_country == inputs.set2;
    let cond3 = inputs.secret_country == inputs.set3;
    let cond4 = inputs.secret_country == inputs.set4;

    // Convert bools to Fields (0 or 1)
    let cond0_field = if cond0 { 1 } else { 0 };
    let cond1_field = if cond1 { 1 } else { 0 };
    let cond2_field = if cond2 { 1 } else { 0 };
    let cond3_field = if cond3 { 1 } else { 0 };
    let cond4_field = if cond4 { 1 } else { 0 };

    let sum = cond0_field + cond1_field + cond2_field + cond3_field + cond4_field;

    // Enforce that secret_country is in the public set
    assert(sum != 0);
}
// This file assumes it's part of a Noir project with `src/main.nr` containing your main logic

#[test]
fn test_secret_country_in_set() {
    let inputs = Inputs {
        secret_country: 42,
        set0: 1,
        set1: 2,
        set2: 42,
        set3: 4,
        set4: 5,
    };
    main(inputs); // Should succeed (42 is in set2)
}
#[test]
fn test_multiple_matches() {
    let inputs = Inputs {
        secret_country: 99,
        set0: 99,
        set1: 99,
        set2: 1,
        set3: 2,
        set4: 3,
    };
    main(inputs);
}
#[test(should_fail)]
fn test_secret_country_not_in_set_should_fail() {
    // Expected to fail! Useful for checking that assertions catch invalid cases.
    // You can run this with `nargo test --exact test_secret_country_not_in_set_should_fail` to isolate
     let inputs = Inputs {
        secret_country: 77,
        set0: 1,
        set1: 13,
        set2: 42,
        set3: 9,
        set4: 7,
    };
    main(inputs); // Should panic/assert fail
}
