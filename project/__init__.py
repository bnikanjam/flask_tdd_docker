import os

from flask import Flask  # new
from flask_sqlalchemy import SQLAlchemy


# instantiate the db
db = SQLAlchemy()


# Application factory
def create_app(script_info=None):

    # instantiate the app
    app = Flask(__name__)

    # set config
    app_settings = os.getenv("APP_SETTINGS")
    app.config.from_object(app_settings)

    # set up extensions
    db.init_app(app)

    # register blueprints
    from project.api.ping import ping_blueprint

    app.register_blueprint(ping_blueprint)

    from project.api.users import users_blueprint

    app.register_blueprint(users_blueprint)

    # shell context for flask cli
    # Register the app and db to the shell; To work with the application context and the database
    # without having to import them directly into the shell
    @app.shell_context_processor
    def ctx():
        return {"app": app, "db": db}

    return app
