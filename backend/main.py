# Flask App
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_cors import CORS
import os
import time

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
app.secret_key = os.urandom(24)
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)


class News(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    theme = db.Column(db.String(50), nullable=False)
    description = db.Column(db.Text, nullable=False)


@app.route('/')
def home():
    time.sleep(1)
    return jsonify({'message': 'Welcome to the DDoS App'})


# registar um novo user sem o validar
@app.route('/register', methods=['POST'])
def register():
    time.sleep(1)
    data = request.json
    username = data.get('username')
    password = data.get('password')
    email = data.get('email')

    new_user = User(username=username, password=password, email=email)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'User registered successfully'})


# login de um user sem o validar
@app.route('/login', methods=['POST'])
def login():
    time.sleep(1)
    data = request.json
    username = data.get('username')
    password = data.get('password')

    user = User.query.filter_by(username=username).first()

    if user:
        return jsonify({'message': 'Login successful'})
    else:
        return jsonify({'message': 'Invalid username or password'}), 401


# mudar a password do user sem verificar a autenticação do mesmo
@app.route('/change_password', methods=['POST'])
def change_password():
    time.sleep(1)
    data = request.json
    username = data.get('username')
    new_password = data.get('new_password')

    user = User.query.filter_by(username=username).first()

    if user:
        user.password = new_password
        db.session.commit()
        return jsonify({'message': 'Password changed successfully'})
    else:
        return jsonify({'message': 'User not found'}), 404


# enviar noticias sem verificações de entrada
@app.route('/send_news', methods=['POST'])
def send_news():
    time.sleep(1)
    data = request.json
    title = data.get('title')
    theme = data.get('theme')
    description = data.get('description')

    new_news = News(title=title, theme=theme, description=description)
    db.session.add(new_news)
    db.session.commit()

    return jsonify({'message': 'News created successfully'})

# busca as noticias


@app.route('/get_news', methods=['GET'])
def get_news():
    time.sleep(1)
    theme = request.args.get('theme')
    if theme:
        news = News.query.filter_by(theme=theme).all()
    else:
        news = News.query.all()

    formatted_news = [{'id': news_item.id, 'title': news_item.title,
                       'theme': news_item.theme, 'description': news_item.description} for news_item in news]

    return jsonify({'news': formatted_news})


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
