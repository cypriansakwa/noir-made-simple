struct Inputs {
    coloring: [Field; 5],      // secret colors (0, 1, or 2)
    pub edges_u: [Field; 6],   // public: edge start indices
    pub edges_v: [Field; 6],   // public: edge end indices
}

fn is_valid_color(x: Field) -> Field {
    let c0 = if x == 0 { 1 } else { 0 };
    let c1 = if x == 1 { 1 } else { 0 };
    let c2 = if x == 2 { 1 } else { 0 };
    c0 + c1 + c2
}

fn main(inputs: Inputs) {
    for i in 0..5 {
        assert(is_valid_color(inputs.coloring[i]) == 1);
    }
    for j in 0..6 {
        let u = inputs.edges_u[j] as u32;
        let v = inputs.edges_v[j] as u32;
        assert(u < 5);
        assert(v < 5);
        let color_u = inputs.coloring[u];
        let color_v = inputs.coloring[v];
        assert(color_u != color_v);
    }
}

#[test]
fn valid_3_coloring() {
    let inputs = Inputs {
        coloring: [0, 1, 2, 0, 1],
        edges_u: [0, 1, 2, 3, 0, 4],
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}

#[test(should_fail)]
fn invalid_color_value() {
    let inputs = Inputs {
        coloring: [0, 1, 2, 3, 1],  // 3 is invalid
        edges_u: [0, 1, 2, 3, 0, 4],
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}

#[test(should_fail)]
fn same_color_on_edge_should_fail() {
    let inputs = Inputs {
        coloring: [1, 1, 2, 0, 1], // nodes 0 and 1 have color 1
        edges_u: [0, 1, 2, 3, 0, 4],
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}

#[test(should_fail)]
fn out_of_bounds_index_should_fail() {
    let inputs = Inputs {
        coloring: [0, 1, 2, 0, 1],
        edges_u: [0, 1, 2, 3, 5, 4],  // 5 is out of bounds
        edges_v: [1, 2, 3, 4, 2, 3],
    };
    main(inputs);
}