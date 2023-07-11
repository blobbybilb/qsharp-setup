// QSD Lab 11 Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.

namespace MITRE.QSD.L11 {

    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;

    
    @Test("QuantumSimulator")
    operation E01FullTest () : Unit {
        use qubits = Qubit[2];

        Message($"Testing 2 qubits with secondTerm=3");

        E01_PrepareTwoTermState(3, LittleEndian(qubits));

        // expect |00> + |11>
        CNOT(qubits[0], qubits[1]);
        H(qubits[0]);

        AssertAllZero(qubits);
    }


    @Test("SparseSimulator")
    operation E01SparseTest () : Unit {
        let MAX_TRIALS = 100;
        for numQubits in 10 .. 10 .. 50 {
            let secondTerm = DrawRandomInt(1, 1 <<< numQubits - 1);
            use qubits = Qubit[numQubits];
            let register = LittleEndian(qubits);

            Message($"Testing {numQubits} qubits with secondTerm={secondTerm}");

            mutable foundZero = false;
            mutable foundSecondTerm = false;
            mutable trial = 1;
            repeat {
                if trial > MAX_TRIALS {
                    fail "Max trials reached";
                }

                E01_PrepareTwoTermState(secondTerm, register);

                let result = MeasureInteger(register);
                Message($"Trial {trial}: measured {result}");

                if result == 0 {
                    set foundZero = true;
                } elif result == secondTerm {
                    set foundSecondTerm = true;
                } else {
                    fail "Incorrect measurement result";
                }

                set trial += 1;
            }
            until foundZero and foundSecondTerm;
        }
    }


    @Test("QuantumSimulator")
    operation E02FullTest () : Unit {
        use qubits = Qubit[2];

        // prepare |10> + |01>
        H(qubits[0]);
        X(qubits[1]);
        CNOT(qubits[0], qubits[1]);

        Message("Testing with input state 1/√2(|1>+|2>)");

        E02_IncrementByOne(LittleEndian(qubits));

        // expect |01> + |11>
        H(qubits[0]);
        X(qubits[1]);
        AssertAllZero(qubits);
    }


    @Test("ToffoliSimulator")
    operation E02ToffoliTest () : Unit {
        for numQubits in 10 .. 10 .. 50 {
            let valueToIncrement = DrawRandomInt(1, 1 <<< numQubits - 1);
            use qubits = Qubit[numQubits];
            let register = LittleEndian(qubits);

            ApplyXorInPlace(valueToIncrement, register);
            
            Message($"Testing with input state |{valueToIncrement}>");

            E02_IncrementByOne(register);

            let result = MeasureInteger(register);
            EqualityFactI(
                result,
                valueToIncrement + 1,
                "Incorrect measurement result"
            );
        }
    }


    operation E03TooManyQubitsTest () : Unit {
        // This test is designed to fail if E03 allocates too many qubits for
        // the full simulator to handle.
        within {
            AllowAtMostNQubits(29, "Too many qubits allocated");
        } apply {
            E03_ImpossibleToSimulate();
        }
    }
}
