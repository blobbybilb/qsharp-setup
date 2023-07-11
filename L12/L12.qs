// Intro to Quantum Software Development
// Lab 12: Using Azure Quantum
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// In this lab, there are no unit tests. Instead, your goal is to successfully
// submit a job to the Microsoft Azure Quantum service. Follow the steps below.
//  1. Create a free (pay-as-you-go) Azure account:
//     https://azure.microsoft.com/en-us/pricing/purchase-options/pay-as-you-go/
//  2. Create an Azure Quantum workspace:
//     https://learn.microsoft.com/en-us/azure/quantum/how-to-create-workspace
//  3. Install the Azure CLI:
//     https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
//  4. Open a terminal window and install the Azure CLI quantum extension:
//     `az extension add --upgrade -n quantum`
//  5. Connect to your Azure Quantum workspace:
//     https://learn.microsoft.com/en-us/azure/quantum/how-to-submit-re-jobs?pivots=ide-vscode-qsharp#connect-to-your-azure-quantum-workspace
//  6. Navigate to the L12 project directory and then submit the job to the
//     Resource Estimator target:
//     https://learn.microsoft.com/en-us/azure/quantum/how-to-submit-re-jobs?pivots=ide-vscode-qsharp#estimate-the-quantum-algorithm
//  7. Experiment with other targets:
//     https://learn.microsoft.com/en-us/azure/quantum/how-to-submit-jobs?pivots=ide-azurecli
//
// Alternatively, use the related documentation from the links above to submit
// a job through the web UI.

namespace MITRE.QSD.L12 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    

    // @EntryPoint() denotes the start of program execution.
    @EntryPoint()
    operation MainOp() : Result {
        use q = Qubit();
        H(q);
        return M(q);

        // Change/add whatever you want!
    }
}
