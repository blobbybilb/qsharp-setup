// QSD Lab 2 Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.

namespace MITRE.QSD.L02 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Random;

    @Test("QuantumSimulator")
    operation E01Test () : Unit {
        for numQubits in 3 .. 10 {
            use qubits = Qubit[numQubits];

            E01_YRotations(qubits);

            for index in 0 .. numQubits - 1 {
                Ry(PI() * IntAsDouble(index) / -12.0, qubits[index]);
            }

            AssertAllZero(qubits);
        }
    }


    @Test("QuantumSimulator")
    operation E02Test () : Unit {
        for i in 0 .. 4 {
            mutable states = [];
            use qubits = Qubit[5];
            for j in 0 .. 4 {
                set states += [DrawRandomInt(0, 1)];
                if states[j] == 1 {
                    X(qubits[j]);
                }
            }

            let results = E02_MeasureQubits(qubits);

            AllEqualityFactI(states, results, "Exercise 2 test failed.");
            ResetAll(qubits);
        }
    }


    @Test("QuantumSimulator")
    operation E03Test () : Unit {
        for numQubits in 1 .. 8 {
            use qubits = Qubit[numQubits];

            E03_PrepareUniform(qubits);

            ApplyToEach(H, qubits);

            AssertAllZero(qubits);
        }
    }


    @Test("QuantumSimulator")
    operation E04Test () : Unit {
        for numQubits in 1 .. 8 {
            use qubits = Qubit[numQubits];

            ApplyToEach(H, qubits);

            E04_PhaseFlipOddTerms(qubits);

            Z(qubits[numQubits - 1]);
            ApplyToEach(H, qubits);

            AssertAllZero(qubits);
        }
    }
}