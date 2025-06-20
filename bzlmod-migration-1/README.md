# Bzlmod Migration Scenario 1: `http_archive` to Bzlmod with Transitive Dependencies

## Purpose

This experiment demonstrates a scenario for migrating a project towards Bzlmod, focusing on transitive dependencies and runfile resolution. It shows how a bzlmod-enabled repository (`repo3`) can consume another bzlmod repository (`repo2`), which in turn depends on a repository (`repo1`) that might be treated as a more traditional, external dependency.

The experiment aims to illustrate how resource locations (`rlocation`) and runfiles are handled across these dependencies, particularly when `repo3` executes a script from `repo2`, which itself executes a script from `repo1`.

## Sub-directories and Their Roles

*   **`repo1/`**:
    *   Represents a foundational repository. While it contains a `MODULE.bazel` file, in this scenario, it's primarily treated as a source of a simple script.
    *   It provides a `sh_binary` target named `script` (executing `repo1/script.sh`).

*   **`repo2/`**:
    *   A bzlmod-enabled repository.
    *   It depends on `repo1` (specifically, `@repo1//:script`) using Bazel's dependency mechanisms. The `BUILD.bazel` file shows it referencing `@repo1//:script` in its `data` attribute and as an argument to its own script.
    *   It provides its own `sh_binary` target named `script` (executing `repo2/script.sh`), which in turn calls `repo1`'s script.
    *   This repository demonstrates how a bzlmod module (`repo2`) can depend on and execute artifacts from another module (`repo1`).

*   **`repo3/`**:
    *   A bzlmod-enabled repository.
    *   It depends on `repo2` (specifically, `@repo2//:script`) using bzlmod (as would be defined in its `MODULE.bazel` file). The `BUILD.bazel` file shows it referencing `@repo2//:script`.
    *   This repository demonstrates how a bzlmod project (`repo3`) consumes another bzlmod module (`repo2`) and transitively executes code from `repo1`.
    *   The key aspect explored here is the successful execution and correct path resolution (runfiles) of scripts across this chain of dependencies.

## Running the Experiment

The primary way to run this experiment is to execute the `script` target within `repo3`. This will demonstrate the transitive execution of scripts from `repo2` and then `repo1`.

1.  **Navigate to `repo3`:**
    ```bash
    cd bzlmod-migration-1/repo3
    ```

2.  **Run the `script` target:**
    ```bash
    bazel run //:script
    ```
    You should see output indicating that `repo3` calls `repo2`, and `repo2` calls `repo1`. The `tree ..` command in `repo3/script.sh` will also display a part of the directory structure from `repo3`'s perspective, which can be useful for debugging runfile paths.

You can also run the scripts in `repo1` and `repo2` independently:

*   **To run `repo1`'s script directly:**
    ```bash
    cd bzlmod-migration-1/repo1
    bazel run //:script
    ```
    Expected output: `repo1: hello`

*   **To run `repo2`'s script (which calls `repo1`'s script):**
    ```bash
    cd bzlmod-migration-1/repo2
    bazel run //:script
    ```
    Expected output will show `repo2` calling `repo1`, followed by `repo1: hello`.

The "rlocation issue" mentioned in the original, very brief README likely refers to ensuring that the path to `@repo1//:script` (i.e., `$(location @repo1//:script)`) resolves correctly when `repo2`'s script is built and run, and similarly for `@repo2//:script` when `repo3`'s script is run. The provided setup in the `BUILD.bazel` files using `$(location ...)` and `data` dependencies is the standard way to handle this.

## Formatting

This README uses standard Markdown formatting.
