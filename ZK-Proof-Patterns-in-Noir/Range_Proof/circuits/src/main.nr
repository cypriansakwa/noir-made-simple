struct Inputs {
    age: Field,         // private input
    pub min_age: Field, // public input
}

// Helper: proves x fits in 8 bits, i.e. 0 <= x < 256
fn constrain_unsigned(x: Field) {
    let bits: [u1; 8] = x.to_le_bits();
    let mut reconstructed = 0;
    for i in 0..8 {
        reconstructed += (bits[i] as Field) * ((1 << (i as u8)) as Field);
    }
    assert(x == reconstructed);
}

fn main(inputs: Inputs) {
    // Prove age >= min_age by constraining age - min_age is unsigned (0..255)
    let diff = inputs.age - inputs.min_age;
    constrain_unsigned(diff);

    // Optional: also prove age <= 120 for realistic age bounds
    let max_age = 120;
    let age_diff = max_age - inputs.age;
    constrain_unsigned(age_diff);
}