// Import standard library
use dep::std;

// The circuit function
fn main(preimage_bytes: [u8; 4], expected_hash: Field) {
    // Step 1: Convert raw bytes into Fields
    let mut preimage_fields: [Field; 4] = [0.into(); 4];
    for i in 0..4 {
        preimage_fields[i] = preimage_bytes[i].into();
    }

    // Step 2: Hash the converted fields
    let computed_hash = std::hash::hash_to_field(preimage_fields);

    // Step 3: Enforce equality
    assert(computed_hash == expected_hash);
}

// -----------------------
// Unit Tests
// -----------------------
#[test]
fn test_preimage_abcd() {
    // "abcd" in ASCII
    let preimage_bytes = [97, 98, 99, 100];
    let mut preimage_fields: [Field; 4] = [0.into(); 4];
    for i in 0..4 {
        preimage_fields[i] = preimage_bytes[i].into();
    }

    let expected_hash = std::hash::hash_to_field(preimage_fields);
    main(preimage_bytes, expected_hash);
}

#[test]
fn test_preimage_wxyz() {
    // "wxyz" in ASCII
    let preimage_bytes = [119, 120, 121, 122];
    let mut preimage_fields: [Field; 4] = [0.into(); 4];
    for i in 0..4 {
        preimage_fields[i] = preimage_bytes[i].into();
    }

    let expected_hash = std::hash::hash_to_field(preimage_fields);
    main(preimage_bytes, expected_hash);
}

#[test]
fn test_preimage_1234() {
    // "1234" in ASCII
    let preimage_bytes = [49, 50, 51, 52];
    let mut preimage_fields: [Field; 4] = [0.into(); 4];
    for i in 0..4 {
        preimage_fields[i] = preimage_bytes[i].into();
    }

    let expected_hash = std::hash::hash_to_field(preimage_fields);
    main(preimage_bytes, expected_hash);
}
