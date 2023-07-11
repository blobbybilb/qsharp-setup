// QSD Lab 6 Q# Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.


namespace MITRE.QSD.L06 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;


    @Test("QuantumSimulator")
    operation E01Test () : Unit {
        for numQubits in 3 .. 10 {
            mutable randomInput = [];
            for i in 1 .. numQubits {
                set randomInput += [DrawRandomBool(0.5)];
            }

            let copyOutput = E01_RunOpAsClassicalFunc(Copy, randomInput);
            AllEqualityFactB(
                copyOutput,
                randomInput,
                "Incorrect output for Copy operation"
            );

            let shiftOutput = E01_RunOpAsClassicalFunc(
                LeftShiftBy1,
                randomInput
            );
            let expected = randomInput[1...] + [false];
            AllEqualityFactB(
                shiftOutput,
                expected,
                "Incorrect output for LeftShiftBy1 operation"
            );
        }
    }
}
