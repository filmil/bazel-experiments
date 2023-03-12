# A working C++ toolchain registration example

## Summary

This is an *actually working* example of a repository containing targets for
a specific platform.

## Demo

```
bazel build //third_party/toolchains:hello
```

builds a binary for the host system.

```
bazel build //third_party/toolchains:hello_rv64
```

builds the same binary for a certain RISC-V 64-bit target using a
cross-compiler.  The interesting bit about that is how this last target is
declared:

In `//third_party/toolchains/BUILD.bazel`:
```
load("@bazel_lib//lib:transitions.bzl", "platform_transition_binary")

cc_binary(
    name = "hello",
    srcs = [ "hello.cc" ],
)

platform_transition_binary(
    name = "hello_rv64",
    binary = ":hello",
    target_platform = "//bazel/platforms:muntjac_baremetal",
)
```

It effectively says "build the same thing as `:hello` above, except
set the target platform to be `//bazel/platforms:muntjac_baremetal`".

As far as I know, this is the minimal findable example on how this
works.

## References

* https://groups.google.com/g/bazel-discuss/c/Q5onIjX2Sjo
* https://groups.google.com/g/bazel-discuss/c/LulrD2m-Ao4
