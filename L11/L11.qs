// Intro to Quantum Software Development
// Lab 11: Using Alternative Simulators
// Copyright 2023 The MITRE Corporation. All Rights Reserved.

namespace MITRE.QSD.L11 {

	open Microsoft.Quantum.Arithmetic;
	open Microsoft.Quantum.Canon;
	open Microsoft.Quantum.Intrinsic;


	/// # Summary
	/// In this exercise, you are given a qubit register in the |0> state and
	/// must prepare a superposition state 1/√2(|0>+|x>), where x is some
	/// integer given by the `secondTerm` parameter.
	///
	/// # Input
	/// ## secondTerm
	/// Integer value of second term in superposition state to prepare.
	///
	/// ## register
	/// Arbitrary-length qubit register. Note the register is little endian.
	/// For example, the three-qubit encoding of the state 1/√2(|0>+|4>) would
	/// be 1/√2(|000>+|001>).
	///
	/// # Remarks
	/// The unit tests for this exercise include the use of the QDK's sparse
	/// simulator, which can handle large numbers of qubits for states with a
	/// small number of superposition terms. For more info on the sparse
	/// simulator, see:
	/// https://learn.microsoft.com/en-us/azure/quantum/machines/sparse-simulator
	operation E01_PrepareTwoTermState (
		secondTerm : Int,
		register : LittleEndian
	) : Unit {
		// Hint: The bit shift operator (>>>) may be useful here for extracting
		// the individual bits of "secondTerm".
		//
		// Recall you can use the unwrap operator (!) to access the underlying
		// array in types like LittleEndian.
		
		// TODO
		fail "Not implemented.";
	}


	/// # Summary
	/// In this exercise, you are given a qubit register in an arbitrary state
	/// |x> and must transform it into the state |x+1>.
	///
	/// # Input
	/// ## register
	/// Arbitrary-length qubit register. As in the previous exercise, the
	/// register is little endian.
	///
	/// # Remarks
	/// The unit tests for this exercise include the use of the QDK's Toffoli
	/// simulator, which essentially treats the qubits like bits and can
	/// therefore handle extremely large numbers of qubits. You can only use X
	/// and controlled X gates when running on this simulator. For more info on
	/// the Toffoli simulator, see:
	/// https://learn.microsoft.com/en-us/azure/quantum/machines/toffoli-simulator
	operation E02_IncrementByOne (register : LittleEndian) : Unit {
		// TODO
		fail "Not implemented.";
	}


	/// # Summary
	/// In this exercise, your goal is write an operation that cannot be
	/// simulated using the full state, sparse, and Toffoli simulators, yet
	/// can be analyzed using the trace simulator in a reasonable amount of
	/// time.
	///
	/// This is an example of quantum resource estimation, where we are
	/// gathering precise metrics of what computational resources would be
	/// required to run the operation, even if we cannot simulate it directly.
	/// Check the unit test output for the results. For more info on the trace
	/// simulator, see:
	/// https://learn.microsoft.com/en-us/azure/quantum/machines/qc-trace-simulator/
	operation E03_ImpossibleToSimulate () : Unit {
		// Hint: Try performing a complex operation on an entangled state with
		// a large number of qubits. It's a little tricky to get the trace
		// simulator to handle measurements; it's easiest to avoid them for
		// this exercise.

		// TODO
		fail "Not implemented.";
	}
}
