// Intro to Quantum Software Development
// Lab 10: Quantum Error Correction
// Copyright 2023 The MITRE Corporation. All Rights Reserved.

namespace MITRE.QSD.L10 {

    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    /// # Summary
    /// In this exercise, you are provided with an original qubit in an
    /// unknown state a|0> + b|1>. You are also provided with two blank
    /// qubits, both of which are in the |0> state. Your goal is to construct
    /// a "logical qubit" from these three qubits that acts like a single
    /// qubit, but can protect against bit-flip errors on any one of the three
    /// actual qubits.
    ///
    /// To construct the logical qubit, put the three qubits into the
    /// entangled state a|000> + b|111>.
    ///
    /// # Input
    /// ## original
    /// A qubit that you want to protect from bit flips. It will be in the
    /// state a|0> + b|1>.
    ///
    /// ## spares
    /// A register of two spare qubits that you can use to add error
    /// correction to the original qubit. Both are in the |0> state.
    operation E01_BitFlipEncode (
        original : Qubit,
        spares : Qubit[]
    ) : Unit is Adj {
        // Note the "Unit is Adj" - this is special Q# syntax that lets the
        // compiler automatically generate the adjoint (inverse) version of
        // this operation, so it can just be run backwards to decode the
        // logical qubit back into the original three unentangled qubits.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with a logical qubit, represented
    /// by an error-protected register that was encoded with your Exercise 1
    /// implementation. Your goal is to perform a syndrome measurement on the
    /// register. This should consist of two parity checks (a parity check is
    /// an operation to see whether or not two qubits have the same state).
    /// The first parity check should be between qubits 0 and 1, and the 
    /// second check should be between qubits 0 and 2.
    ///
    /// # Input
    /// ## register
    /// A three-qubit register representing a single error-protected logical
    /// qubit. Its state is unknown, and one of the qubits may have suffered
    /// a bit flip error.
    ///
    /// # Output
    /// An array of two measurement results. The first result should be the
    /// measurement of the parity check on qubits 0 and 1, and the second
    /// result should be the measurement of the parity check on qubits 0 and
    /// 2. If both qubits in a parity check have the same state, the resulting
    /// bit should be Zero. If the two qubits have different states (meaning
    /// one of the two qubits was flipped), the result should be One.
    operation E02_BitFlipSyndrome (register : Qubit[]) : Result[] {
        // Hint: You will need to allocate an ancilla qubit for this. You can
        // do it with only one ancilla qubit, but you can allocate two if it
        // makes things easier. Don't forget to reset the qubits you allocate
        // back to the |0> state!

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with a logical qubit encoded with
    /// your Exercise 1 implementation and a syndrome measurement array
    /// produced by your Exercise 2 implementation. Your goal is to interpret
    /// the syndrome measurement to find which qubit in the error-corrected
    /// register suffered a bit-flip error (if any), and to correct it by
    /// flipping it back to the proper state.
    ///
    /// # Input
    /// ## register
    /// A three-qubit register representing a single error-protected logical
    /// qubit. Its state is unknown, and one of the qubits may have suffered
    /// a bit flip error.
    ///
    /// ## syndromeMeasurement
    /// An array of two measurement results that represent parity checks. The
    /// first one represents a parity check between qubit 0 and qubit 1; if
    /// both qubits have the same parity, the result will be 0, and if they
    /// have opposite parity, the result will be One. The second result
    /// corresponds to a parity check between qubit 0 and qubit 2.
    operation E03_BitFlipCorrection (
        register : Qubit[],
        syndromeMeasurement : Result[]
    ) : Unit {
        // Tip: you can use the Message() operation to print a debug message
        // out to the console. You might want to consider printing the index
        // of the qubit you identified as broken to help with debugging.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with an original qubit in an
    /// unknown state a|0> + b|1>. You are also provided with 6 blank qubits,
    /// all of which are in the |0> state. Your goal is to construct a
    /// "logical qubit" from these 7 qubits that acts like a single qubit, but
    /// can protect against a single bit-flip error and a single phase-flip
    /// error on any of the actual qubits. The bit-flip and phase-flip may be
    /// on different qubits.
    ///
    /// # Input
    /// ## original
    /// A qubit that you want to protect from bit flips. It will be in the
    /// state a|0> + b|1>.
    ///
    /// ## spares
    /// A register of 6 spare qubits that you can use to add error correction
    /// to the original qubit. All of them are in the |0> state.
    operation E04_SteaneEncode (
        original : Qubit,
        spares : Qubit[]
    ) : Unit is Adj {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with a logical qubit, represented
    /// by an error-protected register that was encoded with your Exercise 4
    /// implementation. Your goal is to perform a bit-flip syndrome
    /// measurement on the register, to determine if any of the bits have been
    /// flipped.
    /// 
    /// # Input
    /// ## register
    /// A 7-qubit register representing a single error-protected logical
    /// qubit. Its state  is unknown, and it may have suffered a bit-flip
    /// and/or a phase-flip error.
    ///
    /// # Output
    /// An array of the 3 syndrome measurement results that the Steane code
    /// produces.
    operation E05_SteaneBitSyndrome (register : Qubit[]) : Result[] {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with a logical qubit, represented
    /// by an error-protected register that was encoded with your Exercise 4
    /// implementation. Your goal is to perform a phase-flip syndrome
    /// measurement on the register, to determine if any of the qubits have
    /// suffered a phase-flip error.
    /// 
    /// # Input
    /// ## register
    /// A 7-qubit register representing a single error-protected logical
    /// qubit. Its state is unknown, and it may have suffered a bit-flip
    /// and/or a phase-flip error.
    /// 
    /// # Output
    /// An array of the 3 syndrome measurement results that the Steane code
    /// produces.
    operation E06_SteanePhaseSyndrome (register : Qubit[]) : Result[] {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with the 3-result array of syndrome
    /// measurements provided by the bit-flip or phase-flip measurement
    /// operations. Your goal is to determine the index of the broken qubit
    /// (if any) based on these measurements.
    /// 
    /// As a reminder, for Steane's code, the following table shows the
    /// relationship between the syndrome measurements and the index of the
    /// broken qubit:
    /// -----------------------
    /// 000 = No error
    /// 001 = Error or qubit 0
    /// 010 = Error on qubit 1
    /// 011 = Error on qubit 2
    /// 100 = Error on qubit 3
    /// 101 = Error on qubit 4
    /// 110 = Error on qubit 5
    /// 111 = Error on qubit 6
    /// -----------------------
    /// 
    /// # Input
    /// ## syndrome
    /// An array of the 3 syndrome measurement results from the bit-flip or
    /// phase-flip measurement operations. These will come from your
    /// implementations of Exercise 5 and Exercise 6.
    /// 
    /// # Output
    /// An Int identifying the index of the broken qubit, based on the
    /// syndrome measurements. If none of the qubits are broken, you should
    /// return -1.
    /// 
    /// # Remarks
    /// This is a "function" instead of an "operation" because it's a purely
    /// classical method. It doesn't have any quantum parts to it, just lots
    /// of regular old classical math and logic.
    function E07_SyndromeToIndex (syndrome : Result[]) : Int {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a logical qubit represented by an
    /// error-protected register of 7 physical qubits. This register was
    /// produced by your implementation of Exercise 4. It is in an unknown
    /// state, but one of its qubits may or may not have suffered a bit-flip
    /// error, and another qubit may or may not have suffered a phase-flip
    /// error. Your goal is to use your implementations of Exercises 2, 3, and
    /// 4 to detect and correct the bit-flip and/or phase-flip errors in the
    /// register.
    /// 
    /// # Input
    /// ## register
    /// A 7-qubit register representing a single error-protected logical
    /// qubit. Its state is unknown, and it may have suffered a bit-flip
    /// and/or a phase-flip error.
    /// 
    /// # Remarks
    /// This test may take a lot longer to run than you're used to, because it
    /// tests every possible combination of bit and phase flips on a whole
    /// bunch of different original qubit states. Don't worry if it doesn't
    /// immediately finish!
    operation E08_SteaneCorrection (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }
}
