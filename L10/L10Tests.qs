// QSD Lab 10 Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.

namespace MITRE.QSD.L10 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Random;


    operation GenerateRandomRotation () : Double[] {
        return [
            DrawRandomDouble(0.0, PI()),
            DrawRandomDouble(0.0, 2.0 * PI())
        ];
    }


    operation ApplyRotation (rotation : Double[], target: Qubit) : Unit
    is Adj + Ctl {
        Rx(rotation[0], target);
        Rz(rotation[1], target);
    }


    @Test("QuantumSimulator")
    operation E01Test () : Unit {
        for i in 1 .. 25 {
            use (original, spares) = (Qubit(), Qubit[2]);
            let rotation = GenerateRandomRotation();
            ApplyRotation(rotation, original);

            E01_BitFlipEncode(original, spares);

            CNOT(original, spares[0]);
            CNOT(original, spares[1]);
            Adjoint ApplyRotation(rotation, original);

            AssertAllZero([original] + spares);
        }
    }


    @Test("QuantumSimulator")
    operation E02Test () : Unit {
        for i in 1 .. 10 {
            for brokenQubitIndex in -1 .. 3 {
                use register = Qubit[3];
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, register[0]);
                E01_BitFlipEncode(register[0], register[1 .. 2]);

                // no error
                if (brokenQubitIndex == -1) {
                    mutable syndrome = E02_BitFlipSyndrome(register);
                    if syndrome[0] != Zero or syndrome[1] != Zero {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [Zero, Zero] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                // first qubit is flipped
                elif (brokenQubitIndex == 0) {
                    X(register[0]);
                    mutable syndrome = E02_BitFlipSyndrome(register);
                    if syndrome[0] != One or syndrome[1] != One {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [One, One] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                // second qubit is flipped
                elif (brokenQubitIndex == 1) {
                    X(register[1]);
                    mutable syndrome = E02_BitFlipSyndrome(register);
                    if syndrome[0] != One or syndrome[1] != Zero {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [One, Zero] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                // third qubit is flipped
                elif (brokenQubitIndex == 1) {
                    X(register[2]);
                    mutable syndrome = E02_BitFlipSyndrome(register);
                    if syndrome[0] != Zero or syndrome[1] != One {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [Zero, One] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                ResetAll(register);
            }
        }
    }


    @Test("QuantumSimulator")
    operation E03Test () : Unit {
        for i in 1 .. 10 {
            for brokenQubitIndex in -1 .. 2 {
                use register = Qubit[3];
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, register[0]);
                E01_BitFlipEncode(register[0], register[1 .. 2]);

                if brokenQubitIndex >= 0 {
                    X(register[brokenQubitIndex]);
                }

                let syndrome = E02_BitFlipSyndrome(register);

                E03_BitFlipCorrection(register, syndrome);

                Adjoint E01_BitFlipEncode(register[0], register[1 .. 2]);
                Adjoint ApplyRotation(rotation, register[0]);

                AssertAllZero(register);
            }
        }
    }


    @Test("QuantumSimulator")
    operation E04Test () : Unit {
        use (original, spares) = (Qubit(), Qubit[6]);

        for i in 1 .. 10 {
            let rotation = GenerateRandomRotation();
            ApplyRotation(rotation, original);

            E04_SteaneEncode(original, spares);

            ApplyToEach(CNOT(spares[3], _), spares[0 .. 2]);
            ApplyToEach(CNOT(spares[4], _), [original] + spares[1 .. 2]);
            ApplyToEach(CNOT(spares[5], _), [original, spares[0], spares[2]]);
            ApplyToEach(CNOT(original, _), spares[0 .. 1]);
            ApplyToEach(H, spares[3 .. 5]);

            Adjoint ApplyRotation(rotation, original);

            AssertAllZero([original] + spares);
        }
    }


    @Test("QuantumSimulator")
    operation E05Test () : Unit {
        use qubits =  Qubit[7];

        for i in 1 .. 10 {
            for brokenIndex in -1 .. 6 {
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, qubits[0]);

                E04_SteaneEncode(qubits[0], qubits[1 .. 6]);

                if brokenIndex >= 0 {
                    X(qubits[brokenIndex]);
                }

                let syndrome = E05_SteaneBitSyndrome(qubits);

                if ((brokenIndex + 1) &&& 0b100) == 0b100 {
                    EqualityFactR(
                        syndrome[0],
                        One,
                        "Bit-flip syndrome measurment 0 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b010) == 0b010 {
                    EqualityFactR(
                        syndrome[1],
                        One,
                        "Bit-flip syndrome measurement 1 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b001) == 0b001 {
                    EqualityFactR(
                        syndrome[2],
                        One,
                        "Bit-flip syndrome measurement 2 is incorrect"
                    );
                }

                ResetAll(qubits);
            }
        }
    }


    @Test("QuantumSimulator")
    operation E06Test () : Unit {
        use qubits = Qubit[7];

        for i in 1 .. 10 {
            for brokenIndex in -1 .. 6 {
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, qubits[0]);

                E04_SteaneEncode(qubits[0], qubits[1 .. 6]);

                if brokenIndex >= 0 {
                    Z(qubits[brokenIndex]);
                }

                let syndrome = E06_SteanePhaseSyndrome(qubits);

                if ((brokenIndex + 1) &&& 0b100) == 0b100 {
                    EqualityFactR(
                        syndrome[0],
                        One,
                        "Phase-flip syndrome measurment 0 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b010) == 0b010 {
                    EqualityFactR(
                        syndrome[1],
                        One,
                        "Phase-flip syndrome measurement 1 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b001) == 0b001 {
                    EqualityFactR(
                        syndrome[2],
                        One,
                        "Phase-flip syndrome measurement 2 is incorrect"
                    );
                }

                ResetAll(qubits);
            }
        }
    }


    @Test("QuantumSimulator")
    operation E07Test () : Unit {
        for brokenIndex in -1 .. 6 {
            let syndrome = [
                ((brokenIndex + 1) &&& 0b100) == 0b100 ? One | Zero,
                ((brokenIndex + 1) &&& 0b010) == 0b010 ? One | Zero,
                ((brokenIndex + 1) &&& 0b001) == 0b001 ? One | Zero
            ];
            EqualityFactI(
                E07_SyndromeToIndex(syndrome),
                brokenIndex,
                $"Incorrect broken index for syndrome {syndrome}"
            );
        }
    }


    @Test("QuantumSimulator")
    operation E08Test () : Unit {
        use qubits = Qubit[7];

        for i in 1 .. 10 {
            for bitFlipIndex in -1 .. 6 {
                for phaseFlipIndex in -1 .. 6 {
                    let rotation = GenerateRandomRotation();
                    ApplyRotation(rotation, qubits[0]);

                    E04_SteaneEncode(qubits[0], qubits[1 .. 6]);

                    if bitFlipIndex >= 0 {
                        X(qubits[bitFlipIndex]);
                    }

                    if phaseFlipIndex >= 0 {
                        Z(qubits[phaseFlipIndex]);
                    }

                    E08_SteaneCorrection(qubits);

                    Adjoint E04_SteaneEncode(qubits[0], qubits[1 .. 6]);
                    Adjoint ApplyRotation(rotation, qubits[0]);

                    AssertAllZero(qubits);
                }
            }
        }
    }
}
