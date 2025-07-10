//Key-Value Lookups in Noir
fn main(key: pub str<8>) -> pub str<8> {
    // Define keys and values as fixed-size arrays
    let keys = ["theme   ", "language"];
    let values = ["dark    ", "en      "];

    // Retrieve the value associated with the user-provided key
    let result = get_value(keys, values, key);

    result
}

fn get_value(keys: [str<8>; 2], values: [str<8>; 2], key: str<8>) -> str<8> {
    let mut result = "        "; // Default empty string (8 chars)
    for i in 0..2 {
        if keys[i] == key {
            result = values[i];
        }
    }
    result
}
