// Intro to Quantum Software Development
// Lab 9: Shor's Factorization Algorithm
// Copyright 2023 The MITRE Corporation. All Rights Reserved.

namespace MITRE.QSD.L09 {

    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;


    /// # Summary
    /// In this exercise, you must implement the quantum modular
    /// exponentiation function: |o> = a^|x> mod b.
    /// |x> and |o> are input and output registers respectively, and a and b
    /// are classical integers.
    ///
    /// # Input
    /// ## a
    /// The base power of the term being exponentiated.
    ///
    /// ## b
    /// The modulus for the function.
    ///
    /// ## input
    /// The register containing a superposition of all of the exponent values
    /// that the user wants to calculate; this superposition is arbitrary.
    ///
    /// ## output
    /// This register must contain the output |o> of the modular
    /// exponentiation function. It will start in the |0...0> state.
    operation E01_ModExp (
        a : Int,
        b : Int,
        input : Qubit[],
        output : Qubit[]
    ) : Unit {
        // Note: For convenience, you can use the
        // Microsoft.Quantum.Math.ExpModI() function to calculate a modular
        // exponent classically. You can use the
        // Microsoft.Quantum.Arithmetic.MultiplyByModularInteger() function to
        // do an in-place quantum modular multiplication.
        X(output[(Length(output) - 1)]);
        // Message("------");
        // mutable x = LittleEndian(input);
        for i in Length(input) - 1 .. -1 .. 0 {
            // Message(IntAsString(i));
            Controlled MultiplyByModularInteger(
                [input[i]],
                ( 
                    ExpModI(a, 2 ^ (Length(input) - i - 1), b),
                    b,
                    LittleEndian(output)
                )
            );
        }
    }


    operation E01_QFT (register : BigEndian) : Unit is Adj + Ctl {
        // Hint: There are two operations you may want to use here:
        //  1. Your implementation of register reversal in Lab 2, Exercise 2.
        //  2. The Microsoft.Quantum.Intrinsic.R1Frac() gate.

        
        
        // for i in 0 .. Length(register!) - 1 {
        //     H(register![i]);
        //     for j in i + 1 .. 0 {
        //     // R1Frac(2.0 * PI() / (2.0 ^ (j - i + 1)), register![j], register![i]);
        //     // Controlled R1Frac - qubit i+1
        //     }
        // }

        // for i in 0 .. Length(register!)/2 - 1 {
        //     SWAP(register![i], register![Length(register!) - i - 1]);
        // }

        for i in 0 .. Length(register!) - 1 {
            H(register![i]);
            for j in i + 1 .. Length(register!) - 1 {
                // target: register[i] - control: register[j] - R2
                Controlled R1Frac([register![j]], (2, j-i+1, register![i]));
            }
        }

        for i in 0 .. Length(register!)/2 - 1 {
            SWAP(register![i], register![Length(register!) - i - 1]);
        }
    
    }


    /// # Summary
    /// In this exercise, you must implement the quantum subroutine of Shor's
    /// algorithm. You will be given a number to factor and some guess to a
    /// possible factor - both of which are integers.
    /// You must set up, execute, and measure the quantum circuit.
    /// You should return the fraction that was produced by measuring the
    /// result at the end of the subroutine, in the form of a tuple:
    /// the first value should be the number you measured, and the second
    /// value should be 2^n, where n is the number of qubits you use in your
    /// input register.
    ///
    /// # Input
    /// ## numberToFactor
    /// The number that the user wants to factor. This will become the modulus
    /// for the modular arithmetic used in the subroutine.
    ///
    /// ## guess
    /// The number that's being guessed as a possible factor. This will become
    /// the base of exponentiation for the modular arithmetic used in the 
    /// subroutine.
    ///
    /// # Output
    /// A tuple representing the continued fraction approximation that the
    /// subroutine measured. The first value should be the numerator (the
    /// value that was measured from the qubits), and the second value should
    /// be the denominator (the total size of the input space, which is 2^n
    /// where n is the size of your input register).
    operation E02_FindApproxPeriod (
        numberToFactor : Int,
        guess : Int
    ) : (Int, Int) {
        // Hint: you can use the Microsoft.Quantum.Arithmetic.MeasureInteger()
        // function to measure a whole set of qubits and transform them into
        // their integer representation.

        // NOTE: This is a *probablistic* test. There is a chance that the
        // unit test fails, even if you have the correct answer. If you think
        // you do, run the test again. Also, look at the output of the test to
        // see what values you came up with versus what the system expects.

        // TODO
        // mutable n = Ceiling(Log(IntAsDouble(numberToFactor))/Log(IntAsDouble(2)));
        // use (input, output) = (Qubit[2 * n], Qubit[n]);
        // ApplyToEach(H, input);
        // E01_ModExp(guess, numberToFactor, input, output);

        

        // Adjoint E01_QFT(BigEndian(input));

        // for i in 0 .. Length(input)/2 - 1 {
        //     SWAP(input[i], input[Length(input) - i - 1]);
        // }

        // mutable num = MeasureInteger((LittleEndian(input)));

        // ResetAll(input);
        // ResetAll(output);

        // return (num, 2^(2*n));

        let length = Ceiling(Log(IntAsDouble(numberToFactor)) / Log(2.0));
        use (input, output) = (Qubit[2 * length], Qubit[length]);

        ApplyToEach(H, input);
        E01_ModExp(guess, numberToFactor, input, output);
        Adjoint E01_QFT(BigEndian(input));
        
        let measurement = MeasureInteger(BigEndianAsLittleEndian(BigEndian(input)));
        ResetAll(input);
        ResetAll(output);
        return (measurement, 2^(2*length));
    }


    /// # Summary
    /// In this exercise, you will be given an arbitrary numerator and
    /// denominator for a fraction, along with some threshold value for the
    /// denominator.
    /// Your goal is to return the largest convergent of the continued
    /// fraction that matches the provided number, with the condition that the
    /// denominator of your convergent must be less than the threshold value.
    ///
    /// # Input
    /// ## numerator
    /// The numerator of the original fraction
    ///
    /// ## denominator
    /// The denominator of the original fraction
    ///
    /// ## denominatorThreshold
    /// A threshold value for the denominator. The continued fraction
    /// convergent that you find must be less than this value. If it's higher,
    /// you must return the previous convergent.
    ///
    /// # Output
    /// A tuple representing the convergent that you found. The first element
    /// should be the numerator, and the second should be the denominator.
    function E03_FindPeriodCandidate (
        numerator : Int,
        denominator : Int,
        denominatorThreshold : Int
    ) : (Int, Int) {
        // TODO

        // ==============

        mutable (p, q) = (denominator, numerator % denominator);
        mutable (a, r) = (numerator / denominator, numerator % denominator);
        mutable (n, d) = ([1, numerator / denominator], [0, 1]);

        mutable i = 1;
        while r != 0 and d[i] < denominatorThreshold {
            set i += 1;

            set a = p / q;
            set r = p % q;

            set n += [a * n[i - 1] + n[i - 2]];
            set d += [a * d[i - 1] + d[i - 2]];

            set p = q;
            set q = r;
        }

        if d[i] > denominatorThreshold {
            set i -= 1;
        }
        return (n[i], d[i]);
    }


    /// # Summary
    /// In this exercise, you are given two integers - a number that you want
    /// to find the factors of, and an arbitrary guess as to one of the
    /// factors of the number. This guess was already checked to see if it was
    /// a factor of the number, so you know that it *isn't* a factor. It is
    /// guaranteed to be co-prime with numberToFactor.
    ///
    /// Your job is to find the period of the modular exponentation function
    /// using these two values as the arguments. That is, you must find the
    /// period of the equation y = guess^x mod numberToFactor.
    ///
    /// # Input
    /// ## numberToFactor
    /// The number that the user wants to find the factors for
    ///
    /// ## guess
    /// Some co-prime integer that is smaller than numberToFactor
    ///
    /// # Output
    /// The period of y = guess^x mod numberToFactor.
    operation E04_FindPeriod (numberToFactor : Int, guess : Int) : Int
    {
        // Note: you can't use while loops in operations in Q#.
        // You'll have to use a repeat loop if you want to run
        // something several times.

        // Hint: you can use the
        // Microsoft.Quantum.Math.GreatestCommonDivisorI()
        // function to calculate the GCD of two numbers.


        let (n, d) = E02_FindApproxPeriod(numberToFactor, guess);
        let (num2, q) = E03_FindPeriodCandidate(n, d, numberToFactor);
        let res = ExpModI(guess, q, numberToFactor);
        if (res == 1) {
            return q;
        }

        let d_o = q;

        let (n2, d2) = E02_FindApproxPeriod(numberToFactor, guess);
        let (num3, q2) = E03_FindPeriodCandidate(n2, d2, numberToFactor);
        let res2 = ExpModI(guess, q2, numberToFactor);
        if (res2 == 1) {
            return q2;
        }

        let d_n = q2;
        let factor = (d_o * d_n) / GreatestCommonDivisorI(d_o, d_n);

        return factor;
    }


    /// # Summary
    /// In this exercise, you are given a number to find the factors of,
    /// a guess of a factor (which is guaranteed to be co-prime), and the
    /// period of the modular exponentiation function that you found in
    /// Exercise 4.
    ///
    /// Your goal is to use the period to find a factor of the number if
    /// possible.
    ///
    /// # Input
    /// ## numberToFactor
    /// The number to find a factor of
    ///
    /// ## guess
    /// A co-prime number that is *not* a factor
    ///
    /// ## period
    /// The period of the function y = guess^x mod numberToFactor.
    ///
    /// # Output
    /// - If you can find a factor, return that factor.
    /// - If the period is odd, return -1.
    /// - If the period doesn't work for factoring, return -2.
    function E05_FindFactor (
        numberToFactor : Int, // b
        guess : Int, // a
        period : Int
    ) : Int {
        // TODO
        if numberToFactor % 2 == 0 {
            return 2;
        }

        let gcd = GreatestCommonDivisorI(guess, numberToFactor);

        if gcd == 1 {
            return gcd;
        }

        if period % 2 == 1 {
            return -1;
        }
    }
}