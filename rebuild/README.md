# Not rebuilding if srcs change

This example shows that bazel is not rebuilding cc_binary if a header that is
mentioned in 'srcs' but not actually included changes.

To reproduce do the following:

```
bazel build //...  # Prepare everything.
bazel build //... --subcommands  # Note that nothing is rebuilt.
# Now change //1/hello.h a bit.
bazel build //1/... --subcommands # to confirm that binary is not rebuilt
# Now change //2/hello.h a bit.
bazel build //2/... --subcommands # to confirm that binary is rebuilt
diff -u 1/ 2/ # to see the difference.

```
