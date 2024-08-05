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


