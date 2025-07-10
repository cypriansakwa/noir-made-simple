//Mutating Arrays
fn main() {
let mut arr = [1, 2, 3, 4, 5];  // mutable array
assert(arr[0] == 1);     // initial value is 1
arr[0] = 42;  // mutate: change value at index 0
assert(arr[0] == 42); // confirm new value is 42
}