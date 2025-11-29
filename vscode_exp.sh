#!/bin/bash

VSCODE_PATH="$1"

# ---- Проверка аргумента ----
if [[ -z "$VSCODE_PATH" ]]; then
  echo "Error: путь к конфигам VS Code не указан."
  echo "Usage: ./export_vs_code.sh ~/.config/Code"
  exit 1
fi

# ---- Проверка существования пути ----
if [[ ! -d "$VSCODE_PATH" ]]; then
  echo "Error: указанная директория не существует: $VSCODE_PATH"
  exit 2
fi

# ---- Проверка папки User ----
if [[ ! -d "$VSCODE_PATH/User" ]]; then
  echo "Error: внутри нет директории User: $VSCODE_PATH/User"
  exit 3
fi

mkdir -p vscode

# ---- Копирование ----
cp "$VSCODE_PATH/User/keybindings.json" ./vscode 2>/dev/null
cp "$VSCODE_PATH/User/settings.json" ./vscode 2>/dev/null
cp -r "$VSCODE_PATH/User/snippets" ./vscode/ 2>/dev/null

# ---- Экспорт расширений ----
if command -v code >/dev/null 2>&1; then
  code --list-extensions > ./vscode/extensions.txt
else
  echo "Warning: команда 'code' не найдена. Пропускаю экспорт расширений."
fi

echo "Экспорт VS Code завершён."
