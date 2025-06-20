# Experiments with bazel build rules [![Test status](https://github.com/filmil/bazel-experiments/workflows/Test/badge.svg)](https://github.com/filmil/bazel-experiments/workflows/Test/badge.svg)

This repository contains a collection of experiments showcasing various aspects of the Bazel build system. Each experiment is a self-contained example demonstrating a specific feature or use case.

At the moment there are the following experiments:

* [`wasm`](wasm): an example go wasm application built with bazel
* [`rules-foreign-cc`](rules-foreign-cc): an example of a C++ compilation of an
  external repo
* [`rebuild`](rebuild): a bug report test
* [`rv5-tools`](rv5-tools): an example cross-compilation of a RISC-V "hello
  world" binary
* [`python`](python): an example hermetic python app build
* [`riscv64-rust-baremetal`](riscv64-rust-baremetal): an example of building an
  embedded binary in rust, using bazel as a build system.
* [`musl`](musl): example build of a static C++ binary linked against musl
  instead of glibc.

## Contributing

Contributions are welcome! If you have an idea for a new experiment or an improvement to an existing one, please feel free to:

1.  Fork the repository.
2.  Create a new branch for your changes.
3.  Make your changes, ensuring that each experiment remains self-contained and well-documented.
4.  Submit a pull request.

## License

This project is licensed under the Apache License 2.0. See the `LICENSE` file for more details.
