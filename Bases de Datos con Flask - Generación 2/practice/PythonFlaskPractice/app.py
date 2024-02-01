from flask import Flask, render_template, request, session, redirect, url_for, jsonify


app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")


@app.route("/login")
def login():
    return render_template("login.html")

@app.route('/jsondemo')
def return_json():
    print(request.headers)
    print(request.method)
    print(request.content_encoding)
    data = {'name': 'John', 'age': 30, 'city': 'New York'}
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)