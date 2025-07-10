fn main(words: pub [str<8>; 6]) -> pub [u8; 3] {
    let mut counts = [0, 0, 0]; // Initialize counts to 0

    for word in words {
        if word == "apple   " {
            counts[0] += 1;
        } else if word == "banana  " {
            counts[1] += 1;
        } else if word == "cherry  " {
            counts[2] += 1;
        }
    }

    counts
}