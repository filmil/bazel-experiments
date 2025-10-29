load("@rules_python//python/pip_install:pip_repository.bzl", "whl_library")
# -- load statements -- #

def _extension_for_whl_library_impl(ctx):
  whl_library(
    name = "pypi_flask",
    repo = "pypi",
    requirement = "flask==2.0.2     --hash=sha256:7b2fb8e934ddd50731893bdcdb00fc8c0315916f9fcd50d22c7cc1a95ab634e2     --hash=sha256:cb90f62f1d8e4dc4621f52106613488b5ba826b2e1e10a33eac92f723093ab6a",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "pypi_",
    timeout = 600,
  )
  whl_library(
    name = "pypi_yamllint",
    repo = "pypi",
    requirement = "yamllint==1.35.1     --hash=sha256:2e16e504bb129ff515b37823b472750b36b6de07963bd74b307341ef5ad8bdc3     --hash=sha256:7a003809f88324fd2c877734f2d575ee7881dd9043360657cc8049c809eba6cd",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "pypi_",
    timeout = 600,
  )
  whl_library(
    name = "pypi_yamllint",
    repo = "pypi",
    requirement = "yamllint==1.35.1     --hash=sha256:2e16e504bb129ff515b37823b472750b36b6de07963bd74b307341ef5ad8bdc3     --hash=sha256:7a003809f88324fd2c877734f2d575ee7881dd9043360657cc8049c809eba6cd",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "pypi_",
    timeout = 600,
  )
  whl_library(
    name = "pypi_flask",
    repo = "pypi",
    requirement = "flask==2.0.2     --hash=sha256:7b2fb8e934ddd50731893bdcdb00fc8c0315916f9fcd50d22c7cc1a95ab634e2     --hash=sha256:cb90f62f1d8e4dc4621f52106613488b5ba826b2e1e10a33eac92f723093ab6a",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "pypi_",
    timeout = 600,
  )
# -- repo definitions -- #

extension_for_whl_library = module_extension(implementation = _extension_for_whl_library_impl)
