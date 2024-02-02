from flask import *

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/login")
def login():
    return render_template("login.html")


@app.route("/success", methods=['GET'])
def check():
    user = request.args.get("uname")
    if user != 'fox':
        return render_template("success.html", usr=user, pwd='No Access')
    
    password = request.args.get("pwd")
    return render_template("success.html", usr=user, pwd=password)
