from flask import *


app = Flask(__name__)

app.secret_key = 'your secret key'


userLoggedIn:bool = True

@app.route("/")
def home():
    return render_template("index.html", active=userLoggedIn)


@app.route("/login")
def register():
    return render_template("login.html")