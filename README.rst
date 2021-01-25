Vince's Python Library Cookie Cutter
====================================

*Vince's obnoxiously opinionated Python library cookie cutter*

Prereq Assumptions
------------------

This assumes the following; that you:

1. Are using Python 3.9
2. Already have ``cookiecutter`` installed
3. Already have ``poetry`` installed
4. Are going to use VSCode

``1`` and ``4`` can be changed after you run this, but the other two are hard reqs.

Installed Dev Tools
-------------------

The following tools are default installed and configured:

- ``bandit`` for checking source code bugs
- ``black`` so we can all stop arguing about code formatting
- ``isort`` so we can all stop arguing about import order
- ``mypy`` for static analysis
- ``nox`` to run tests and be a general task runner
- ``pre-commit`` to ensure pushed code doesn't suck
- ``pylint`` for enforcing style rules
- ``pytest`` to run the tests
- ``pytest-cov`` to measure test coverage
- ``pytest-it`` so we can write tests spec-style
- ``safety`` to check that our dependencies don't have CVEs

Output Layout
-------------

The output is a project directory with the library code in ``src`` code layout. That is,
the source packages you write are all under a ``src`` directory. This also assumes
you're writing type-stubs along-side your modules.

The tests live in their own directory and follow the same package name convention. There
is also a ``tests/utils.py`` module that provides some convenience wrappers around
``pytest-it`` decorators (I think my version is more literate when reading the test
source code).

.. code-block:: text

   my-project
   ├── .gitignore
   ├── .pre-commit-config.yaml
   ├── .vscode
   │   └── settings.json
   ├── COPYING
   ├── LICENSE
   ├── README.rst
   ├── noxfile.py
   ├── poetry.lock
   ├── pyproject.toml
   ├── src
   │   └── my_project
   │       ├── __init__.py
   │       └── __init__.pyi
   └── tests
      ├── __init__.py
      ├── my_project
      │   └── __init__.py
      └── utils.py

   5 directories, 14 files

Usage
-----

.. code-block:: shell

   cd your/projects/dir
   cookiecutter https://github.com/vforgione/cookiecutter-py-lib
   # or
   cookiecutter https://gitlab.com/vforgione/cookiecutter-py-lib

User Configuration:

- ``author_name`` is your name; full, handle, whatever
- ``author_email`` is your email address
- ``project_name`` is the *Title Case Name of Your Project*
- ``project_slug`` is a generated value; e.g. ``My Project`` becomes ``my-project``
- ``package_name`` is a generated value; e.g. ``My Project`` becomes ``my_project``
- ``short_description`` is a short description of the project
- ``license`` is a choice of the MIT license or the GNU GPL v3.0 license

**A note about licenses:** I use MIT when I don't care about keeping the work out of the
hands of filthy corporate types. GNU GPL v3.0 is the license to choose to ensure that
the code is forever open.
