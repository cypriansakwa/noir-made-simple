struct Person {
pub age: u32,
}
		
fn main(p: Person) {
let min_age: u32 = 18;
let max_age: u32 = 60;

assert(p.age >= min_age, "Too young");
assert(p.age <= max_age, "Too old");
}

#[test]
fn test_valid_age() {
let p = Person { age: 30 };
main(p);
}
#[test(should_fail)]
fn test_too_young_should_fail() {
  let p = Person { age: 12 };
main(p); // Should fail due to "Too young"
}
