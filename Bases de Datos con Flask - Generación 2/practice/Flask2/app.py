from flask import *

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/login")
def login():
    return render_template("login.html")

@app.route("/register")
def register():
    return render_template("register.html")


@app.route("/success", methods=['POST'])
def check():
    user = request.form.get("uname")
    if user != 'fox':
        return render_template("success.html", usr=user, pwd='No Access')
    
    password = request.form.get("pwd")
    return render_template("success.html", usr=user, pwd=password)
