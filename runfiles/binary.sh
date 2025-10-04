#] # Example of the use of `runfiles.bash`
#]
#] This is an example of cross-repository use of runfiles resolution in bazel.
#]
#] For some reason I could not find one, so I decided to write one.
#]
#] The scenario under test is as follows:
#] * There is a script in repo @runfiles, called [`@runfiles//:binary`](./binary.sh) which
#] uses runfiles to call a library [`//:library`](./library.sh).
#] * There is an integration repository which has a script that calls `@runfiles//:binary`.
#]
#] Now when `@runfiles//:binary` is called, then the call to rlocation resolution depends
#] on the apparent name of the repo as seen from the `integration` repository. This name
#] is implementation dependent, and will be different in bazel 8.x vs bazel 7.x vs
#] any future bazel version. It is important that the library script is written so
#] that this variation is abstracted away.
#]
#] Blurbs away first.

#! /bin/bash
# vim: filetype=bash
#

#] This next part was copied verbatim from [bazel documentation][bd], which is surprisingly
#] difficult to find.
#]
#] It gives you a bash function `rlocation` that you can use to resolve the actual location
#] of a file, based on its location in the build tree. It also gives you a function
#] `runfiles_current_repository` which is supposed to return the apparent name of the
#] repo that your script is running in.
#]
#] [bd]: https://bazel.googlesource.com/bazel/+/refs/heads/release-7.0.0-pre.20230302.1rc1/tools/bash/runfiles/runfiles.bash
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

#] This part ensures that the correct function is called. When called from this repository,
#] the call to `$(runfiles_current_repository)` evaluates to `_main`. But if called from
#] the integration repository it will evaluate to, in this case `runfiles~`. Note that
#] if we were to change [bazel version](./integration/.bazelversion) to say `8.4.1`, then
#] the evaluation would change and would now be `runfiles+` because the naming schema had
#] changed.

readonly _library="$(rlocation $(runfiles_current_repository)/library.sh)"

#] Once we compute the location of `library.sh`, we can call it. The call prints
#] out `hello world`.

"${_library}"

#] You can test the repository by executing:
#]
#] ```
#] bazel test //... && cd integration && bazel test //... && cd -
#] ```
#]
#] This will test both the `runfiles` repository and its integration, and if both
#] pass, the script is correctly called.
#]
#] See also the literate docs for [integration/binary.sh](./integration/binary.sh.md)
