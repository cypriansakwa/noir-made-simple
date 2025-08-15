// Dummy hash function for testing
pub fn hash(x: Field) -> Field {
    x
}

// Dummy Merkle proof verifier for testing
pub fn verify_merkle_proof(leaf: Field, proof: [Field; 3], root: Field) -> Field {
    1
}