from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask import session
import os

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


class Message(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sender_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    content = db.Column(db.Text, nullable=False)


class News(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    theme = db.Column(db.String(50), nullable=False)
    description = db.Column(db.Text, nullable=False)


@app.route('/')
def home():
    return jsonify({'message': 'Welcome to the DDoS App'})


# registrar um novo utilizador
@app.route('/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    email = data.get('email')
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

    new_user = User(username=username, password=hashed_password, email=email)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'User registered successfully'})


# login do utilizador
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    user = User.query.filter_by(username=username).first()

    if user and bcrypt.check_password_hash(user.password, password):
        return jsonify({'message': 'Login successful'})
    else:
        return jsonify({'message': 'Invalid username or password'}), 401


# envio de mensagens


@app.route('/send_message', methods=['POST'])
def send_message():
    data = request.json
    sender_id = data.get('sender_id')
    content = data.get('content')

    new_message = Message(sender_id=sender_id, content=content)
    db.session.add(new_message)
    db.session.commit()

    return jsonify({'message': 'Message sent successfully'})


# receber mensagens
@app.route('/get_messages', methods=['GET'])
def get_messages():
    messages = Message.query.all()
    formatted_messages = [{'id': message.id, 'sender_id': message.sender_id,
                           'content': message.content} for message in messages]
    return jsonify({'messages': formatted_messages})


# editar o perfil de utilizador
@app.route('/edit_profile/<int:user_id>', methods=['PUT'])
def edit_profile(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({'message': 'User not found'}), 404

    data = request.json
    user.username = data.get('username', user.username)
    user.email = data.get('email', user.email)

    db.session.commit()

    return jsonify({'message': 'Profile updated successfully'})


# eliminar uma mensagem
@app.route('/delete_message/<int:message_id>', methods=['DELETE'])
def delete_message(message_id):
    message = Message.query.get(message_id)
    if not message:
        return jsonify({'message': 'Message not found'}), 404

    db.session.delete(message)
    db.session.commit()

    return jsonify({'message': 'Message deleted successfully'})


# mudança da password
@app.route('/change_password', methods=['POST'])
def change_password():
    data = request.json
    username = data.get('username')
    old_password = data.get('old_password')
    new_password = data.get('new_password')

    user = User.query.filter_by(username=username).first()

    if not user or not bcrypt.check_password_hash(user.password, old_password):
        return jsonify({'message': 'Invalid username or password'}), 401

    hashed_new_password = bcrypt.generate_password_hash(
        new_password).decode('utf-8')
    user.password = hashed_new_password
    db.session.commit()

    return jsonify({'message': 'Password changed successfully'})


@app.route('/send_news', methods=['POST'])
def send_news():
    data = request.json
    print(data)  # Adicione esta linha para verificar os dados recebidos
    title = data.get('title')
    theme = data.get('theme')
    description = data.get('description')

    new_news = News(title=title, theme=theme, description=description)
    db.session.add(new_news)
    db.session.commit()

    return jsonify({'message': 'News created successfully'})


@app.route('/get_news', methods=['GET'])
def get_news():
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
