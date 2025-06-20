# Fully Static C++ Binaries with Musl

[![musl_logo](https://musl.libc.org/logo.png)](https://musl.libc.org/)

**[Musl][mm] is a lightweight, fast, and simple C library (libc) designed to be statically linked.**

[mm]: https://en.wikipedia.org/wiki/Musl

## Goal of this Experiment

The primary goal of this experiment is to demonstrate how to build a **fully static C++ executable** using Bazel, by linking against the `musl` C library instead of the more common `glibc`. Static linking is particularly useful for creating portable binaries that have no runtime dependencies on system libraries.

## Why Musl for Static Linking?

Standard C libraries like `glibc` have licensing and technical complexities (e.g., with nss_witch, dlopen) that make true static linking problematic or not recommended. `musl` is designed from the ground up to support clean static linking, making it an excellent choice for producing self-contained binaries.

## Prerequisites

1.  **Bazel:** You need Bazel installed on your system.
2.  **Musl Toolchain for Bazel:** This experiment relies on an external Bazel toolchain for `musl`. The necessary declarations (e.g., in `WORKSPACE` or `MODULE.bazel` and related `.bzl` files) must be set up to define and register a C++ toolchain that uses `musl` for linking. The example output below shows paths like `external/toolchains_musl++toolchains_musl+musl-1_2_3-platform-x86_64-unknown-linux-gnu-target-x86_64-linux-musl/`, indicating such a toolchain is in use.

## How to Build

To build the `hello` C++ binary:

```bash
bazel build //:hello
```

To see the detailed commands executed by Bazel during the build (useful for debugging or understanding the process), you can add the `--subcommands` flag:

```bash
bazel build //:hello --subcommands
```

**Example Build Output Snippets:**

The build process will involve compiling `hello.cc` and then linking it. Key aspects of the linking step (as shown by `--subcommands` output) include:
*   Invocation of a `musl-gcc` cross-compiler (e.g., `x86_64-linux-musl-gcc`).
*   Use of flags like `-static` to ensure static linking.

```
SUBCOMMAND: # //:hello [action 'Compiling hello.cc', ...]
(cd ... && \
  exec env - \
  ... \
  external/toolchains_musl++toolchains_musl+musl-1_2_3-platform-x86_64-unknown-linux-gnu-target-x86_64-linux-musl/bin/x86_64-linux-musl-gcc ... -c hello.cc -o .../hello.pic.o)

SUBCOMMAND: # //:hello [action 'Linking hello', ...]
(cd ... && \
  exec env - \
  ... \
  external/toolchains_musl++toolchains_musl+musl-1_2_3-platform-x86_64-unknown-linux-gnu-target-x86_64-linux-musl/bin/x86_64-linux-musl-gcc @.../hello-0.params)
```
The `hello-0.params` file would contain arguments like:
```
-o
bazel-out/k8-fastbuild/bin/hello
bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.o
-static-libgcc
-Wl,-S
-lstdc++
-static
...
```

## How to Run

After a successful build, the static binary will be located in the `bazel-bin` directory.

1.  **Run the executable:**
    ```bash
    ./bazel-bin/hello
    ```
    You should see the following output:
    ```
    Hello world!
    ```

2.  **Verify Static Linking:**
    You can verify that the resulting binary is indeed statically linked using the `ldd` command:
    ```bash
    ldd ./bazel-bin/hello
    ```
    The expected output should be:
    ```
    not a dynamic executable
    ```
    This confirms that the binary has no dynamic dependencies on shared libraries.

## Summary

This experiment showcases the use of a `musl`-based toolchain with Bazel to produce truly static C++ binaries, which is beneficial for portability and minimizing runtime dependencies.
