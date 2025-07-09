// Noir example: Demonstrating common Vec<T> operations
		
// Noir: Vec<T> operations demo
fn main() {
	// Create a new mutable vector of Field elements
	let mut v: Vec<Field> = Vec::new();
	
	// Add elements to the vector
	v.push(10);
	v.push(20);
	v.push(30);
	
	// Length after push
	let length_after_push = v.len();
	assert(length_after_push == 3);
	
	// Pop the last element (returns Field, not Option)
	let last = v.pop();
	assert(last == 30);
	
	// Length after pop
	let length_after_pop = v.len();
	assert(length_after_pop == 2);
	
	// Safely access elements using .get(), which returns a Field
	assert(v.len() == 2);
	let first = v.get(0);
	let second = v.get(1);
	assert(first == 10);
	assert(second == 20);
	
	// Sum the remaining elements
	let sum = first + second;
	assert(sum == 30);
}