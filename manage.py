import sys

from flask.cli import FlaskGroup

from project import create_app, db
from project.api.models import User


app = create_app()
cli = FlaskGroup(create_app=create_app)


@cli.command("recreate_db")
def recreate_db():
    db.drop_all()
    db.create_all()
    db.session.commit()


@cli.command("seed_db")
def seed_db():
    """Seeds db with some initial data."""
    db.session.add(User(username="babak", email="user1@gmail.com"))
    db.session.add(User(username="user2", email="user2@gmail.com"))
    db.session.add(User(username="user3", email="user3@gmail.com"))
    db.session.add(User(username="user4", email="user4@gmail.com"))
    db.session.add(User(username="user5", email="user5@gmail.com"))
    db.session.commit()


if __name__ == "__main__":
    cli()
