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
def user_loader(user_id):
    args = user_id.split(",", 1)
    if len(args) != 2:
        return None
    user = User()
    user.id = user_id
    user.username = args[0]
    user.role = args[1]
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
    args = request.args
    query = args.get('query')
    if query:
        results = db.session.execute(text(f"SELECT title, description FROM events WHERE "
                                         f"LOWER(title) LIKE '%{query.lower()}%' AND public=1")).fetchall()
        query_text = f'Showing {len(results)} result(s) for "{query}"'
    else:
        results = db.session.execute(text(f"SELECT title, description FROM events WHERE "
                                          f"public=1 ORDER BY rating LIMIT 6")).fetchall()
        query_text = f'Showing top events'

    return render_template("events.html", query=query_text, events=results)


@app.route('/boats')
def boats():
    return render_template("boats.html")


@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('members'))

    if request.method == "GET":
        return render_template("login.html")

    username = request.form.get('username', '')
    password = request.form.get('password', '')
    result = db.session.execute(text(f"SELECT username, role from users "
                                     f"WHERE username='{username}' AND password=MD5('{password}')")).first()

    if result:
        user = User()
        user.id = f"{result.username},{result.role}"
        user.username = result.username
        user.role = result.role
        flask_login.login_user(user)
        flash(f"Successfully logged in as {user.username}", "success")
        return redirect(url_for('members'))

    flash("Incorrect username/password", "danger")
    return render_template("login.html")


@app.route('/logout')
def logout():
    flask_login.logout_user()
    flash("Successfully logged out", "success")
    return redirect(url_for('home'))


@app.route('/members')
@login_required
def members():
    return render_template("members/actions.html")


@app.route('/members/rent')
@login_required
def rent_boat():
    return render_template("members/rent_boat.html")


@app.route('/members/search')
@login_required
def members_search():
    return render_template("members/search.html")


@app.route('/members/motto')
@login_required
def member_motto():
    return render_template("members/motto.html", motto="Carp is love, carp is life!")


@app.route('/admin')
@login_required
def admin():
    return render_template("base.html")


if __name__ == '__main__':
    app.run(debug=os.getenv('DEBUG', 'False') == 'True')
