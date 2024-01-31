from os import environ

from flask import Flask, render_template, request, session, redirect, url_for

from database import User

app = Flask(__name__)
app.secret_key = environ.get("SECRET_KEY")

@app.route("/")
def index():
    return render_template("index.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        print(request.form)

        username = request.form.get("username")
        password = request.form.get("password")

        if username and password:
            user = User.create_user(username, password)
            session["user_id"] = User.id

            return redirect(url_for("products"))
        
    return render_template("register.html")
    


@app.route("/products")
def products():
    user = User.get(session["user_id"])
    _products = user.products

    return render_template("./products/index.html", products=_products)


"""
from https://github.com/carogomezt/bootcamp-backend-python2/blob/main/orm-flask/templates/index.html
"""