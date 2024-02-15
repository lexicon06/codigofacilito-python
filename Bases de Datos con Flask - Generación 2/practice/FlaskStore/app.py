from flask import *


app = Flask(__name__)
app.secret_key = 'your secret key'




@app.route("/")
def home():
    return render_template("index.html")


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        # Check if the email and password are correct
        if email == 'correct email' and password == 'correct password':
            session['email'] = email
            return redirect(url_for('success'))
        else:
            return render_template('login.html', loginSuccess=False)

    return render_template('login.html', loginSuccess=None)


@app.route("/register", methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        if email == "fox@gnula.nu" and password == '123':
            return redirect(url_for('home'))

    if request.method == 'GET':
        return render_template("register.html")


@app.route('/success')
def success():
    if 'email' in session:
        return 'Logged in as ' + session['email']
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)



