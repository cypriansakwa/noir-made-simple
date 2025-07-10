//Testing Array Access in Noir
//Passing Test
#[test]
fn test_array_access_pass() {
	let a = [1, 2, 3, 4];
	let x = a[0];
	assert(x == 1); // This passes
}

//Failing Test:
// This test is expected to fail.
#[test(should_fail)]
fn test_array_access_fail() {
	let a = [1, 2, 3, 4];
	let x = a[1];
	assert(x == 1); // This fails
}