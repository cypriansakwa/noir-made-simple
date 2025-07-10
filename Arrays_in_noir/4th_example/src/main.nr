//Mutating Arrays and Printing Values
fn main() {
	let mut arr = [1, 2, 3];  // Original: [1, 2, 3]
	arr[0] = 99;              // Now becomes: [99, 2, 3]
			
	println("Index 0 value:");
	println(arr[0]); // Prints 99
			
	println("Index 2 value:");
	println(arr[2]); // Prints 3
}