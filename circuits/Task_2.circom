pragma circom 2.0.0;

include "../node_modules/circomlib-master/circuits/poseidon.circom";

template Task_2() {
    signal input a;  
    signal input b;  
    signal input c;
    signal input N;

    signal inputs[3];

    inputs[0] <== a;
    inputs[1] <== b;
    inputs[2] <== c;

    component poseidonHash = Poseidon(3);  
    for (var i = 0; i < 3; i++) {
        poseidonHash.inputs[i] <== inputs[i];
    }

    poseidonHash.out === N;
       
}
component main {public [N]} = Task_2();