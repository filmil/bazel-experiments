This is an example rust program built for an example embedded riscv64
processor, built by Bazel.

Try it out:

```bash
bazel build //prg:my_program
```

This will download all needed tools, configure them, and run a cross-compiler
that will produce a binary that can run on a riscv64 processor in machine mode.

```bash
bazel build //prg:disasm
```

This will compile, but also disassemble the basic program.  View the result for
example using:

```
cat bazel-bin/prg/disasm.S
```

## Maintenance

### Generate rust-project.json

```
bazel run @rules_rust//tools/rust_analyzer:gen_rust_project
```

The above requires the target `//:gen_rust_project`.

### Update Cargo files

This is how to generate new lock files.  At the project outset, you must

1. create the empty files `//third_party/cargo:Cargo.lock`, and
    `//third_party/cargo:Cargo.Bazel.lock`.
2. Run `env CARGO_BAZEL_REPIN=true bazel build //...` to initialize the
 lockfiles.


