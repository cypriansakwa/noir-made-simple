fn main(key: pub str<8>) -> pub u8 {
    // Step 1: Static key-value arrays
    let keys = ["apple   ", "banana  "]; // Each key must be exactly 8 characters
    let mut values = [2, 5];
    values[1] = 0; // Simulate removing "banana"
    // Step 2: Lookup the value associated with the dynamic key
    let result = get_value(keys, values, key);

    // Step 3: Return result (no longer a constant)
    result
}

fn get_value(keys: [str<8>; 2], values: [u8; 2], key: str<8>) -> u8 {
    let mut result = 0;
    for i in 0..2 {
        if keys[i] == key {
            result = values[i];
        }
    }
    result
}
