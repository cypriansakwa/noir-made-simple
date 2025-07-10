// Vectors and Public Outputs in Noir
fn main(x: pub Field) -> pub Field {
    let mut v: Vec<Field> = Vec::new();
    v.push(x);       // Now vector depends on public input
    v.push(20);
    v.push(30);

    let _ = v.pop();
    let first = v.get(0);
    let second = v.get(1);
    let sum = first + second;

    sum
}
