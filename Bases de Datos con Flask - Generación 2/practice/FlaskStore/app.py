from flask import *
from os import environ
from database import User, Product


app = Flask(__name__)
app.secret_key = environ.get('SECRETKEY')




@app.route("/")
def home():
    return render_template("index.html")





@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'GET':
        return render_template("login.html")
    if request.method == 'POST':
        _email = request.form['email']
        _password = "storeFlask_" + request.form['password']
        user = User.login_user(_email, _password)
        if user:
           session['logged_in'] = True
           session['user_id'] = user.UserID
           session['email'] = _email
           flash('Login success')
           return redirect(url_for('home'))
        else:
            flash('Email or password is incorrect')
            return redirect(url_for('login'))
        




@app.route("/panel", methods=['GET', 'POST'])
def panel():
    if request.method == 'GET':
       return render_template("panel.html")
    elif request.method == 'POST':
        product = request.form['productName'];
        price = request.form['price'];
        picture = request.form['photoUrl'];
        add = Product.add_product(product, price, picture)
        if add:
            return redirect(url_for('home'))
        




@app.route("/register", methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        if User.create_user(email, password):
            return redirect(url_for('login'))

    if request.method == 'GET':
        return render_template("register.html")
    




@app.route('/success')
def success():
    if 'email' in session:
        return render_template("index.html", login=session)
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(debug=True)



