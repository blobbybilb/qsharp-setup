/*
 * QSD Lab 11 C# Tests
 * Copyright 2023 The MITRE Corporation. All Rights Reserved.
 *
 * DO NOT MODIFY THIS FILE.
 */

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Microsoft.Quantum.Simulation.Simulators.QCTraceSimulators;
using System;
using System.Threading.Tasks;
using Xunit;
using Xunit.Abstractions;

namespace MITRE.QSD.L11
{
    public class L11Tests
    {
        private readonly ITestOutputHelper Logger;
        private readonly QuantumSimulator FullSimulator;
        private readonly SparseSimulator SparseSimulator;
        private readonly ToffoliSimulator ToffoliSimulator;
        private readonly QCTraceSimulator TraceSimulator;

        public L11Tests(ITestOutputHelper Logger)
        {
            this.Logger = Logger;
            FullSimulator = new QuantumSimulator();
            SparseSimulator = new SparseSimulator();
            ToffoliSimulator = new ToffoliSimulator();
            var traceSimCfg = new QCTraceSimulatorConfiguration();
            traceSimCfg.UseDepthCounter = true;
            traceSimCfg.UseDistinctInputsChecker = true;
            traceSimCfg.UseInvalidatedQubitsUseChecker = true;
            traceSimCfg.UsePrimitiveOperationsCounter = true;
            traceSimCfg.UseWidthCounter = true;
            TraceSimulator = new QCTraceSimulator(traceSimCfg);
        }

        [Fact]
        public async void E03FullSimulatorTest()
        {
            // Allocates too many qubits to be run on the simulator
            Task<QVoid> task = E03TooManyQubitsTest.Run(FullSimulator);
            await Assert.ThrowsAsync<ExecutionFailException>(
                async () => await task
            );
        }

        [Fact]
        public async void E03SparseSimulatorTest()
        {
            // There is no easy way to test for the operation taking up too
            // much RAM; instead, check that it does not return after 5 sec.
            Task<QVoid> task = E03_ImpossibleToSimulate.Run(SparseSimulator);
            try
            {
                await task.WaitAsync(TimeSpan.FromSeconds(5));
                throw new Exception("Operation was simulated successfully");
            }
            catch (TimeoutException)
            {
                // Operation took more than 5 sec. to simulate
            }
        }

        [Fact]
        public async void E03ToffoliSimulatorTest()
        {
            // Uses non-Toffoli ops
            Task<QVoid> task = E03_ImpossibleToSimulate.Run(ToffoliSimulator);
            await Assert.ThrowsAsync<NotImplementedException>(
                async () => await task
            );
        }

        [Fact]
        public async void E03TraceSimulatorTest()
        {
            // Trace simulator should succeed in a reasonable amount of time
            Task<QVoid> task = E03_ImpossibleToSimulate.Run(TraceSimulator);
            await task.WaitAsync(TimeSpan.FromSeconds(15));

            // Print out results
            var results = TraceSimulator.ToCSV();
            Logger.WriteLine(" --- Trace Simulator Results ---");
            foreach (var item in results)
            {
                Logger.WriteLine("\\/ {0} \\/", item.Key);
                Logger.WriteLine(item.Value);
            }
        }
    }
}
