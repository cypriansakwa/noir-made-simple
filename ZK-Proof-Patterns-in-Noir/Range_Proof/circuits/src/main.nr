// Range proof circuit: proves min_age <= age <= max_age, all in [0,255]

struct Inputs {
    age: Field,         // private input (witness)
    pub min_age: Field, // public input (parameterizable)
    pub max_age: Field, // public input (parameterizable)
}

// Ensures x is in [0, 255]
fn constrain_unsigned_u8(x: Field) {
    let bits: [u1; 8] = x.to_le_bits();
    let mut reconstructed = 0;
    for i in 0..8 {
        reconstructed += (bits[i] as Field) * ((1 << (i as u8)) as Field);
    }
    assert(x == reconstructed, "x is not an unsigned 8-bit value");
}

fn main(inputs: Inputs) {
    // All values must be in [0,255]
    constrain_unsigned_u8(inputs.max_age);
    constrain_unsigned_u8(inputs.min_age);
    constrain_unsigned_u8(inputs.age);

    // Ensure min_age <= max_age
    let min_max_diff = inputs.max_age - inputs.min_age;
    constrain_unsigned_u8(min_max_diff);

    // Ensure age >= min_age
    let age_minus_min = inputs.age - inputs.min_age;
    constrain_unsigned_u8(age_minus_min);

    // Ensure age <= max_age
    let max_minus_age = inputs.max_age - inputs.age;
    constrain_unsigned_u8(max_minus_age);

    // Optional: enforce adulthood lower bound
    // let adulthood = 18;
    // let min_age_minus_adulthood = inputs.min_age - adulthood;
    // constrain_unsigned_u8(min_age_minus_adulthood);
}

// tests/range_proof_valid_tests.nr

#[test]
fn test_valid_age_within_range() {
    let inputs = Inputs {
        age: 25,
        min_age: 18,
        max_age: 30,
    };
    main(inputs);
}

#[test]
fn test_valid_age_equals_min() {
    let inputs = Inputs {
        age: 18,
        min_age: 18,
        max_age: 65,
    };
    main(inputs);
}

#[test]
fn test_valid_age_equals_max() {
    let inputs = Inputs {
        age: 65,
        min_age: 18,
        max_age: 65,
    };
    main(inputs);
}

#[test]
fn test_full_bounds_edge_case() {
    let inputs = Inputs {
        age: 255,
        min_age: 0,
        max_age: 255,
    };
    main(inputs);
}
// tests/range_proof_invalid_tests.nr

#[test(should_fail)]
fn test_age_below_min_should_fail() {
    let inputs = Inputs {
        age: 17,
        min_age: 18,
        max_age: 65,
    };
    // Expected to fail
    main(inputs);
}

#[test(should_fail)]
fn test_age_above_max_should_fail() {
    let inputs = Inputs {
        age: 70,
        min_age: 18,
        max_age: 65,
    };
    // Expected to fail
    main(inputs);
}

#[test(should_fail)]
fn test_min_above_max_should_fail() {
    let inputs = Inputs {
        age: 50,
        min_age: 70,
        max_age: 65,
    };
    // Expected to fail
    main(inputs);
}

#[test(should_fail)]
fn test_value_above_255_should_fail() {
    let inputs = Inputs {
        age: 300,
        min_age: 0,
        max_age: 255,
    };
    // Expected to fail (age is not a valid u8)
    main(inputs);
}
