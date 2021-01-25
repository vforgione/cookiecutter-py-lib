import tempfile
import nox

_ = lambda cmd: cmd.split(" ")


@nox.session(python=False)
def format(session):
    """Format source and test code
    """
    session.run(_("poetry run black src"), external=True)
    session.run(_("poetry run black tests"), external=True)
    session.run(_("poetry run isort src"), external=True)
    session.run(_("poetry run isort tests"), external=True)


@nox.session(python=False)
def lint(session):
    """Lint source code
    """
    session.run(_("poetry run pylint src"), external=True)
    session.run(_("poetry run mypy src"), external=True)


@nox.session(python=False)
def vet(session):
    """Check for bugs and dependency CVEs
    """
    session.run(_("poetry run bandit -r src"), external=True)

    with tempfile.NamedTemporaryFile() as reqs:
        session.run(_(
            f"poetry export --dev --format=requirements.txt --without-hashes --output={reqs}"
        ), external=True)
        session.run(_(f"safety check --file={reqs} --full-report"), external=True)


@nox.session
def test(session):
    """Run test suite
    """
    session.install("poetry")
    session.run(_("poetry install"))
    session.run(_("poetry run pytest"))
