// QSD Lab 5 Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.

namespace MITRE.QSD.L05 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;

    @Test("QuantumSimulator")
    operation E01Test () : Unit {
        for numQubits in 3 .. 8 {
            use (input, output) = (Qubit[numQubits], Qubit());
            ApplyToEach(H, input);
            X(output);

            E01_PhaseFlipOnOdd1s(input, output);

            for qubit in input {
              Controlled Z([qubit], output);
            }
            X(output);
            ApplyToEach(H, input);

            AssertAllZero(input + [output]);
        }
    }


    @Test("QuantumSimulator")
    operation E02Test () : Unit {
        for i in 1 .. 10 {
            for numQubits in 3 .. 8 {
                use (input, output) = (Qubit[numQubits], Qubit());
                let firstIndex = DrawRandomInt(0, numQubits - 1);
                let temp = DrawRandomInt(0, numQubits - 2);
                let secondIndex = firstIndex != temp ? temp | temp + 1;

                ApplyToEach(H, input);
                X(output);

                E02_PhaseFlipOnOddParity(
                    firstIndex,
                    secondIndex,
                    input,
                    output
                );

                Controlled Z([input[firstIndex]], output);
                Controlled Z([input[secondIndex]], output);
                X(output);
                ApplyToEach(H, input);

                AssertAllZero(input + [output]);
            }
        }
    }


    @Test("QuantumSimulator")
    operation E03Test () : Unit {
        for i in 0 .. 10 {
            for numQubits in 3 .. 8 {
                let firstIndex = DrawRandomInt(0, numQubits - 1);
                    let temp = DrawRandomInt(0, numQubits - 2);
                    let secondIndex = firstIndex != temp ? temp | temp + 1;

                if E03_DeutschJozsa(numQubits, AlwaysZero) == false {
                    fail "Incorrectly classified AlwaysZero as balanced.";
                }

                if E03_DeutschJozsa(numQubits, AlwaysOne) == false {
                    fail "Incorrectly classified AlwaysOne as balanced.";
                }

                if E03_DeutschJozsa(numQubits, E01_PhaseFlipOnOdd1s) == true {
                    fail "Incorrectly classified E01 as constant.";
                }

                if E03_DeutschJozsa(
                    numQubits,
                    E02_PhaseFlipOnOddParity(firstIndex, secondIndex, _, _)
                ) == true {
                    fail "Incorrectly classified E02 as constant.";
                }
            }
	    }
    }
}
