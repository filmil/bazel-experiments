# Hermetic Python Flask Application with Bazel

## Purpose of this Experiment

This experiment demonstrates how to build a hermetic Python application using Bazel. "Hermetic" means that the build is self-contained and reproducible, with all dependencies (including the Python interpreter and third-party libraries) managed by Bazel. This approach ensures that the application behaves consistently across different environments and over time.

The example application is a simple web server built using the Flask framework. It also includes an internal module (`calculator`) to showcase how local dependencies and tests can be structured.

## Key Files and Directories

*   **`MODULE.bazel` (or `WORKSPACE` for older setups):**
    *   Defines the project's external dependencies, including `rules_python` (for Python support) and the Python toolchain.
*   **`app/`:**
    *   **`main.py`:** The main entry point for the Flask web application.
    *   **`BUILD.bazel`:** Defines the `py_binary` target for the Flask application (`//app:main`).
*   **`calculator/`:**
    *   **`calculator.py`:** A simple calculator module.
    *   **`calculator_test.py`:** Unit tests for the `calculator` module.
    *   **`BUILD.bazel`:** Defines `py_library` for the calculator module and `py_test` for its tests.
*   **`third_party/`:**
    *   **`requirements.in`:** A pip-tools compatible file listing direct Python dependencies (e.g., `Flask`).
    *   **`requirements_lock.txt`:** The pinned list of all transitive dependencies, generated from `requirements.in`.
    *   **`BUILD.bazel`:** Defines targets for managing these dependencies, including a rule to update `requirements_lock.txt`.

## How to Build

Bazel typically builds the application as part of the `run` command. However, you can explicitly build the application and its dependencies using:

```bash
bazel build //app:main
```

This command will compile the Python code (if applicable, though Python is mostly interpreted) and package it along with its dependencies into a runnable format.

You can also build and run the unit tests for the `calculator` module:

```bash
bazel test //calculator:calculator_test
```

## How to Run the Application

To run the Flask web application:

```bash
bazel run //app:main
```

This command will build the application if necessary, and then execute it. Flask's default development server typically starts on `http://127.0.0.1:5000/` (or `http://0.0.0.0:5000/`).

When you open this URL in your web browser, the application will display a simple page showing two random numbers, their sum, and asking if the calculation is correct (e.g., "123 + 456 = 579?").

## Dependency Management

External Python dependencies are managed using `rules_python` and typically a tool like `pip-tools` (evidenced by `requirements.in` and `requirements_lock.txt`).

To update the `requirements_lock.txt` file after changing `third_party/requirements.in`:

```bash
bazel run //third_party:requirements.update
```

This command executes a Bazel rule (often a `py_binary` or `sh_binary`) that invokes `pip-compile` (or a similar tool) to regenerate the lock file based on the contents of `requirements.in`. It's important to commit the updated `requirements_lock.txt` to your version control.

This setup ensures that your Python dependencies are precisely pinned, contributing to the hermeticity and reproducibility of your build.
