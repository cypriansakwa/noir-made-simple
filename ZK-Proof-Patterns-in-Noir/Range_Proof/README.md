# Noir Age Range Proof Circuit

This project contains a Noir zero-knowledge circuit for proving that a secret value—such as a person's age—lies within a specified public range, without revealing the value itself.  
It is suitable for use in privacy-preserving applications such as anonymous credential systems, age verification, and decentralized identity.

---

## Features

- **Range Proof**: Proves that `min_age <= age <= max_age` where all values are 8-bit unsigned integers (`0..255`).
- **Private Input**: `age` is a secret input (witness).
- **Public Inputs**: `min_age` and `max_age` are public and parameterizable.
- **Robust Constraints**: Guards against field underflow, wraparound, and invalid input using explicit constraints.
- **Parameterizable**: `max_age` is not hardcoded; set it to fit your application (e.g., 120 for humans).
- **Easy Integration**: Suitable for integration with on-chain or off-chain verifiers.

---

## How It Works

The circuit ensures:
- All inputs (`age`, `min_age`, `max_age`) are in `[0, 255]`.
- `min_age <= age <= max_age` holds.
- Differences (`age - min_age`, `max_age - age`) are non-negative and fit in 8 bits.

This is achieved by decomposing each value and difference into bits and reconstructing to ensure validity, preventing field arithmetic underflow.

---

## Inputs

```text
struct Inputs {
    age: Field,         // Private input (witness)
    pub min_age: Field, // Public input
    pub max_age: Field, // Public input (parameterizable)
}
```

- `age`: The secret value to be proven within the range.
- `min_age`: The inclusive lower bound (public).
- `max_age`: The inclusive upper bound (public).

---

## Usage

1. **Install Noir**  
   Follow instructions at [noir-lang.org](https://noir-lang.org/docs/getting_started/).

2. **Clone this repo**
   ```sh
   git clone https://github.com/cypriansakwa/noir-made-simple.git
   cd noir-made-simple/ZK-Proof-Patterns-in-Noir/Range_Proof/circuits
   ```

3. **Compile the circuit**
   ```sh
   nargo compile
   ```

4. **Test the circuit**
   Edit or add test cases in `/tests` as needed, then:
   ```sh
   nargo test
   ```

5. **Generate a proof**
   Prepare an input JSON file (example below), then:
   ```sh
   nargo prove --inputs input.json
   ```

---

## Example Input

```json
{
  "age": "25",
  "min_age": "18",
  "max_age": "120"
}
```

---

## Security Notes

- All constraints are enforced in-circuit for robustness against field underflow and malicious input.
- For critical or high-value use cases, always obtain an external security audit before deploying in production.
- Parameter constraints (e.g., `min_age` >= 18) can be enforced by uncommenting relevant lines in the circuit.

---

## Customization

- To restrict `min_age` to a lower bound (e.g., adulthood at 18), uncomment the relevant section in `main.nr`:

  ```rust
  let adulthood = 18;
  let min_age_minus_adulthood = inputs.min_age - adulthood;
  constrain_unsigned_u8(min_age_minus_adulthood);
  ```

---

## File Overview

- `src/main.nr` – Noir circuit for the age range proof.
- `README.md` – This documentation.
- `tests/` – (Optional) Test suite for the circuit.

---

## License

MIT or Apache-2.0 (specify as appropriate for your repo).

---

## References

- [Noir documentation](https://noir-lang.org/docs/)
- [Zero-Knowledge Proofs](https://en.wikipedia.org/wiki/Zero-knowledge_proof)