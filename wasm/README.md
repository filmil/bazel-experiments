# Bazel Golang WASM with Proto

## Pre-Reqs:

1. Bazel

## How to run

1. `bazel run //server`
2. `open localhost:7000`

## Bugs

* protobuf toolchain compilation lasts forever. Luckily, it's only done once.
