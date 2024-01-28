from functools import wraps
from flask import Flask, redirect, render_template, request, session, url_for, flash
import logging

logging.basicConfig(filename="debug.log")



app = Flask(__name__) #dunder methods
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/' #required


# login required decorator
def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, **kwargs)
        else:
            flash('You need to login first.')
            return redirect(url_for('login'))
    return wrap



@app.route("/")
@login_required  #added security layer
def home():
    return render_template("index.html")


@app.route("/welcome")
def welcome():
    return render_template("welcome.html")


@app.route("/login", methods=["GET", "POST"])
def login():
    error = None
    if request.method == "POST":
        if request.form["username"] != "admin" or request.form["password"] != "admin":
            error = "Invalid Credentials, Please try again."
        else:
            session["logged_in"] = True
            flash("You were log in")
            return redirect(url_for("home"))
        
    return render_template("login.html", error=error)



@app.route("/logout")
@login_required
def logout():
    session.pop("logged_in", None)
    flash("You were logged out.")

    return redirect(url_for("welcome"))





if __name__ == "__main__":
    app.run(debug=True, port=8000)
    #note to self, when running by using flask run this debugger does not work o.o only when python app.py
    #to run debug with flask run we need to add --debug to command line