pragma circom 2.0.0;

include "../node_modules/circomlib-master/circuits/comparators.circom";

template SudokuVerifier() {
    signal input solution[9][9];
    signal input initial[9][9];

    component checkLower[9][9];
    component checkUpper[9][9];

    for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
            checkLower[i][j] = LessThan(9);
            checkLower[i][j].in[0] <== 0;
            checkLower[i][j].in[1] <== solution[i][j];
            
            checkUpper[i][j] = LessThan(9);
            checkUpper[i][j].in[0] <== solution[i][j];
            checkUpper[i][j].in[1] <== 10;

            1 === checkLower[i][j].out * checkUpper[i][j].out;


            0 === initial[i][j] * (solution[i][j] - initial[i][j]);
        }
        
    }

    component rowUnique[9];
    component colUnique[9];
    component blockUnique[3][3];

    for (var i = 0; i < 9; i++) {
        rowUnique[i] = Unique(9);
        for (var j = 0; j < 9; j++) {
            rowUnique[i].in[j] <== solution[i][j];
        }
    }

    for (var j = 0; j < 9; j++) {
        colUnique[j] = Unique(9);
        for (var i = 0; i < 9; i++) {
            colUnique[j].in[i] <== solution[i][j];
        }
    }

    for (var bi = 0; bi < 3; bi++) {
        for (var bj = 0; bj < 3; bj++) {
            blockUnique[bi][bj] = Unique(9);
            var idx = 0;
            for (var i = 0; i < 3; i++) {
                for (var j = 0; j < 3; j++) {
                    blockUnique[bi][bj].in[idx] <== solution[bi * 3 + i][bj * 3 + j];
                    idx++;
                }
            }
        }
    }
}

template Unique(n) {
    signal input in[n];

    component isEqual[n][n];
    for (var i = 0; i < n; i++) {
        for (var j = 0; j < n; j++) {
            isEqual[i][j] = IsEqual();
            isEqual[i][j].in[0] <== in[i];
            isEqual[i][j].in[1] <== in[j];
            if (i != j) {
                0 === isEqual[i][j].out;
            }
        }
    }
}
component main { public [initial]}= SudokuVerifier();
