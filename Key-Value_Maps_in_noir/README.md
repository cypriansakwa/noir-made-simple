# 🔑 Key-Value Mappings in Noir — Lesson Overview

This lesson introduces how to implement and simulate `HashMap`-like structures in Noir using fixed-size arrays. Noir does not have native `HashMap` support, so we use parallel arrays and conditional logic to achieve similar behavior.

## 📚 What This Lesson Covers

- ✅ Definition and motivation for key-value maps in constrained programming
- 🧠 How to simulate mappings using `[str<8>; N]` and `[u8; N]` arrays
- 🔎 Dynamic lookup using a public key input
- 🧮 Counting word occurrences in an array
- ⚙️ Configuration storage with string values
- 🐚 Automation using shell scripts and `Prover.toml`

## 🔧 Key Concepts Demonstrated

| Concept                      | Noir Feature Used                     |
|-----------------------------|----------------------------------------|
| Key-Value Mapping            | Parallel fixed-size arrays             |
| Lookup via Key               | `for` loop + `if` match                |
| User Input                   | Public `str<8>` from `Prover.toml`     |
| Updating/Removing Entries    | Array mutation and overwriting         |
| Frequency Counting           | Custom counters by category            |

## ▶️ How to Run

```bash
# 1. Navigate to an example
cd Some_Lessons/Key-Value_Maps_in_noir/5th_example

# 2. Set your key input (exactly 8 characters) in Prover.toml
echo 'key = "theme   "' > Prover.toml

# 3. Execute the Noir circuit
nargo execute
## 🛠️ Optional: Use Shell Script
```bash
chmod +x run_query.sh
./run_query.sh

```
## 📦 Topics for Practice
- Creating your own lookup for students & grades.
- Simulating value updates and deletions.
- Building word counters from public inputs

> 📎 For full lecture notes, see the [Lecture 112 PDF](https://github.com/cypriansakwa/noir-made-simple/blob/master/Key-Value_Maps_in_noir/Lecture112.pdf)
