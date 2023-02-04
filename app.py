from flask import Flask, render_template, redirect, url_for, flash, request
import flask_login
from flask_login import login_required, current_user
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from pathlib import Path
import os
from dotenv import load_dotenv

# Environment variables
load_dotenv()

# Flask
BASE_DIR = Path(__file__).resolve().parent
app = Flask(__name__, static_folder="static", static_url_path="")
app.secret_key = os.getenv('SECRET_KEY')

# Database
db = SQLAlchemy()
app.config["SQLALCHEMY_DATABASE_URI"] = f"mysql://readonly:readonly@" \
                                        f"localhost:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
db.init_app(app)

# Login manager
login_manager = flask_login.LoginManager()
login_manager.init_app(app)


class User(flask_login.UserMixin):
    pass


@login_manager.user_loader
def user_loader(username):
    user = User()
    user.id = username
    return user


# Routes
@app.route('/')
def home():
    return render_template("home.html")


@app.route('/about')
def about():
    return render_template("about.html")


@app.route('/events')
def events():
    return render_template("events.html")


@app.route('/boats')
def boats():
    return render_template("boats.html")


@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('members'))

    return render_template("login.html")


@app.route('/logout')
def logout():
    flask_login.logout_user()
    flash("Successfully logged out", "success")
    return redirect(url_for('home'))


@app.route('/members')
@login_required
def members():
    return render_template("base.html")


if __name__ == '__main__':
    app.run(debug=os.getenv('DEBUG', 'False') == 'True')
