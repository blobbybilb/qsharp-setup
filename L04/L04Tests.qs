// QSD Lab 4 Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.

namespace MITRE.QSD.L04 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    @Test("QuantumSimulator")
    operation E01Test () : Unit {
        let buffers = [
            [false, false],
            [false, true],
            [true, false],
            [true, true]
        ];

        for i in 1 .. 10 {
            for buffer in buffers {
                use qubits = Qubit[2];
                H(qubits[0]);
                CNOT(qubits[0], qubits[1]);

                E01_SuperdenseEncode(buffer, qubits[0]);

                CNOT(qubits[0], qubits[1]);
                H(qubits[0]);

                EqualityFactB(
                    ResultAsBool(M(qubits[0])),
                    buffer[0],
                    "First qubit is incorrect."
                );
                EqualityFactB(
                    ResultAsBool(M(qubits[1])),
                    buffer[1],
                    "Second qubit is incorrect."
                );

                ResetAll(qubits);
            }
        }
    }


    @Test("QuantumSimulator")
    operation E02Test () : Unit {
        let buffers = [
            [false, false],
            [false, true],
            [true, false],
            [true, true]
        ];

        for i in 1 .. 10 {
            for buffer in buffers {
                use qubits = Qubit[2];
                H(qubits[0]);
                CNOT(qubits[0], qubits[1]);
                if buffer[1] {
                    X(qubits[0]);
                }
                if buffer[0] {
                    Z(qubits[0]);
                }

                let result = E02_SuperdenseDecode(qubits[0], qubits[1]);

                AllEqualityFactB(
                    result,
                    buffer,
                    "Decoded value is incorrect."
                );

                ResetAll(qubits);
            }
        }
    }


    @Test("QuantumSimulator")
    operation E03Test () : Unit {
        for i in 0 .. 7 {
            let aPublic = (i / 4 == 1);
            let aSecret = (i / 2 % 2 == 1);
            let bPublic = (i % 2 == 1);
            use qubit = Qubit();
            let result = E03_BB84PartyA(aPublic, aSecret, bPublic, qubit);

            if aPublic { H(qubit); }
            if aSecret { X(qubit); }

            EqualityFactB(
                result,
                (aPublic == bPublic),
                $"Keep/reject value is incorrect."
            );

            AssertAllZero([qubit]);
        }
    }


    @Test("QuantumSimulator")
    operation E04Test () : Unit {
        for i in 0 .. 7 {
            let aPublic = (i / 4 == 1);
            let aSecret = (i / 2 % 2 == 1);
            let bPublic = (i % 2 == 1);
            use qubit = Qubit();
            if aSecret { X(qubit); }
            if aPublic { H(qubit); }

            let (bSecret, keep) = E04_BB84PartyB(aPublic, bPublic, qubit);

            EqualityFactB(
                keep,
                (aPublic == bPublic),
                "Keep/reject value is incorrect."
            );

            if (keep) {
                EqualityFactB(
                    aSecret,
                    bSecret,
                    "Secret bits do not match."
                );
            }

            Reset(qubit);
        }
    }
}
