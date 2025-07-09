fn main(x: pub Field, y: pub Field, z: pub Field) -> pub (Field, Field, Field) {
    let mut v: Vec<Field> = Vec::new();

    v.push(x);
    let pushed1 = v.get(0);

    v.push(y);
    let pushed2 = v.get(1);

    v.push(z);

    let popped = v.pop(); // Keep this if you actually need the popped value.

    // Return only the necessary values.
    (pushed1, pushed2, popped)
}