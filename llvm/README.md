# Example use of `toolchains_llvm`

## Summary

This example configures a C++ toolchain, without libraries, for a bare metal
riscv32 machine.

The contribution of this setup is interesting because it tries to be a minimal
extension to what is already provided in the bazel module
[`toolchains_llvm`][t1]. This is in contrast to most other toolchain
definitions which bring in all the binaries and build all the configuration
from scratch.

It follows [this sparse hint][t0] to its logical conclusion.

## Background

The added configuration makes the toolchain useful for the [serv][t2]
processor.

The machine does not support compressed rv32 instructions, so the setup
adds the necessary flags. I also added the necessary constraints and platform,
as well as the required startup files.

## Instructions

### Build

Issuing this command should compile without errors:

```
bazel build //... --platforms=//toolchain/platform:serv_rv32i
```

Check result:

```
╰─>$ file bazel-bin/hello
bazel-bin/hello: ELF 32-bit LSB executable, UCB RISC-V, soft-float ABI, version 1 (SYSV), statically linked, BuildID[md5/uuid]=125c19fa68a14b65e33a20acd8db7de0, not stripped
```

## Limitations

* I didn't make `//toolchains:startup` auto-linked, it seems that one would
  need to prebuild the startup code.

[t0]: https://github.com/bazel-contrib/toolchains_llvm#:~:text=For%20one%2Doff%20experiments%20with%20new%20architectures
[t1]: https://registry.bazel.build/modules/toolchains_llvm
[t2]: https://github.com/olofk/serv


