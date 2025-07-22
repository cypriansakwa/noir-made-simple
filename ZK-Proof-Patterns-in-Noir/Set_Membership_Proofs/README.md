# Noir Circuit: Prove Membership in a Public Set

This project contains a simple Noir circuit that allows a user to prove in zero-knowledge that their **secret country code** belongs to a set of public country codes. The secret is **never revealed**, but the proof will only succeed if the secret is in the set.

## How it Works

- **Inputs**
  - `secret_country`: The country code to prove membership for (kept secret).
  - `set0`–`set4`: Five public country codes (the set).

- **Logic**
  - The circuit checks if `secret_country` matches **any** of the five public set values.
  - It asserts that there is at least one match.
  - If `secret_country` is not in the set, proof generation fails.

## Example

Suppose the public set is `{1, 2, 42, 4, 5}` and your secret is `42`:

- Proof succeeds: `42` is in the set.
- If the secret is `7`, proof fails (not in set).

## Code

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
```

## Tests

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
    main(inputs); // Succeeds: 42 is in the set
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
    main(inputs); // Succeeds: 99 matches set0 and set1
}

#[test(should_fail)]
fn test_secret_country_not_in_set_should_fail() {
    let inputs = Inputs {
        secret_country: 77,
        set0: 1,
        set1: 13,
        set2: 42,
        set3: 9,
        set4: 7,
    };
    main(inputs); // Fails: 77 is not in the set
}
```

## Usage

1. **Define your secret and public set.**
2. Prove that your secret is in the set without revealing it.
3. Verifiers can check the proof using the public set only.

## Run the Tests

```sh
nargo test
```

## Applications

- Prove membership in a whitelist (e.g., allowed regions, group access)
- Voting systems (is this vote for a valid candidate?)
- Any scenario where you want to keep a value private but demonstrate set membership

---

**Built with [Noir](https://noir-lang.org/)** 🦄
To run the command build.sh in your terminal first make executable:
```bash
chmod +x build.sh
```
### Installation / Setup

```bash
# Foundry
git submodule update

# Build circuits, generate verifier contract
(cd circuits && ./build.sh)

# Install JS dependencies
(cd js && yarn)
```

### Proof Generation in JS

```bash
# Use bb.js to generate proof and save to a file
(cd js && yarn generate-proof)

# Run Foundry test to verify the generated proof
(cd contract && forge test --optimize --optimizer-runs 5000 --gas-report -vvv)
```

### Proof Generation with bb CLI

```bash
# Generate witness
nargo execute

# Generate proof with keccak hash
bb prove -b ./target/Set_Membership_Proofs.json -w target/Set_Membership_Proofs.gz -o ./target --oracle_hash keccak

# Run Foundry test to verify proof
cd ..
(cd contract && forge test --optimize --optimizer-runs 5000 --gas-report -vvv)
```