import requests
import json
import threading


def flood_messages():
    # url do endpoint para enviar mensagens
    url = 'http://localhost:5000/send_news'
    headers = {'Content-Type': 'application/json'}

    while True:
        data = {
            'title': 'OLÁAAAAAAAAAAAAAAAAA',
            'theme': 'baaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
            'description': 'Message Flood AlerttttttTTTTTTTTTTTTTTTT' * 8500
        }

        heavy_processing()

        # enviar a solicitação POST
        requests.post(url, data=json.dumps(data), headers=headers)


def heavy_processing():
    # simular uma operação que consome muita CPU
    x = 0
    for i in range(10**6):
        x += i
    return x


for _ in range(200):
    threading.Thread(target=flood_messages).start()
