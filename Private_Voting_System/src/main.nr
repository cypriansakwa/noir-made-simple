fn main(
    vote: Field,
    secret: Field,
    merkle_proof: [Field; 3],
    merkle_root: Field
) {
    assert(vote * (vote - 1) == 0);
    assert(verify_merkle_proof(hash(secret), merkle_proof, merkle_root) == 1);
}