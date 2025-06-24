fn main(p1_age: u32, p2_age: u32, p3_age: u32) {
    let min_age: u32 = 18;
    let max_age: u32 = 60;

    assert((p1_age >= min_age) & (p1_age <= max_age), "Person 1 age out of range");
    assert((p2_age >= min_age) & (p2_age <= max_age), "Person 2 age out of range");
    assert((p3_age >= min_age) & (p3_age <= max_age), "Person 3 age out of range");
}

#[test]
fn test_valid_ages() {
    main(20, 30, 50);
}

//#[test]
//fn test_too_young() {
    // This should fail due to person 1 being underage
  //  main(13, 30, 50);
//}

//#[test]
//fn test_too_old() {
    // This should fail due to person 3 being overage
   // main(20, 30, 75);
//}
