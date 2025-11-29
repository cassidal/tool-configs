fleet() {
  local target="$1"
  if [ -z "$target" ]; then
    target="."
  fi

  local bin="$HOME/.local/share/JetBrains/Toolbox/apps/fleet/bin/Fleet"

  if [ -d "$target" ]; then
    # это папка — открываем как проект
    local proj="$(cd "$target" && pwd)"
    /usr/bin/nohup "$bin" "$proj" >/dev/null 2>&1 &
  elif [ -f "$target" ]; then
    # это файл — открываем его папку как проект + сам файл
    local dir="$(cd "$(dirname "$target")" && pwd)"
    local file="$(basename "$target")"
    /usr/bin/nohup "$bin" "$dir" "$file" >/dev/null 2>&1 &
  else
    echo "Fleet: '$target' не существует"
  fi
}
