use sha256::sha256;

struct Inputs {
    password: [u8; 16],
    password_hash: [u8; 32],
}

fn main(inputs: Inputs) {
    let computed_hash = sha256(inputs.password);
    assert(computed_hash == inputs.password_hash);
}