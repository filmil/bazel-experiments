# Adding a new toolchain.

## This works:

```
bazel build //third_party/toolchains:hello
```

## This also works

A binary for riscv64 is produced.

```
bazel build \
  --cpu=riscv64 \
  --toolchain_top=//bazel/toolchain/muntjac-baremetal:toolchain  \
  //third_party/toolchains:hello
```

## However, this does *not* work

On bazel 5.1.0:

```
╰─>$ bazel build --toolchain_resolution_debug=@bazel_tools//tools/cpp:toolchain_type  //third_party/toolchains:hello_rv64
Starting local Bazel server and connecting to it...
INFO: ToolchainResolution:     Type @bazel_tools//tools/cpp:toolchain_type: target platform //bazel/platforms:muntjac_baremetal: Rejected toolchain @local_config_cc//:cc-compiler-armeabi-v7a; mismatching values: arm, android
INFO: ToolchainResolution:     Type @bazel_tools//tools/cpp:toolchain_type: target platform //bazel/platforms:muntjac_baremetal: Rejected toolchain @local_config_cc//:cc-compiler-k8; mismatching values: x86_64, linux
INFO: ToolchainResolution:   Type @bazel_tools//tools/cpp:toolchain_type: target platform //bazel/platforms:muntjac_baremetal: No toolchains found.
ERROR: /usr/local/google/home/fmil/code/bazel-experiments/rv5-tools/third_party/toolchains/BUILD.bazel:3:10: While resolving toolchains for target //third_party/toolchains:hello: No matching toolchains found for types @bazel_tools//tools/cpp:toolchain_type. Maybe --incompatible_use_cc_configure_from_rules_cc has been flipped and there is no default C++ toolchain added in the WORKSPACE file? See https://github.com/bazelbuild/bazel/issues/10134 for details and migration instructions.
ERROR: Analysis of target '//third_party/toolchains:hello_rv64' failed; build aborted: 
INFO: Elapsed time: 4.612s
INFO: 0 processes.
FAILED: Build did NOT complete successfully (35 packages loaded, 142 targets configured)
```

On bazel 6.1.0:
```
╰─>$ bazel build --toolchain_resolution_debug=@bazel_tools//tools/cpp:toolchain_type  //third_party/toolchains:hello_rv64
Starting local Bazel server and connecting to it...
INFO: ToolchainResolution:     Type @bazel_tools//tools/cpp:toolchain_type: target platform //bazel/platforms:muntjac_baremetal: Rejected toolchain @local_config_cc//:cc-compiler-armeabi-v7a; mismatching values: armv7, android
INFO: ToolchainResolution:     Type @bazel_tools//tools/cpp:toolchain_type: target platform //bazel/platforms:muntjac_baremetal: Rejected toolchain @local_config_cc//:cc-compiler-k8; mismatching values: x86_64, linux
INFO: ToolchainResolution:   Type @bazel_tools//tools/cpp:toolchain_type: target platform //bazel/platforms:muntjac_baremetal: No toolchains found.
INFO: ToolchainResolution: Target platform //bazel/platforms:muntjac_baremetal: Selected execution platform @local_config_platform//:host, 
INFO: Analyzed target //third_party/toolchains:hello_rv64 (39 packages loaded, 172 targets configured).
INFO: Found 1 target...
Target //third_party/toolchains:hello_rv64 up-to-date:
  bazel-out/k8-fastbuild-ST-d4220086794d/bin/third_party/toolchains/hello
  bazel-bin/third_party/toolchains/hello_rv64/hello
INFO: Elapsed time: 5.279s, Critical Path: 0.04s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
```

The above compilation succeeds, but the produced binary is a linux ELF, not a
riscv64 bare metal binary.

```
╰─>$ ldd bazel-bin/third_party/toolchains/hello_rv64/hello
        linux-vdso.so.1 (0x00007ffdd39dc000)
        libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007fb25f400000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fb25f667000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fb25f21f000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fb25f769000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fb25f647000)
╰─>$ ldd bazel-out/k8-fastbuild-ST-d4220086794d/bin/third_party/toolchains/hello
        linux-vdso.so.1 (0x00007fff6f7a7000)
        libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f8a1cc00000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f8a1ced5000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f8a1ca1f000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f8a1cfd7000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f8a1ceb5000)
┬─[fmil@fmil5:~/code/bazel-experiments/rv5-tools]─[06:15:49 AM]
│ (g/b:main)
╰─>$ 
```
