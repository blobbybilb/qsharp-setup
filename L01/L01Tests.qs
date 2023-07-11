// QSD Lab 1 Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.

namespace MITRE.QSD.L01 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;


    @Test("QuantumSimulator")
    operation E01Test () : Unit {
        use target = Qubit();

        E01_BitFlip(target);

        X(target);

        AssertQubit(Zero, target);
    }


    @Test("QuantumSimulator")
    operation E02Test () : Unit {
        use targets = Qubit[2];

        E02_PrepPlusMinus(targets[0], targets[1]);

        H(targets[0]);
        H(targets[1]);
        X(targets[1]);

        AssertAllZero(targets);
    }
}
