# Bare-Metal Rust for RISC-V64 with Bazel

## Purpose of this Experiment

This experiment demonstrates how to build a **bare-metal Rust application** specifically targeting a **RISC-V 64-bit processor architecture (riscv64gc)**. "Bare-metal" means the Rust program runs directly on the hardware without an underlying operating system, giving full control over system resources. This is typical for embedded systems and firmware development.

Bazel, in conjunction with `rules_rust`, is used to:
*   Manage the Rust cross-compilation toolchain for the `riscv64gc-unknown-none-elf` target.
*   Build the Rust source code into an executable binary suitable for a RISC-V processor running in machine mode (M-mode), the highest privilege level.
*   Ensure a reproducible build environment by handling dependency fetching and toolchain setup.

## Key Project Components

*   **`MODULE.bazel` (or `WORKSPACE` for older setups):**
    *   Configures `rules_rust` and specifies the Rust toolchain, including the RISC-V cross-compilation target (`riscv64gc-unknown-none-elf`).
*   **`prg/src/main.rs`:**
    *   The main Rust source file for the bare-metal application. This is where the embedded logic resides (e.g., hardware initialization, main loop).
*   **`prg/BUILD.bazel`:**
    *   Defines the `rust_binary` target (e.g., `//prg:my_program`) that compiles `main.rs` for the RISC-V target.
    *   May also define targets for disassembly (`//prg:disasm`).
*   **`Cargo.toml`, `Cargo.lock`, `Cargo.Bazel.lock` (in root and/or `prg/`):**
    *   Used by `rules_rust` (often with `crates_universe` or `cargo-raze`) to manage Rust crate dependencies from Crates.io.

## How to Build

Bazel handles the download and configuration of all necessary tools, including the Rust compiler and the RISC-V cross-compilation toolchain.

1.  **Build the RISC-V Binary:**
    To compile the Rust application into a RISC-V executable:
    ```bash
    bazel build //prg:my_program
    ```
    This will produce an ELF binary (e.g., `bazel-bin/prg/my_program`) that can run on a compatible riscv64 processor in machine mode.

2.  **Build and View Disassembly (Optional):**
    To compile the program and also generate its disassembly:
    ```bash
    bazel build //prg:disasm
    ```
    You can then view the disassembled code, for example:
    ```bash
    cat bazel-bin/prg/disasm.S
    ```
    This is useful for understanding the generated machine code or debugging low-level issues.

## Running the Binary (General Guidance)

Running a bare-metal binary requires a RISC-V target machine or an emulator. This project does not provide specific scripts for a particular target, but here's general guidance:

*   **QEMU (Emulator):**
    QEMU is a popular open-source machine emulator that supports RISC-V. You would typically invoke QEMU with the appropriate machine model and point it to the compiled ELF file. For example (the exact command may vary):
    ```bash
    qemu-system-riscv64 -machine virt -nographic -kernel bazel-bin/prg/my_program
    ```
    Or, for a specific board like the SiFive HiFive Unleashed:
    ```bash
    qemu-system-riscv64 -machine sifive_u -nographic -kernel bazel-bin/prg/my_program
    ```
    You may need to install QEMU and its RISC-V system emulation components.

*   **Physical Hardware (Development Board):**
    To run on a physical RISC-V development board, you'll need:
    1.  A way to transfer the binary to the board (e.g., via JTAG, UART bootloader, SD card).
    2.  Debugging/flashing tools like OpenOCD, J-Link, or board-specific utilities.
    The exact procedure is highly dependent on the specific board and its documentation.

The binary produced by this experiment is typically an ELF file. Some targets might require a raw binary format (`.bin`), which can often be generated from the ELF file using `objcopy` (which should be part of the RISC-V toolchain Bazel manages):
```bash
# Example:
# path/to/riscv/toolchain/riscv64-unknown-elf-objcopy -O binary bazel-bin/prg/my_program bazel-bin/prg/my_program.bin
```
Consult your target hardware's documentation for the required format and loading procedure.

## Development and Maintenance

### Generating `rust-project.json` (for rust-analyzer)

To generate or update the `rust-project.json` file, which is used by `rust-analyzer` for enhanced IDE support (e.g., in VS Code):
```bash
bazel run @rules_rust//tools/rust_analyzer:gen_rust_project
```
This typically requires a corresponding target to be defined in your root `BUILD.bazel` file, e.g.:
```bazel
# In root BUILD.bazel file
# alias(
#     name = "gen_rust_project",
#     actual = "@rules_rust//tools/rust_analyzer:gen_rust_project",
# )
```

### Updating Cargo Dependencies (Lock Files)

The project uses Cargo for managing Rust crate dependencies, integrated with Bazel via `rules_rust`.
If you update `Cargo.toml` files (e.g., in `prg/Cargo.toml` or a central `third_party/cargo/Cargo.toml` if used):

1.  **Initial Setup (if not done already):**
    If `Cargo.Bazel.lock` or `Cargo.lock` (at the workspace level for `crates_universe`) don't exist, you might need to create empty versions first.
    *   Example for `crates_universe`: Create empty `//third_party/cargo:Cargo.lock` and `//third_party/cargo:Cargo.Bazel.lock`. (This project seems to have them at the root).

2.  **Re-pin Dependencies:**
    To update the lock files (`Cargo.lock` and `Cargo.Bazel.lock`) after changing `Cargo.toml` or to regenerate them:
    ```bash
    env CARGO_BAZEL_REPIN=true bazel build //...
    ```
    This command tells `rules_rust` to re-evaluate the `Cargo.toml` files and update the corresponding lock files. Commit the updated lock files to your version control.

Ensure your Bazel setup (`MODULE.bazel` or `WORKSPACE`) correctly configures `rules_rust` and the `crates_universe` or `cargo-raze` repository rule for managing these dependencies.
