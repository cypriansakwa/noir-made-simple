# Noir Circuit: Zero-Knowledge Proof of Valid 3-Coloring for a Graph

This project contains a Noir circuit that allows a user to prove in zero-knowledge that they know a **valid 3-coloring** of a given graph. The coloring remains **secret**—the proof only succeeds if every node is colored with one of three colors and no edge connects nodes of the same color.

---

## How it Works

- **Inputs**
  - `coloring`: An array of 5 secret node colors (each 0, 1, or 2).
  - `edges_u`, `edges_v`: Two public arrays of 6 edge endpoints (node indices), defining the graph structure.

- **Logic**
  - The circuit checks that every node color is 0, 1, or 2.
  - It asserts that for every edge, the connected nodes have different colors.
  - If any color is invalid or any edge connects nodes of the same color, proof generation fails.

## Example

Suppose your graph is a pentagon (cycle of 5 nodes):

- Edges: (0,1), (1,2), (2,3), (3,4), (0,2), (4,3)
- Secret coloring: `[0, 1, 2, 0, 1]`

- Proof succeeds: All nodes have valid colors, and no edge connects nodes of the same color.
- If you use an invalid coloring (e.g. two adjacent nodes share the same color), proof fails.

## Code

```rust
struct Inputs {
    coloring: [Field; 5],      // secret colors (0, 1, or 2)
    pub edges_u: [Field; 6],   // public: edge start indices
    pub edges_v: [Field; 6],   // public: edge end indices
}

fn is_valid_color(x: Field) -> Field {
    let c0 = if x == 0 { 1 } else { 0 };
    let c1 = if x == 1 { 1 } else { 0 };
    let c2 = if x == 2 { 1 } else { 0 };
    c0 + c1 + c2
}

fn main(inputs: Inputs) {
    for i in 0..5 {
        assert(is_valid_color(inputs.coloring[i]) == 1);
    }
    for j in 0..6 {
        let u = inputs.edges_u[j] as u32;
        let v = inputs.edges_v[j] as u32;
        assert(u < 5);
        assert(v < 5);
        let color_u = inputs.coloring[u];
        let color_v = inputs.coloring[v];
        assert(color_u != color_v);
    }
}
```

## Tests

```rust
#[test]
fn valid_3_coloring() {
    let inputs = Inputs {
        coloring: [0, 1, 2, 0, 1],
        edges_u: [0, 1, 2, 3, 0, 4],
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}

#[test(should_fail)]
fn invalid_color_value() {
    let inputs = Inputs {
        coloring: [0, 1, 2, 3, 1],  // 3 is invalid
        edges_u: [0, 1, 2, 3, 0, 4],
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}

#[test(should_fail)]
fn same_color_on_edge_should_fail() {
    let inputs = Inputs {
        coloring: [1, 1, 2, 0, 1], // nodes 0 and 1 have color 1
        edges_u: [0, 1, 2, 3, 0, 4],
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}

#[test(should_fail)]
fn out_of_bounds_index_should_fail() {
    let inputs = Inputs {
        coloring: [0, 1, 2, 0, 1],
        edges_u: [0, 1, 2, 3, 5, 4],  // 5 is out of bounds
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}
```

---

## Usage

1. **Define your secret coloring and graph edges.**
2. Prove that your coloring is valid (no adjacent nodes share the same color, all colors are in {0,1,2}) without revealing your coloring.
3. Verifiers can check the proof using only the public graph structure.

## Run the Tests

```sh
nargo test
```

## Applications

- Prove knowledge of a valid graph coloring without revealing it
- Zero-knowledge puzzles and games
- Secure cryptographic protocols (e.g., anonymous credentials)
- Demonstrate combinatorial property satisfaction privately

---

**Built with [Noir](https://noir-lang.org/)** 🦄

---

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
bb prove -b ./target/noir_3_colorable_graph_zkp.json -w target/noir_3_colorable_graph_zkp.gz -o ./target --oracle_hash keccak


# Run Foundry test to verify proof
cd ..
(cd contract && forge test --optimize --optimizer-runs 5000 --gas-report -vvv)
```