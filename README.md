# Experiments with bazel build rules [![Test status](https://github.com/filmil/bazel-experiments/workflows/Test/badge.svg)](https://github.com/filmil/bazel-experiments/workflows/Test/badge.svg)

This repository contains a collection of experiments with Bazel build rules.

## Projects

### [bzlmod-migration-1](bzlmod-migration-1)

A scenario for bzlmod migration with three repositories to demonstrate an issue with `rlocation`.

### [go-protoc-binary](go-protoc-binary)

An example of building a Go binary using a protoc toolchain, showing how to use a prebuilt `protoc` instead of building it from source.

### [musl](musl)

An example of using a musl-based GCC toolchain to build a fully static C++ binary.

### [python](python)

An example of a Flask application built with Bazel.

### [rebuild](rebuild)

An example that shows Bazel is not rebuilding a `cc_binary` if a header in `srcs` changes but is not included.

### [riscv64-rust-baremetal](riscv64-rust-baremetal)

An example of a Rust program built by Bazel for an embedded RISC-V 64-bit processor.

### [runfiles](runfiles)

An example of the use of `runfiles.bash` for cross-repository runfiles resolution in Bazel.

### [rv5-tools](rv5-tools)

A working example of a C++ toolchain registration for cross-compiling to a RISC-V 64-bit target.

### [wasm](wasm)

An example of a Go WASM application built with Bazel, including a server and protobufs.