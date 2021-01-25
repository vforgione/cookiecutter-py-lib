#!/usr/bin/env sh

# if mit license, rm gpl3 copying file
if [[ "{{ cookiecutter.license }}" = "MIT" ]]; then
  echo "deleting COPYING (not needed; re: MIT license)"
  rm COPYING
fi


# poetry init and install dev dependencies
echo "running poetry init"
poetry init \
  --name {{ cookiecutter.project_slug }} \
  --description "{{ cookiecutter.short_description }}" \
  --author "{{ cookiecutter.author_name }} <{{ cookiecutter.author_email }}>" \
  --python "^3.9" \
  --license "{{ cookiecutter.license }}" \
  --no-interaction

echo "running poetry add --dev"
poetry add --dev \
  bandit \
  black \
  darglint \
  isort \
  mypy \
  nox \
  pre-commit \
  pylint \
  pytest \
  pytest-cov \
  pytest-it \
  safety


# add tool configs to pyproject.toml
echo "adding dev tool configs to pyproject.toml"
cat <<EOF >> pyproject.toml

[tool.black]
line-length = 100
target-version = ["py38"]
include = ".pyi?$"
exclude = """
/(
  .git
  | .mypy_cache
  | .nox
  | .pytest_cache
  | .vscode
  | _build
  | build
  | dist
)/
"""

[tool.isort]
profile = "black"

[tool.pylint.messages_control]
disable = [
  "C0330",
  "C0326",
]

[tool.pylint.MASTER]
ignore = []

[tool.pylint.format]
max-line-length = 1000  # let black handle this

[tool.pylint."MESSAGE CONTROL"]
disable = [
  "C0103",
  "C0114",
  "R0902",
  "R0903",
  "R0913",
  "W0212",
]

[tool.pytest.ini_options]
python_files = [
  "test_*.py",
]
addopts = [
  "--tb=native",
  "--cov=src",
  "--cov-report=term-missing",
  "--it",
]

[tool.coverage.run]
omit = []

[tool.coverage.report]
exclude_lines = [
  "cov: disable",
]
omit = []
EOF


# bootstrap vscode settings
echo "bootstrapping vscode config"
mkdir .vscode

line=$( poetry env info | grep Path\: )
IFS=" " read -ra parts <<< "$line"
venv_path="${parts[1]}"

echo "{
  // venv and python
  \"python.venvPath\": \"$venv_path\",
  \"python.pythonPath\": \"$venv_path/bin/python\",

  // formatting
  \"python.formatting.provider\": \"black\",
  \"python.formatting.blackPath\": \"$venv_path/bin/black\",
  \"python.sortImports.path\": \"$venv_path/bin/isort\",

  // linting
  \"python.linting.pylintEnabled\": true,
  \"python.linting.pylintPath\": \"$venv_path/bin/pylint\",
  \"python.linting.mypyEnabled\": true,
  \"python.linting.mypyPath\": \"$venv_path/bin/mypy\",

  // testing
  \"python.testing.pytestEnabled\": true,
  \"python.testing.pytestPath\": \"$venv_path/bin/pytest\",
}
" > .vscode/settings.json
