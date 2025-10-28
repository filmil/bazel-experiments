load("@bazel_skylib//lib:modules.bzl", "modules")
load(
    "@com_github_10XGenomics_rules_conda//:deps.bzl",
    "rules_conda_dependencies",
)
load(
    "@com_github_10XGenomics_rules_conda//:deps2.bzl",
    "second_level_dependencies",
)

conda_ext_level1 = modules.as_extension(rules_conda_dependencies)
conda_ext_level2 = modules.as_extension(second_level_dependencies)

