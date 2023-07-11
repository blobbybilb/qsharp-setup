# Intro to Quantum Software Development

Copyright 2023 The MITRE Corporation. All Rights Reserved.

---

This repository contains coding exercises for MITRE's Intro to Quantum Software Development course. Each lab is a Q# test project with unimplemented operations. Practice your quantum software development skills by implementing each operation so it passes the unit tests.

The course guide at [stem.mitre.org/quantum](https://stem.mitre.org/quantum/).

## Visual Studio Setup

> Only the Windows version of Visual Studio is supported.

1. Download and install the latest [.NET 6.0 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/6.0).

2. Download and install [Visual Studio Community 2022](https://visualstudio.microsoft.com/vs/community/).

3. Download and install the [Microsoft Quantum Development Kit Visual Studio 2022 extension](https://marketplace.visualstudio.com/items?itemName=quantum.DevKit64).

4. Double-click on the `MITRE.QSD.sln` solution file to open it in Visual Studio.

5. Click Build -> Build Solution (Ctrl+Shift+B) to build all the test projects.

6. If the build was successful, all the unit tests will show up in the Test Explorer. Right-click on a test to run or debug it. (If you lose the Test Explorer tab/window, you can find it by clicking View -> Test Explorer.)

## Visual Studio Code Setup

> Windows, MacOS, and Linux are supported, however you may experience errors when compiling Q# projects on arm64-based hardware. See [this GitHub issue](https://github.com/microsoft/qsharp-compiler/issues/1362#issuecomment-1191584444) for a possible workaround.

1. Download and install the latest [.NET 6.0 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/6.0).

2. Download and install [Visual Studio Code](https://code.visualstudio.com/).

3. Download and install the [Microsoft Quantum Development Kit Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=quantum.quantum-devkit-vscode).

4. Open the repository folder in VS Code.

5. Open the terminal with Ctrl+` and navigate to the directory of the lab you are working on.

6. Run the command `dotnet test` to run the unit tests in that project. You can run individual tests using the `--filter` flag, e.g., `dotnet test --filter Exercise1`.

The following VS Code extensions are recommended:

- [C#](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
- [.NET Core Test Explorer](https://marketplace.visualstudio.com/items?itemName=formulahendry.dotnet-test-explorer)
