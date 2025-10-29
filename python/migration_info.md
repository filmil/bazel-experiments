# Migration info
Command for local testing:
```
bazel build --enable_bzlmod --noenable_workspace //...
```
## Direct dependencies:
* pypi__setuptools
* pypi__more_itertools
* pypi__pip
* pypi__colorama
* pypi__pip_tools
* pypi__pep517
* pypi__importlib_metadata
* pypi__click
* pypi__zipp
* rules_python
* pypi_yamllint
* pypi__tomli
* pypi_flask
* pypi__build
## Migration of `pypi__setuptools`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__setuptools instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__setuptools",
  url = "https://files.pythonhosted.org/packages/7c/5b/3d92b9f0f7ca1645cba48c080b54fe7d8b1033a4e5720091d1631c4266db/setuptools-60.10.0-py3-none-any.whl",
  sha256 = "782ef48d58982ddb49920c11a0c5c9c0b02e7d7d1c2ad0aa44e1a1e133051c96",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__more_itertools`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__more_itertools instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__more_itertools",
  url = "https://files.pythonhosted.org/packages/bd/3f/c4b3dbd315e248f84c388bd4a72b131a29f123ecacc37ffb2b3834546e42/more_itertools-8.13.0-py3-none-any.whl",
  sha256 = "c5122bffc5f104d37c1626b8615b511f3427aa5389b94d61e5ef8236bfbc3ddb",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__pip`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__pip instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__pip",
  url = "https://files.pythonhosted.org/packages/09/bd/2410905c76ee14c62baf69e3f4aa780226c1bbfc9485731ad018e35b0cb5/pip-22.3.1-py3-none-any.whl",
  sha256 = "908c78e6bc29b676ede1c4d57981d490cb892eb45cd8c214ab6298125119e077",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__colorama`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__colorama instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__colorama",
  url = "https://files.pythonhosted.org/packages/d1/d6/3965ed04c63042e047cb6a3e6ed1a63a35087b6a609aa3a15ed8ac56c221/colorama-0.4.6-py2.py3-none-any.whl",
  sha256 = "4f1d9991f5acc0ca119f9d443620b77f9d6b33703e51011c16baf57afb285fc6",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__pip_tools`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__pip_tools instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__pip_tools",
  url = "https://files.pythonhosted.org/packages/5e/e8/f6d7d1847c7351048da870417724ace5c4506e816b38db02f4d7c675c189/pip_tools-6.12.1-py3-none-any.whl",
  sha256 = "f0c0c0ec57b58250afce458e2e6058b1f30a4263db895b7d72fd6311bf1dc6f7",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__pep517`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__pep517 instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__pep517",
  url = "https://files.pythonhosted.org/packages/ee/2f/ef63e64e9429111e73d3d6cbee80591672d16f2725e648ebc52096f3d323/pep517-0.13.0-py3-none-any.whl",
  sha256 = "4ba4446d80aed5b5eac6509ade100bff3e7943a8489de249654a5ae9b33ee35b",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__importlib_metadata`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__importlib_metadata instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__importlib_metadata",
  url = "https://files.pythonhosted.org/packages/d7/31/74dcb59a601b95fce3b0334e8fc9db758f78e43075f22aeb3677dfb19f4c/importlib_metadata-1.4.0-py2.py3-none-any.whl",
  sha256 = "bdd9b7c397c273bcc9a11d6629a38487cd07154fa255a467bf704cd2c258e359",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__click`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__click instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__click",
  url = "https://files.pythonhosted.org/packages/76/0a/b6c5f311e32aeb3b406e03c079ade51e905ea630fc19d1262a46249c1c86/click-8.0.1-py3-none-any.whl",
  sha256 = "fba402a4a47334742d782209a7c79bc448911afe1149d07bdabdf480b3e2f4b6",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi__zipp`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__zipp instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__zipp",
  url = "https://files.pythonhosted.org/packages/f4/50/cc72c5bcd48f6e98219fc4a88a5227e9e28b81637a99c49feba1d51f4d50/zipp-1.0.0-py2.py3-none-any.whl",
  sha256 = "8dda78f06bd1674bd8720df8a50bb47b6e1233c503a4eed8e7810686bde37656",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `rules_python`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository rules_python instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:62:13: in <toplevel>
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "rules_python",
  url = "https://github.com/bazelbuild/rules_python/archive/93f5ea2f01ce7eb870d3ad3943eda5d354cdaac5.zip",
  sha256 = "179541b519e8fd7c8fbfd0d2a2a51835cf7c83bd6a8f0f3fd599a0910d1a0981",
  strip_prefix = "rules_python-93f5ea2f01ce7eb870d3ad3943eda5d354cdaac5",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
Found perfect name match in BCR: `rules_python`

Found partially name matches in BCR: `rules_python_gazelle_plugin`

It has been introduced as a Bazel module:

	bazel_dep(name = "rules_python", version = "1.6.3")
## Migration of `pypi_yamllint`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi_yamllint instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:90:13: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/pypi/requirements.bzl:49:20: in install_deps
Repository rule whl_library defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/pip_repository.bzl:712:30: in <toplevel>

```

#### Definition
```python
load("@@rules_python//python/pip_install:pip_repository.bzl", "whl_library")
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
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced using a module extension:

## Migration of `pypi__tomli`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__tomli instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__tomli",
  url = "https://files.pythonhosted.org/packages/97/75/10a9ebee3fd790d20926a90a2547f0bf78f371b2f13aa822c759680ca7b9/tomli-2.0.1-py3-none-any.whl",
  sha256 = "939de3e7a6161af0c887ef91b7d41a53e7c5a1ca976325f429cb46ea9bc30ecc",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi_flask`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi_flask instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:90:13: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/pypi/requirements.bzl:49:20: in install_deps
Repository rule whl_library defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/pip_repository.bzl:712:30: in <toplevel>

```

#### Definition
```python
load("@@rules_python//python/pip_install:pip_repository.bzl", "whl_library")
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
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced using a module extension:

## Migration of `pypi__build`:

<details>
<summary>Click here to see where and how the repo was declared in the WORKSPACE file</summary>

#### Location
```python
Repository pypi__build instantiated at:
  /home/filmil/code/bazel-experiments/python/WORKSPACE:82:10: in <toplevel>
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip.bzl:149:29: in pip_parse
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/rules_python/python/pip_install/repositories.bzl:141:14: in pip_install_dependencies
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/utils.bzl:268:18: in maybe
Repository rule http_archive defined at:
  /home/filmil/.cache/bazel/_bazel_filmil/3d1f86b55f4f3dea80d40229bb0614a9/external/bazel_tools/tools/build_defs/repo/http.bzl:387:31: in <toplevel>

```

#### Definition
```python
load("@@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
  name = "pypi__build",
  url = "https://files.pythonhosted.org/packages/03/97/f58c723ff036a8d8b4d3115377c0a37ed05c1f68dd9a0d66dab5e82c5c1c/build-0.9.0-py3-none-any.whl",
  sha256 = "38a7a2b7a0bdc61a42a0a67509d88c71ecfc37b393baba770fae34e20929ff69",
  type = "zip",
  build_file_content = "package(default_visibility = [\"//visibility:public\"])\n\nload(\"@rules_python//python:defs.bzl\", \"py_library\")\n\npy_library(\n    name = \"lib\",\n    srcs = glob([\"**/*.py\"]),\n    data = glob([\"**/*\"], exclude=[\n        # These entries include those put into user-installed dependencies by\n        # data_exclude in /python/pip_install/tools/bazel.py\n        # to avoid non-determinism following pip install's behavior.\n        \"**/*.py\",\n        \"**/*.pyc\",\n        \"**/*.pyc.*\",  # During pyc creation, temp files named *.pyc.NNN are created\n        \"**/* *\",\n        \"**/*.dist-info/RECORD\",\n        \"BUILD\",\n        \"WORKSPACE\",\n    ]),\n    # This makes this directory a top-level in the python import\n    # search path for anything that depends on this.\n    imports = [\".\"],\n)\n",
)
```
**Tip**: URLs usually show which version was used.
</details>

___
	It is not found in BCR. 

	It has been introduced with `use_repo_rule`:

## Migration of `pypi`
It has been introduced as a python extension:

```
pip.parse(
    hub_name = "pypi",
    requirements_lock = "//third_party:requirements_lock.txt",
    python_version = "3.11",
)
use_repo(pip, "pypi")

python = use_extension("@rules_python//python/extensions:python.bzl", "python")
python.defaults(python_version = "3.11")
python.toolchain(python_version = "3.11")
```
