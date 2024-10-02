pragma circom 2.0.0;

// a^6 + 7b(a^2 + b) + 42 = N
template EquationProof() {
    signal input a;
    signal input b;
    signal input N;

    signal a2;
    signal a4;
    signal a6;
    signal a2_plus_b;
    signal b_7;
    signal b_7_a2_plus_b;
    signal res;

    a2 <== a * a;
    a4 <== a2 * a2;
    a6 <== a4 * a2;

    a2_plus_b <== a2 + b;
    b_7 <== 7 * b;
    b_7_a2_plus_b <== b_7 * a2_plus_b;

    res <== a6 + b_7_a2_plus_b + 42;

    N === res;
}

component main {public [N]} = EquationProof();