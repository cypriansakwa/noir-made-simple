# Zero-Knowledge Proof Patterns in Noir

This repository demonstrates common zero-knowledge proof (ZKP) patterns using [Noir](https://noir-lang.org/). These patterns let you prove facts about secret data without revealing the data itself.

---

## What is a Zero-Knowledge Proof (ZKP)?

A Zero-Knowledge Proof is a cryptographic protocol that lets a prover convince a verifier that a statement is true—**without revealing any additional information**.  
For example:
- Prove you know a password, without revealing the password.
- Prove you are over 18, without revealing your actual age.

### Key Properties
- **Completeness**: True statements can always be verified.
- **Soundness**: False statements cannot be faked.
- **Zero-Knowledge**: No extra information reveals except the truth of the statement.

---

## ZKP Patterns in This Repository

- **Set Membership Proofs**: Prove a secret value is in a known set (e.g. country whitelisting) without revealing which one.
- **Range Proofs**: Prove a secret is within a range (e.g. age ≥ 18) without revealing the exact value.
- **Password Verification**: Prove you know a password by showing knowledge of its hash, without revealing the password itself.

---

## Example: Set Membership Proof in Noir

```rust
struct Inputs {
    secret_country: Field,
    pub set0: Field,
    pub set1: Field,
    pub set2: Field,
    pub set3: Field,
    pub set4: Field,
}

fn main(inputs: Inputs) {
    let cond0 = inputs.secret_country == inputs.set0;
    let cond1 = inputs.secret_country == inputs.set1;
    let cond2 = inputs.secret_country == inputs.set2;
    let cond3 = inputs.secret_country == inputs.set3;
    let cond4 = inputs.secret_country == inputs.set4;

    // Convert bools to Fields
    let cond0_field = if cond0 { 1 } else { 0 };
    let cond1_field = if cond1 { 1 } else { 0 };
    let cond2_field = if cond2 { 1 } else { 0 };
    let cond3_field = if cond3 { 1 } else { 0 };
    let cond4_field = if cond4 { 1 } else { 0 };

    let sum = cond0_field + cond1_field + cond2_field + cond3_field + cond4_field;
    assert(sum != 0); // Passes if secret_country is in the set
}
```

### Example Tests

```rust
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
    main(inputs); // Passes: 42 is in the set
}

#[test(should_fail)]
fn test_secret_country_not_in_set_should_fail() {
    let inputs = Inputs {
        secret_country: 99,
        set0: 1,
        set1: 2,
        set2: 3,
        set3: 4,
        set4: 5,
    };
    main(inputs); // Fails: 99 is not in the set
}
```

---

## Example: Range Proof in Noir

```rust
struct Inputs {
    age: Field,
    pub min_age: Field,
}

fn main(inputs: Inputs) {
    let diff = inputs.age - inputs.min_age;
    // Prove diff is unsigned 8 bits (i.e., age >= min_age)
    let bits: [u1; 8] = diff.to_le_bits();
    let mut reconstructed = 0;
    for i in 0..8 {
        reconstructed += (bits[i] as Field) * ((1 << (i as u8)) as Field);
    }
    assert(diff == reconstructed);
}
```

---

## How to Run

1. Install [Noir](https://noir-lang.org/docs/getting-started/installation).
2. Clone this repository.
3. Run `nargo test` to execute all example tests.

---

## Use Cases

- Proving citizenship from a list of allowed countries
- Age verification for restricted services
- Proving an asset is whitelisted
- Password authentication without revealing the password

---

## References

- [Noir Documentation](https://noir-lang.org/docs/)
- [Zero-Knowledge Proof (Wikipedia)](https://en.wikipedia.org/wiki/Zero-knowledge_proof)
