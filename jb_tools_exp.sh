#!/bin/bash

IDE_NAME="$1"

if [[ -z "$IDE_NAME" ]]; then
  echo "Usage: ./export_jb.sh idea | goland | clion | datagrip | pycharm | webstorm | rider"
  exit 1
fi

BASE_DIR="$HOME/.config/JetBrains"

# Найти все папки IDE типа GoLand2025.2, IntelliJIdea2025.2 и т.д.
IDE_DIR=$(find "$BASE_DIR" -maxdepth 1 -type d \
  -iname "*${IDE_NAME}*" \
  | sort -V \
  | tail -n 1)

if [[ -z "$IDE_DIR" ]]; then
  echo "Error: не найдено конфигов для IDE: $IDE_NAME"
  exit 2
fi

echo "Найдена IDE: $IDE_DIR"

EXPORT_DIR="jb_${IDE_NAME}"
mkdir -p "$EXPORT_DIR"

# Основные каталоги JetBrains
for folder in options keymaps codestyles colors eval uiSettings; do
  if [[ -d "$IDE_DIR/$folder" ]]; then
    cp -r "$IDE_DIR/$folder" "$EXPORT_DIR/"
  fi
done

echo "Экспорт завершён."
echo "Файлы → $EXPORT_DIR/"
