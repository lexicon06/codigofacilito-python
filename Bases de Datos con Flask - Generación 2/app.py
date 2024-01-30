from os import environ

from flask import Flask, render_template, request, session, redirect, url_for

app = Flask(__name__)
app.secret_key = environ.get("SECRET_KEY")

@app.route("/")
def index():
    return render_template("index.html")


"""
from https://github.com/carogomezt/bootcamp-backend-python2/blob/main/orm-flask/templates/index.html
"""