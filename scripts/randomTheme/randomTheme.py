import os
import json
import random
import requests
import argparse

extensions_dir = os.path.join(os.getenv('HOME'), '.vscode', 'extensions')
themes = []

def find_themes(extension_path):
    package_json_path = os.path.join(extension_path, 'package.json')

    try:
        with open(package_json_path, 'r', encoding='utf-8') as f:
            package_json = json.load(f)
            if (
                package_json.get('categories') and
                'Themes' in package_json['categories'] and
                package_json.get('contributes') and
                package_json['contributes'].get('themes')
            ):
                theme_labels = [theme['label'] for theme in package_json['contributes']['themes']]
                themes.extend(theme_labels)
    except Exception as e:
        print(f"Error reading or parsing {package_json_path}: {str(e)}")

def list_and_process_extensions(dir):
    try:
        files = os.listdir(dir)
        for file in files:
            full_path = os.path.join(dir, file)
            if os.path.isdir(full_path):
                package_json_path = os.path.join(full_path, 'package.json')
                if os.path.exists(package_json_path):
                    find_themes(full_path)
    except Exception as e:
        print(f"Error reading directory {dir}: {str(e)}")

def get_random_theme():
    if len(themes) == 0:
        print('No themes found.')
        return None
    return random.choice(themes)

def send_post_request(theme):
    # Aquí agregas la lógica para enviar el POST a tu endpoint
    # Ejemplo:
    endpoint_url = 'https://example.com/endpoint'
    data = {'theme': theme}
    response = requests.post(endpoint_url, json=data)
    if response.status_code == 200:
        print('POST request successful.')
    else:
        print(f'POST request failed with status code {response.status_code}.')

parser = argparse.ArgumentParser(description='Selecciona temas aleatorios y envía un POST a un endpoint.')
parser.add_argument('--attempts', type=int, default=3, help='Número de intentos (por defecto: 3)')
args = parser.parse_args()

list_and_process_extensions(extensions_dir)
print('Temas encontrados:')
for theme in themes:
    print(f"- {theme}")

for _ in range(args.attempts):
    random_theme = get_random_theme()
    if random_theme:
        print(f"\nTema aleatorio del día: {random_theme}")
        # send_post_request(random_theme)
    else:
        print('\nNo hay temas disponibles para seleccionar aleatoriamente.')
