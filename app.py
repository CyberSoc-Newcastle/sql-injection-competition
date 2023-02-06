from flask import Flask, render_template, redirect, url_for, flash, request
import flask_login
from flask_login import login_required, current_user
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from pathlib import Path
import os
from dotenv import load_dotenv
from sqlalchemy.exc import ProgrammingError
from random import shuffle

# Environment variables
load_dotenv()

# Flask
BASE_DIR = Path(__file__).resolve().parent
app = Flask(__name__, static_folder="static", static_url_path="")
app.secret_key = os.getenv('SECRET_KEY')

# Database
db = SQLAlchemy()
app.config["SQLALCHEMY_DATABASE_URI"] = f"mysql://readonly:readonly@localhost:{os.getenv('DB_PORT')}/boat_club"
app.config["SQLALCHEMY_BINDS"] = {
    "3rd_company": f"mysql://readonly2:readonly2@localhost:{os.getenv('DB_PORT')}/geordie_boat_rentals_ltd"
}
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
                                          f"public=1 ORDER BY rating DESC LIMIT 6")).fetchall()
        query_text = f'Showing most popular events'

    return render_template("events.html", query=query_text, events=results)


@app.route('/boats')
def boats():
    results = db.session.execute(text(f"SELECT name, img FROM boats WHERE secret=0")).fetchall()
    shuffle(results)
    return render_template("boats.html", boats=results[:6])


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
    args = request.args
    category = args.get('category', 'Jet Ski')
    results = db.session.execute(text(f"SELECT name, price FROM boats WHERE category='{category}'"),
                                 bind_arguments={'bind': db.engines.get('3rd_company')}).fetchall()

    return render_template("members/rent_boat.html", category=category, results=results)


@app.route('/members/search')
@login_required
def members_search():
    args = request.args
    query = args.get('query')
    results = []
    query_text = "Enter a name to search"
    if query:
        results = db.session.execute(text(f"SELECT fullname FROM users WHERE "
                                          f"LOWER(fullname) LIKE '%{query.lower()}%'")).fetchall()
        query_text = f'Showing {len(results)} result(s) for "{query}"'

    return render_template("members/search.html", query=query_text, results=results)


@app.route('/members/motto')
@login_required
def member_motto():
    return render_template("members/motto.html", motto="Carp is love, carp is life!")


@app.route('/admin')
@login_required
def admin():
    if current_user.role != "admin":
        return render_template("admin/msg.html", title="Unauthorised",
                               msg="You need to have the role 'admin' to see the content of this page"), 401

    return render_template("admin/actions.html")


@app.route('/admin/motto')
@login_required
def admin_motto():
    if current_user.role != "admin":
        return render_template("admin/msg.html", title="Unauthorised",
                               msg="You need to have the role 'admin' to see the content of this page"), 401

    return render_template("admin/motto.html", motto="The admins rule the seas!")


@app.route('/admin/secure')
@login_required
def secure_access():
    if current_user.role != "admin":
        return render_template("admin/msg.html", title="Unauthorised",
                               msg="You need to have the role 'admin' to see the content of this page"), 401

    if request.headers.get('User-Agent') != 'Top Secret Boat Club Browser':
        return render_template("admin/msg.html", title="Unauthorised",
                               msg="You need to be using 'Top Secret Boat Club Browser' to see the content "
                                   "of this page"), 401

    return render_template("admin/secure.html", msg="The treasure is buried next to the statue of John Hook")


# Error handler for SQL
@app.errorhandler(ProgrammingError)
def error_sql(error):
    error_msg = str(error)
    return render_template("error.html", msg=error_msg.split("\n")), 500


if __name__ == '__main__':
    app.run(debug=os.getenv('DEBUG', 'False') == 'True')
