# [musl][mm] based GCC toolchain: fully static C++ binaries

[mm]: https://en.wikipedia.org/wiki/Musl

In this example, we use the externally contributed musl C++ toolchain rule set
to build a fully static binary. The binary is linked against the musl library
because glibc is not compatible with static linking.  This is one of the bigger
reasons to use musl instead of glibc.

Here's what happens when we compile the binary. The flag `--subcommands` is added
to provide insight into what happens under the hood.

```
╰─>$ bazel build //:hello --subcommands
INFO: Analyzed target //:hello (66 packages loaded, 3221 targets configured).
SUBCOMMAND: # //:hello [action 'Compiling hello.cc', configuration: 3723722276aac1314320ca9a9fb2a278d80e4eb3b422da8939e984231a537159, execution platform: @@platforms//host:host, mnemonic: CppCompile]
(cd /home/f/.cache/bazel/_bazel_f/f4a07668797e2b42c8e60c02cf2e35a9/execroot/_main && \
  exec env - \
    LD_LIBRARY_PATH=/usr/lib/mesa-diverted/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu/mesa:/usr/lib/x86_64-linux-gnu/dri:/usr/lib/x86_64-linux-gnu/gallium-pipe \
    PATH=... \
    PWD=/proc/self/cwd \
  external/toolchains_musl++toolchains_musl+musl-1_2_3-platform-x86_64-unknown-linux-gnu-target-x86_64-linux-musl/bin/x86_64-linux-musl-gcc -U_FORTIFY_SOURCE '-D_FORTIFY_SOURCE=1' -fstack-protector -Wall -Wunused-but-set-parameter -Wno-free-nonheap-object -fno-omit-frame-pointer '-std=c++14' -MD -MF bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d -fPIC -iquote . -iquote bazel-out/k8-fastbuild/bin -iquote external/bazel_tools -iquote bazel-out/k8-fastbuild/bin/external/bazel_tools '-frandom-seed=bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.o' -no-canonical-prefixes -fno-canonical-system-headers -Wno-builtin-macro-redefined '-D__DATE__="redacted"' '-D__TIMESTAMP__="redacted"' '-D__TIME__="redacted"' -c hello.cc -o bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.o)
# Configuration: 3723722276aac1314320ca9a9fb2a278d80e4eb3b422da8939e984231a537159
# Execution platform: @@platforms//host:host
# Runner: sandbox-fallback
SUBCOMMAND: # //:hello [action 'Linking hello', configuration: 3723722276aac1314320ca9a9fb2a278d80e4eb3b422da8939e984231a537159, execution platform: @@platforms//host:host, mnemonic: CppLink]
(cd /home/f/.cache/bazel/_bazel_f/f4a07668797e2b42c8e60c02cf2e35a9/execroot/_main && \
  exec env - \
    LD_LIBRARY_PATH=/usr/lib/mesa-diverted/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu/mesa:/usr/lib/x86_64-linux-gnu/dri:/usr/lib/x86_64-linux-gnu/gallium-pipe \
    PATH=/home/f/.cache/bazelisk/downloads/sha256/b4bae524f58e00a69f7c6fa10e62a91f85bfee586105dd480dccb4300c7cbca5/bin:/home/filmil/code/fzf/bin:/home/f/.local/bin:/home/f/.local/opt/fuchsia-sdk/tools/x64:/home/f/.local/opt/fuchsia-sdk:/home/f/.local/opt/depot_tools:/home/f/.local/opt/dart-sdk/bin:/home/f/.local/opt/dart-sdk/bin:/home/f/.local/opt/go/bin:/home/f/.cargo/bin:/home/f/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/f/.cabal/bin:/home/f/.ghcup/bin:/home/f/code/fzf/bin:/home/f/local/bin:/home/f/.cargo/bin:/home/f/.local/bin:/home/f/local/opt/dart-sdk/bin:/home/f/local/bin:/home/f/.cargo/bin:/home/f/.local/bin:/home/f/local/opt/dart-sdk/bin \
    PWD=/proc/self/cwd \
  external/toolchains_musl++toolchains_musl+musl-1_2_3-platform-x86_64-unknown-linux-gnu-target-x86_64-linux-musl/bin/x86_64-linux-musl-gcc @bazel-out/k8-fastbuild/bin/hello-0.params)
# Configuration: 3723722276aac1314320ca9a9fb2a278d80e4eb3b422da8939e984231a537159
# Execution platform: @@platforms//host:host
# Runner: sandbox-fallback
INFO: Found 1 target...
Target //:hello up-to-date:
  bazel-bin/hello
INFO: Elapsed time: 5.606s, Critical Path: 1.13s
INFO: 6 processes: 4 internal, 2 processwrapper-sandbox.
INFO: Build completed successfully, 6 total actions

```

The resulting program is linked as follows:

```
╰─>$ cat  bazel-out/k8-fastbuild/bin/hello-0.params
-o
bazel-out/k8-fastbuild/bin/hello
bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.o
-static-libgcc
-Wl,-S
-lstdc++
-Wl,-z,relro,-z,now
-no-canonical-prefixes
-pass-exit-codes
-static
```

And, finally:

```
╰─>$ ldd bazel-bin/hello
        not a dynamic executable
```

The binary is fully static, which is what we wanted.

