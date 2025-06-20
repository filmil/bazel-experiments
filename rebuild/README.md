# Bazel C++ Rebuild Behavior with Headers in `srcs` vs. `additional_compiler_inputs`

## Purpose of this Experiment / Bug Report

This experiment explores how Bazel's C++ rules handle rebuilds when header files are modified, under different scenarios:

1.  A header is listed in the `srcs` attribute of a `cc_binary` but is **not** `#include`d by any of the C++ source files in that target.
2.  A header is listed in the `srcs` attribute of a `cc_binary` and **is** `#include`d by a C++ source file in that target (the control case).
3.  A header is listed in the `additional_compiler_inputs` attribute of a `cc_library` and is **not** `#include`d by the C++ source files in that library.

The core issue demonstrated (particularly by Scenario 1) is that Bazel might not rebuild a target if a header file listed in its `srcs` changes, provided that header isn't actually `#include`d. This can be counter-intuitive, as users might expect any change to a file listed in `srcs` to trigger a rebuild. Scenario 3 explores an alternative way (`additional_compiler_inputs`) to declare such header dependencies.

## Directory Structure and Scenarios

*   **`rebuild/1/` (Scenario 1: Header in `srcs`, not included)**
    *   `1/BUILD.bazel`: Defines `cc_binary(//1:hello)` with `1/hello.h` in `srcs`.
    *   `1/hello.cc`: Does **not** `#include "1/hello.h"`.
    *   **Hypothesis:** Changes to `1/hello.h` might not trigger a rebuild of `//1:hello`.

*   **`rebuild/2/` (Scenario 2: Header in `srcs`, IS included)**
    *   `2/BUILD.bazel`: Defines `cc_binary(//2:hello)` with `2/hello.h` in `srcs`.
    *   `2/hello.cc`: **Does** `#include "2/hello.h"`.
    *   **Hypothesis:** Changes to `2/hello.h` should reliably trigger a rebuild of `//2:hello`. This serves as a control.

*   **`rebuild/3/` (Scenario 3: Header in `additional_compiler_inputs`, not included)**
    *   `3/BUILD.bazel`: Defines `cc_library(//3:hello_lib)` with `3/hello.h` in `additional_compiler_inputs` (not `srcs`). `3/hello.cc` is the source for this library. The `cc_binary(//3:hello)` depends on this library.
    *   `3/hello.cc`: Does **not** `#include "3/hello.h"`.
    *   **Hypothesis:** Changes to `3/hello.h` should trigger a rebuild of `//3:hello_lib` (and thus `//3:hello`) because `additional_compiler_inputs` explicitly tells Bazel to watch this file for changes affecting compilation.

## Steps to Reproduce and Observe Behavior

**Initial Build:**
First, build all targets to establish a baseline.
```bash
bazel build //1:hello //2:hello //3:hello
```
Run it again with `--subcommands` to confirm nothing is rebuilt (actions are cached).
```bash
bazel build //1:hello //2:hello //3:hello --subcommands
# Look for "INFO: 0 processes." or confirm no compile/link actions are shown for these targets.
```

**Scenario 1: Header in `srcs`, not included (`rebuild/1/`)**

1.  **Modify `rebuild/1/hello.h`:**
    Open `rebuild/1/hello.h` and make a trivial change (e.g., add a comment or change the value of `FOO`).
    ```cpp
    // Old: #define FOO 316
    // New: #define FOO 317 // Changed
    ```

2.  **Rebuild `//1:hello`:**
    ```bash
    bazel build //1:hello --subcommands
    ```
3.  **Observe:**
    *   **Expected (based on strict `srcs` interpretation):** A rebuild of `//1:hello`.
    *   **Actual (as suggested by original bug report):** `//1:hello` is **not** rebuilt. Bazel's include scanning doesn't see `1/hello.h` used by `1/hello.cc`, so it might ignore changes to it for this target, despite it being in `srcs`.

**Scenario 2: Header in `srcs`, IS included (`rebuild/2/`)**

1.  **Modify `rebuild/2/hello.h`:**
    Open `rebuild/2/hello.h` and make a trivial change.
    ```cpp
    // Old: #define FOO 316
    // New: #define FOO 318 // Changed
    ```

2.  **Rebuild `//2:hello`:**
    ```bash
    bazel build //2:hello --subcommands
    ```
3.  **Observe:**
    *   **Expected:** `//2:hello` **is** rebuilt.
    *   **Actual:** This should align with the expectation, as the included header changed.

**Scenario 3: Header in `additional_compiler_inputs`, not included (`rebuild/3/`)**

1.  **Modify `rebuild/3/hello.h`:**
    Open `rebuild/3/hello.h` and make a trivial change.
    ```cpp
    // Old: #define FOO 3141
    // New: #define FOO 3142 // Changed
    ```

2.  **Rebuild `//3:hello` (which depends on `//3:hello_lib`):**
    ```bash
    bazel build //3:hello --subcommands
    ```
3.  **Observe:**
    *   **Expected:** `//3:hello_lib` (and therefore `//3:hello`) **is** rebuilt because `3/hello.h` is explicitly listed as an input that affects compilation via `additional_compiler_inputs`.
    *   **Actual:** This should align with the expectation.

## Summary of Expected Bazel Behavior vs. Intuition

*   **`srcs` attribute:** Bazel performs include scanning on C++ source files listed in `srcs`. If a header also listed in `srcs` is not found through this scanning for a particular `.cc` file, changes to that header might not trigger a recompile of that `.cc` file or relink of the binary if no other direct dependencies changed. This is efficient but can be surprising if you expect all files in `srcs` to unconditionally trigger rebuilds upon modification.
*   **`hdrs` attribute:** Typically used for headers that are part of a library's public interface. Bazel tracks their changes for dependent targets.
*   **`additional_compiler_inputs` attribute (for `cc_library`):** This attribute allows you to specify files that are inputs to the compilation actions of the library, even if they are not explicitly `#include`d in a way the include scanner can detect (e.g., headers included via macros, or headers that affect compiler flags which then alter code generation). This provides a more explicit way to tell Bazel to watch these files.

This experiment helps clarify these nuances in Bazel's C++ rule implementation.
The `diff -u 1/ 2/` command from the original README can still be useful to quickly see that the primary difference between `1/hello.cc` and `2/hello.cc` is the `#include "hello.h"` line.
```bash
diff -u rebuild/1/hello.cc rebuild/2/hello.cc
```
