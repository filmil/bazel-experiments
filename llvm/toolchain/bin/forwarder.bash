#! /usr/bin/env bash

readonly _scriptname="$(basename ${0})"
echo "${_scriptname}"

"external/toolchains_llvm++llvm+llvm_toolchain/${_scriptname}" \
    "${@}"

# vim: ft=bash :
