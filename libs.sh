#!/bin/sh
set -eu

detect_lang() {
  l="${LANG:-}${LC_ALL:-}${LANGUAGE:-}"
  l=$(printf '%s' "$l" | tr '[:upper:]' '[:lower:]')
  case "$l" in
    pt*|br*) echo pt ;;
    es*|spa*) echo es ;;
    ru*|rus*) echo ru ;;
    *) echo en ;;
  esac
}

MSG_LANG=$(detect_lang)

t() {
  key="$1"
  case "$MSG_LANG" in
    pt)
      case "$key" in
        title) echo "SkyTools.Linux — instalador de dependências" ;;
        detecting) echo "Detectando gerenciador de pacotes..." ;;
        installing) echo "Instalando: nodejs curl python3 unzip" ;;
        ok) echo "Dependências instaladas com sucesso." ;;
        fail) echo "Falha ao instalar pacotes." ;;
        unsupported) echo "Gerenciador de pacotes não suportado. Instale manualmente: nodejs curl python3 unzip" ;;
        need_root) echo "É necessário privilégio de administrador (sudo)." ;;
        verify) echo "Verificando instalações..." ;;
        missing) echo "Ainda faltando:" ;;
        all_ok) echo "Tudo pronto." ;;
        node_ok) echo "Node.js:" ;;
        curl_ok) echo "curl:" ;;
        py_ok) echo "Python3:" ;;
        unzip_ok) echo "unzip:" ;;
        not_found) echo "não encontrado" ;;
        *) echo "$key" ;;
      esac
      ;;
    es)
      case "$key" in
        title) echo "SkyTools.Linux — instalador de dependencias" ;;
        detecting) echo "Detectando gestor de paquetes..." ;;
        installing) echo "Instalando: nodejs curl python3 unzip" ;;
        ok) echo "Dependencias instaladas correctamente." ;;
        fail) echo "Error al instalar paquetes." ;;
        unsupported) echo "Gestor de paquetes no compatible. Instale manualmente: nodejs curl python3 unzip" ;;
        need_root) echo "Se requieren privilegios de administrador (sudo)." ;;
        verify) echo "Verificando instalaciones..." ;;
        missing) echo "Aún falta:" ;;
        all_ok) echo "Todo listo." ;;
        node_ok) echo "Node.js:" ;;
        curl_ok) echo "curl:" ;;
        py_ok) echo "Python3:" ;;
        unzip_ok) echo "unzip:" ;;
        not_found) echo "no encontrado" ;;
        *) echo "$key" ;;
      esac
      ;;
    ru)
      case "$key" in
        title) echo "SkyTools.Linux — установщик зависимостей" ;;
        detecting) echo "Определение пакетного менеджера..." ;;
        installing) echo "Установка: nodejs curl python3 unzip" ;;
        ok) echo "Зависимости успешно установлены." ;;
        fail) echo "Не удалось установить пакеты." ;;
        unsupported) echo "Пакетный менеджер не поддерживается. Установите вручную: nodejs curl python3 unzip" ;;
        need_root) echo "Требуются права администратора (sudo)." ;;
        verify) echo "Проверка установки..." ;;
        missing) echo "Ещё отсутствует:" ;;
        all_ok) echo "Всё готово." ;;
        node_ok) echo "Node.js:" ;;
        curl_ok) echo "curl:" ;;
        py_ok) echo "Python3:" ;;
        unzip_ok) echo "unzip:" ;;
        not_found) echo "не найдено" ;;
        *) echo "$key" ;;
      esac
      ;;
    *)
      case "$key" in
        title) echo "SkyTools.Linux — dependency installer" ;;
        detecting) echo "Detecting package manager..." ;;
        installing) echo "Installing: nodejs curl python3 unzip" ;;
        ok) echo "Dependencies installed successfully." ;;
        fail) echo "Failed to install packages." ;;
        unsupported) echo "Unsupported package manager. Install manually: nodejs curl python3 unzip" ;;
        need_root) echo "Administrator privileges required (sudo)." ;;
        verify) echo "Verifying installations..." ;;
        missing) echo "Still missing:" ;;
        all_ok) echo "All set." ;;
        node_ok) echo "Node.js:" ;;
        curl_ok) echo "curl:" ;;
        py_ok) echo "Python3:" ;;
        unzip_ok) echo "unzip:" ;;
        not_found) echo "not found" ;;
        *) echo "$key" ;;
      esac
      ;;
  esac
}

run_as_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    echo "$(t need_root)"
    exit 1
  fi
}

echo "$(t title)"
echo "$(t detecting)"

if command -v apt-get >/dev/null 2>&1; then
  echo "$(t installing)"
  run_as_root apt-get update -y
  run_as_root apt-get install -y nodejs curl python3 unzip || { echo "$(t fail)"; exit 1; }
elif command -v dnf >/dev/null 2>&1; then
  echo "$(t installing)"
  run_as_root dnf install -y nodejs curl python3 unzip || { echo "$(t fail)"; exit 1; }
elif command -v yum >/dev/null 2>&1; then
  echo "$(t installing)"
  run_as_root yum install -y nodejs curl python3 unzip || { echo "$(t fail)"; exit 1; }
elif command -v pacman >/dev/null 2>&1; then
  echo "$(t installing)"
  run_as_root pacman -Sy --noconfirm --needed nodejs curl python unzip || { echo "$(t fail)"; exit 1; }
elif command -v zypper >/dev/null 2>&1; then
  echo "$(t installing)"
  run_as_root zypper install -y nodejs curl python3 unzip || { echo "$(t fail)"; exit 1; }
elif command -v apk >/dev/null 2>&1; then
  echo "$(t installing)"
  run_as_root apk add --no-cache nodejs curl python3 unzip || { echo "$(t fail)"; exit 1; }
else
  echo "$(t unsupported)"
  exit 1
fi

echo "$(t ok)"
echo "$(t verify)"

MISSING=""
if command -v node >/dev/null 2>&1; then
  echo "$(t node_ok) $(node -v 2>/dev/null || true)"
else
  echo "$(t node_ok) $(t not_found)"
  MISSING="${MISSING} node"
fi

if command -v curl >/dev/null 2>&1; then
  echo "$(t curl_ok) $(curl --version 2>/dev/null | head -1 || true)"
else
  echo "$(t curl_ok) $(t not_found)"
  MISSING="${MISSING} curl"
fi

if command -v python3 >/dev/null 2>&1; then
  echo "$(t py_ok) $(python3 --version 2>/dev/null || true)"
else
  echo "$(t py_ok) $(t not_found)"
  MISSING="${MISSING} python3"
fi

if command -v unzip >/dev/null 2>&1; then
  echo "$(t unzip_ok) $(unzip -v 2>/dev/null | head -1 || true)"
else
  echo "$(t unzip_ok) $(t not_found)"
  MISSING="${MISSING} unzip"
fi

if [ -n "$MISSING" ]; then
  echo "$(t missing)${MISSING}"
  exit 1
fi

echo "$(t all_ok)"
