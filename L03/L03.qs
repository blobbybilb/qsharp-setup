// Intro to Quantum Software Development
// Lab 3: Multi-Qubit Gates
// Copyright 2023 The MITRE Corporation. All Rights Reserved.

namespace MITRE.QSD.L03 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;


    /// # Summary
    /// In this exercise, you are given two qubits. Both qubits are in
    /// arbitrary, unknown states:
    ///
    ///     |qubitA> = a|0> + b|1>
    ///     |qubitB> = c|0> + d|1>
    ///
    /// Use the two-qubit gates in Q# to switch their amplitudes, so
    /// this is the end result:
    ///
    ///     |qubitA> = c|0> + d|1>
    ///     |qubitB> = a|0> + b|1>
    ///
    /// # Input
    /// ## qubitA
    /// The first qubit, which starts in the state a|0> + b|1>.
    ///
    /// ## qubitB
    /// The second qubit, which starts in the state c|0> + d|1>.
    ///
    /// # Remarks
    /// This investigates how to apply quantum gates that take more than one
    /// qubit.
    operation E01_SwapAmplitues (qubitA : Qubit, qubitB : Qubit) : Unit {
        // Hint: you can do this with a single statement, using one gate.
        SWAP(qubitA, qubitB);
        // TODO
    }


    /// # Summary
    /// In this exercise, you're given a register of qubits with unknown
    /// length. Each qubit is in an arbitrary, unknown state. Your goal
    /// is to reverse the register, so the order of qubits is reversed.
    ///
    /// For example, if the register had 3 qubits where:
    ///
    ///     |register[0]> = a|0> + b|1>
    ///     |register[1]> = c|0> + d|1>
    ///     |register[2]> = e|0> + f|1>
    ///
    /// Your goal would be to modify the qubits in the register so that
    /// the qubit's states are reversed:
    ///
    ///     |register[0]> = e|0> + f|1>
    ///     |register[1]> = c|0> + d|1>
    ///     |register[2]> = a|0> + b|1>
    ///
    /// Note that the register itself is immutable, so you can't just reorder
    /// the elements like you would in a classical array. For instance, you
    /// can't change the contents of register[0], you can only modify the state
    /// of the qubit at register[0] using quantum gates. In other words, you
    /// must reverse the register by reversing the states of the qubits
    /// themselves, without changing the actual order of the qubits in the
    /// register.
    ///
    /// # Input
    /// ## register
    /// The qubit register that you need to reverse.
    ///
    /// # Remarks
    /// This investigates the combination of arrays and multi-qubit gates.
    operation E02_ReverseRegister (register : Qubit[]) : Unit {
        let reg_length = Length(register);

        for i in 0 .. (reg_length/2 - 1) {
            SWAP(register[i], register[reg_length-i-1]);
        }
    }


    /// # Summary
    /// In this exercise, you are given an array of qubit registers. There are
    /// four registers in the array, and each register contains two qubits. All
    /// eight qubits will be in the |0> state, so each register is in the state
    /// |00>.
    ///
    /// Your goal is to put the four registers into these four states:
    ///
    ///     |registers[0]> = 1/√2(|00> + |11>)
    ///     |registers[1]> = 1/√2(|00> - |11>)
    ///     |registers[2]> = 1/√2(|01> + |10>)
    ///     |registers[3]> = 1/√2(|01> - |10>)
    ///
    /// These four states are known as the Bell States. They are the simplest
    /// examples of full entanglement between two qubits.
    ///
    /// # Input
    /// ## registers
    /// An array of four two-qubit registers. All of the qubits are in the |0>
    /// state.
    ///
    /// # Remarks
    /// This investigates how to prepare the Bell states.
    operation E03_PrepareBellStates (registers : Qubit[][]) : Unit {
        // Hint: you can start by putting all four registers into the state
        // 1/√2(|00> + |11>), then build the final state for each register 
        // from there.
        
        // TODO
        for register in registers {
            H(register[0]);
            CX(register[0], register[1]);
        }

        Z(registers[1][1]);

        X(registers[2][1]);

        X(registers[3][1]);
        Z(registers[3][1]);


        // Z(register[3][0]);
    }


    /// # Summary
    /// In this exercise, you are given a qubit register of unknown length. All
    /// of the qubits in it are in the |0> state, so the whole register is in
    /// the state |0...0>.
    ///
    /// Your task is to transform this register into this state:
    ///
    ///     |register> = 1/√2(|0...0> + |1...1>)
    ///
    /// For example, if the register had 5 qubits, you would need to put it in
    /// the state 1/√2(|00000> + |11111>). These states are called the GHZ
    /// states.
    ///
    /// # Input
    /// ## register
    /// The qubit register. It is in the state |0...0>.
    ///
    /// # Remarks
    /// This will investigate how to prepare maximally entangled states for an
    /// arbitrary number of qubits.
    operation E04_PrepareGHZState (register : Qubit[]) : Unit {
        H(register[0]);
        
        let n = Length(register) - 1;
        for i in 1 .. n {
            CX(register[0], register[i]);
        }
    }


    /// # Summary
    /// In this exercise, you are given a qubit register of length four. All of
    /// its qubits are in the |0> state initially, so the whole register is in
    /// the state |0000>.
    /// Your goal is to put it into the following state:
    ///
    ///     |register> = 1/√2(|0101> - |0110>)
    ///
    /// # Input
    /// ## register
    /// The qubit register. It is in the state |0000>.
    ///
    /// # Remarks
    /// You will need to use the H, X, Z, and CNOT gates to achieve this.
    operation E05_CombineMultipleGates (register : Qubit[]) : Unit {
        // TODO 0101 0110
        H(register[2]); // 0000 0010
        X(register[1]); // 0100 0110
        CX(register[2], register[3]); // 0100 0111
        X(register[3]);
        Z(register[3]);
    }


    /// # Summary
    /// In this exercise, you are given a register with two qubits in the |00>
    /// state. Your goal is to put it in this non-uniform superposition:
    ///
    ///     |register> = 1/√2*|00> + 1/2(|10> + |11>)
    ///
    /// Note that this state will have a 50% chance of being measured as |00>,
    /// a 25% chance of being measured as |10>, and a 25% chance of being
    /// measured as |11>.
    ///
    /// # Input
    /// ## register
    /// A register with two qubits in the |00> state.
    ///
    /// # Remarks
    /// This investigates applying controlled operations besides CNOT.
    operation E06_PrepareNonUniform (register : Qubit[]) : Unit {
        // Hint: Think about what happens to register[1] based on the value of
        // register[0].

        // TODO 00 (10 11)
        // 00 00
        H(register[0]); // 00 10
        Controlled H([register[0]], register[1]);
    }


    /// # Summary
    /// In this exercise, you are given a three-qubit register and an extra
    /// "target" qubit. All of the qubits are in the |0> state. Your goal is to
    /// put the register into a uniform superposition and then entangle it with
    /// the target qubit such that the target is a |1> when the register is
    /// |001>. To be more specific, you must prepare this state:
    ///
    ///     |register,target> = 1/√8(|000,0> + |001,1> + |010,0> + |011,0>
    ///                            + |100,0> + |101,0> + |110,0> + |111,0>)
    ///
    /// # Input
    /// ## register
    /// A register of three qubits, in the |000> state.
    ///
    /// ## target
    /// A qubit in the |0> state. It should be |1> when the register is |001>.
    ///
    /// # Remarks
    /// This investigates how to implement zero-controlled (a.k.a. anti-
    /// controlled) gates in Q#.
    operation E07_EntangleTarget (register : Qubit[], target: Qubit) : Unit {
        // Hint: The "Controlled" syntax does not provide an interface for
        // specifying zero-controls; it assumes all one-controls. You need to
        // find a way to associate the target being |1> with the controls being
        // |001> rather than |111>.
        
        // TODO
        // 000
        ApplyToEach(H, register); // 000 001 010 011 100 101 110 111
        Controlled X(register, target); // 000 001,0 010 011 100 101 110 111,1
        X(register[0]);
        X(register[1]);
    }


    /// # Summary
    /// In this exercise, you are given a three-qubit register in the |000>
    /// state. Your goal is to transform it into this uneven superposition:
    ///
    ///     |register> = 1/√2*|000> + 1/2(|111> - |100>)
    ///
    /// # Input
    /// ## register
    /// A register with three qubits in the |000> state.
    ///
    /// # Remarks
    /// This is a challenging problem that combines all the concepts covered
    /// so far:
    ///  - Quantum superposition
    ///  - Quantum entanglement
    ///  - Qubit registers
    ///  - Single- and multi-qubit gates
    ///  - Phase
    operation E08_PrepareComplexState (register : Qubit[]) : Unit {
        // Hint: Allocating one or more "scratch" qubits may make the problem
        // more approachable. It is possible to prepare this state without
        // using any extra qubits, but this is not necessary.
        
        // 000
        H(register[0]); // 000 100
        Controlled H([register[0]], register[1]); // 000 (100 110)
        Z(register[1]);// 000 (100  -110)
        // Controlled X([register[1]], );
        Controlled X([register[0]], register[2]); // 000 (101 -111)
        Controlled X([register[1]], register[2]); // 000 (101 -110)
        Controlled X([register[0]], register[1]); // 000 (111 -100)
    }


    //////////////////////////////////
    /// === CHALLENGE PROBLEMS === ///
    //////////////////////////////////


    /// # Summary
    /// In this problem, you are given a two-qubit register in the |00> state.
    /// Your goal is to put it into this superposition:
    ///
    ///     |register> = 1/√3(|00> + |01> + |10>)
    ///
    /// Note that all three terms have equal amplitude.
    ///
    /// # Input
    /// ## register
    /// A two-qubit register in the |00> state.
    operation C01_ThreeTermsEqualAmp (register : Qubit[]) : Unit {
        // TODO
        // 00

        let t = 2.0*ArcCos(Sqrt(1.0 / 3.0));
        Ry(t, register[0]);
        Controlled H([register[0]], register[1]);
        X(register[0]);
    }


    /// # Summary
    /// In this problem, you are given a three-qubit register in the |000>
    /// state. Your goal is to put it into this superposition:
    ///
    ///     |register> = 1/√3(|100> + |010> + |001>)
    ///
    /// Note that all states have equal amplitude. This is known as the
    /// three-qubit "W State".
    ///
    /// # Input
    /// ## register
    /// A three-qubit register in the |000> state.
    operation C02_PrepareWState (register : Qubit[]) : Unit {
        // TODO 000 110 101
        let t = 2.0*ArcCos(Sqrt(1.0 / 3.0));
        Ry(t, register[0]); // 1/3 100  2/3 000
        // X(register[0]); // 1/3 000   2/3 100 - 000 100 100
        Controlled H([register[0]], register[1]); // 000 100 110
        Controlled X([register[1]], register[2]); // 000 100 111
        Controlled X([register[0]], register[1]); // 000 110 101
        X(register[0]); // 100 010 001
    }


    /// # Summary
    /// In this problem, you are given a three-qubit register in the |000>
    /// state. Your goal is to encode 8 samples of a cosine wave into its
    /// amplitude. The samples should be evenly spaced in π/4 increments,
    /// starting with 0 and ending with 7π/4. The cosine wave samples are laid
    /// out in the table below:
    ///
    ///  Index  |  Value
    /// ------- | -------
    ///    0    |    1     1/4    000
    ///    1    |   1/√2.  1/8    001
    ///    2    |    0.    0.     010
    ///    3    |  -1/√2   -1/8   011
    ///    4    |   -1.    -1/4.  100
    ///    5    |  -1/√2.  -1/8.  101
    ///    6    |    0     0      110
    ///    7    |   1/√2.  1/8.   111
    ///
    /// Note that these samples are not normalized; if they were used directly
    /// as amplitudes, they would result in a total probability greater than 1.
    ///
    /// Your first task is to normalize the cosine wave samples so they can be
    /// used as amplitudes. Your second task is to encode these 8 normalized
    /// values as the amplitudes of the three-qubit register.
    ///
    /// # Input
    /// ## register
    /// A three-qubit register in the |000> state.
    ///
    /// # Remarks
    /// This kind of challenge is common in quantum computing. Essentially, you
    /// need to construct an efficient circuit that will take real data and
    /// encode it into the superposition of a qubit register. Normally, it
    /// would take 8 doubles to store these values in conventional memory - a
    /// total of 512 classical bits. You're going to encode the exact same data
    /// in 3 qubits. We'll talk more about how quantum computers do things
    /// faster than classical computers once we get to quantum algorithms, but
    /// this is a good first hint.
    operation C03_EncodeCosine (register : Qubit[]) : Unit {
        // TODO (1/4) 000  (1/8) 001  (1/8) -011  (1/4) -100  (1/8) -101  (1/8) 111
        // 000
        let q1 = register[0];
        let q2 = register[1];
        let q3 = register[2];


        // H(q1); // 100 000
        // Controlled H([q1], q3); // (100 101) 000
        // Controlled H([q3], q2); // (100 (101 111)) 000
        // Controlled Z([q1, q2], q3); // (100 (101 -111)) 000
        
        // X(register[0]); // (000 (001 -011)) 100
        // Controlled H([q1], q3); // (000 (001 -011)) (100 101)
        // Controlled H([q3], q2); // (000 (001 -011)) (100 (101 111))
        // Z(q1); // (000 (001 -011)) (-100 (-101 -111))
        // Controlled Z([q1, q2], q3); // (000 (001 -011)) (-100 (-101 111))


        H(q1); // 000 100
        H(q3); // (000 001) (100 101)
        Controlled H([q3], q2); // (000 (001 011)) (100 (101 111))
        Z(q2);
        Z(q1);
    }


    /// # Summary
    /// This problem is the same as Challenge 3, but now you must construct a
    /// superposition using 8 samples of a sine wave instead of a cosine wave.
    /// For your convenience, the sine samples are listed in this table:
    ///
    ///  Index  |  Value
    /// ------- | -------
    ///    0    |    0.    0     000
    ///    1    |   1/√2.  1/8.  001
    ///    2    |    1     1/4.  010
    ///    3    |   1/√2.  1/8.  011
    ///    4    |    0     0     100
    ///    5    |  -1/√2.  1/8.  101
    ///    6    |   -1     1/4.  110
    ///    7    |  -1/√2.  1/8   111
    ///
    /// Once again, these values aren't normalized, so you will have to
    /// normalize them before using them as state amplitudes.
    ///
    /// # Input
    /// ## register
    /// A three-qubit register in the |000> state.
    operation C04_EncodeSine (register : Qubit[]) : Unit {
        // TODO (010 (001 011)) -(110 (101 111))
        // 000

        let q1 = register[0];
        let q2 = register[1];
        let q3 = register[2];

        H(q1); // 000 100
        H(q3); // (000 110)
        Controlled H([q3], q2); // (000 (001 011)) (100 (101 111))
        X(q3); // (001 (000 010)) (101 (100) (110))
        CX(q3, q2); // (011 (000 010)) (111 (100 110))
        X(q3); // (010 (001 011)) (110 (101 111))
        Z(q1);
    }
}
