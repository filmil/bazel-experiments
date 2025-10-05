
#] # Here is how the `@runfiles//:binary` target is called from a different repo.
#]
#] First the familiar bootstrapping snippet.

#! /bin/bash
# vim: filetype=bash
#
# --- begin runfiles.bash initialization v3 ---
# Copy-pasted from the Bazel Bash runfiles library v3.
set -uo pipefail; f=bazel_tools/tools/bash/runfiles/runfiles.bash
# shellcheck disable=SC1090
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e
# --- end runfiles.bash initialization v3 ---

#] Note that we refer to the binary using the name of the `@runfiles` repo here.
#] It seems that just using the repository name is enough, no matter what the
#] mangled name is, and no matter what is packaged into the runfiles.
readonly _run_this="$(rlocation runfiles/binary)"
"${_run_this}"
