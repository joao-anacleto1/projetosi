import sys
import threading
import time
import requests

# Parse inputs
host = "localhost"
port = 5000  # porta do servidor flask
num_requests = 1000  # numero de get's a serem enviados

if len(sys.argv) == 2:
    num_requests = int(sys.argv[1])
else:
    print("Usage: python script.py <Number_of_Requests>")
    sys.exit(1)

# função do ataque


def attack():
    try:
        # enviar get's para a rota de buscar as notícias
        response = requests.get(f"http://{host}:{port}/get_news")
        # imprime a resposta
        # print(response.text)
    except Exception as e:
        print(f"\n [Error occurred]: {e}")


print(
    f"[#] Attack started on {host}:{port}/get_news || # Requests: {num_requests}")

# armazenamento de todas as threads
all_threads = []

# cria threads para enviar solicitações concorrentes
for i in range(num_requests):
    t = threading.Thread(target=attack)
    t.start()
    all_threads.append(t)
    # ajusta o tempo de espera para controlar as solicitações
    time.sleep(0.01)

# aguarda a conclusão de todas as threads
for t in all_threads:
    t.join()

print("Attack completed.")
