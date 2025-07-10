# Some_Lessons — Noir Examples for Teaching ZK

This repository is **under active development** as part of an ongoing teaching series on zero-knowledge programming using [Noir](https://noir-lang.org/).

It contains structured examples and small projects aimed at helping students and new developers understand key concepts in Noir, especially through interactive lessons and practical circuits.

## 📚 Topics (In Progress)

This repository is being developed progressively as part of an active teaching series. Current folders include:

- `Arrays_in_noir`: Working with fixed-size arrays.
- `Vectors_in_noir`: Exploring dynamic vectors and their constraints.
- `Structs_and_Arrays`: Using custom structs with arrays.
- `Key-Value_Maps_in_noir`: Simulating mappings using parallel arrays.

New topics are added regularly as the lessons progress.

Each topic includes:
- Noir circuits (`main.nr`)
- Example inputs via `Prover.toml`
- Automation scripts (e.g., for padded input)
- Beamer slides for classroom instruction

## 🚀 How to Use

```bash
cd Some_Lessons/<example_folder>
nargo compile
nargo execute
```
