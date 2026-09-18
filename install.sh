#!/bin/sh

set -u

DISCORD_URL="https://discord.gg/XusNN6Pxe3"
GITHUB_URL="https://github.com/renpyflare"

SKYTOOLS_NAME="skytools-plugin"
SKYTOOLS_DOWNLOAD_URL="https://renpyflare.vercel.app/skytools/SkyTools.Linux.Plugin.zip"
MILLENNIUM_INSTALLER_URL="https://steambrew.app/install.sh"

SYSTEM_LANG=$(printf '%s' "${LANG:-en}" | cut -c1-2)

case "$SYSTEM_LANG" in
    pt)
        TXT_TITLE="SkyTools.Linux Installer"
        TXT_START="Iniciando instalador do SkyTools.Linux..."
        TXT_STEAM_SEARCH="Procurando instalação do Steam..."
        TXT_STEAM_OK="Steam encontrado em:"
        TXT_STEAM_MISSING="Instalação do Steam não encontrada."
        TXT_STEAM_CLOSE="Fechando Steam..."
        TXT_DEPS="Verificando dependências..."
        TXT_DEPS_MISSING="Dependência ausente:"
        TXT_DEP_INSTALL="Instale as dependências necessárias e tente novamente."
        TXT_DOWNLOAD="Baixando SkyTools.Linux..."
        TXT_DOWNLOAD_OK="Download do SkyTools concluído."
        TXT_ZIP_TEST="Validando arquivo ZIP..."
        TXT_ZIP_OK="ZIP válido."
        TXT_PLUGIN_PREP="Preparando diretório de plugins do Millennium..."
        TXT_PLUGIN_CLEAN="Removendo arquivos antigos do SkyTools..."
        TXT_PLUGIN_INSTALL="Extraindo SkyTools diretamente no diretório de plugins..."
        TXT_PLUGIN_OK="SkyTools instalado com sucesso."
        TXT_MILL="Instalando ou atualizando Millennium..."
        TXT_MILL_OK="Millennium instalado com sucesso."
        TXT_CONFIG="Habilitando plugin no Millennium..."
        TXT_CONFIG_OK="Plugin habilitado."
        TXT_BETA="Removendo configuração beta do Steam..."
        TXT_TEMP="Limpando arquivos temporários..."
        TXT_STEAM_START="Iniciando Steam..."
        TXT_DONE="Instalação concluída com sucesso!"
        TXT_RESTART="O Steam será iniciado novamente. A primeira inicialização pode demorar um pouco."
        TXT_ERROR="Falha:"
        TXT_LINKS="Links:"
        TXT_DISCORD="Discord:"
        TXT_GITHUB="GitHub:"
        TXT_PLUGIN="Plugin:"
        TXT_LOCATION="Localização:"
        TXT_MILL_LOCATION="Millennium:"
        ;;
    es)
        TXT_TITLE="Instalador de SkyTools.Linux"
        TXT_START="Iniciando el instalador de SkyTools.Linux..."
        TXT_STEAM_SEARCH="Buscando la instalación de Steam..."
        TXT_STEAM_OK="Steam encontrado en:"
        TXT_STEAM_MISSING="Instalación de Steam no encontrada."
        TXT_STEAM_CLOSE="Cerrando Steam..."
        TXT_DEPS="Comprobando dependencias..."
        TXT_DEPS_MISSING="Falta la dependencia:"
        TXT_DEP_INSTALL="Instala las dependencias necesarias e inténtalo de nuevo."
        TXT_DOWNLOAD="Descargando SkyTools.Linux..."
        TXT_DOWNLOAD_OK="Descarga de SkyTools completada."
        TXT_ZIP_TEST="Validando archivo ZIP..."
        TXT_ZIP_OK="ZIP válido."
        TXT_PLUGIN_PREP="Preparando el directorio de plugins de Millennium..."
        TXT_PLUGIN_CLEAN="Eliminando archivos antiguos de SkyTools..."
        TXT_PLUGIN_INSTALL="Extrayendo SkyTools directamente en el directorio de plugins..."
        TXT_PLUGIN_OK="SkyTools instalado correctamente."
        TXT_MILL="Instalando o actualizando Millennium..."
        TXT_MILL_OK="Millennium instalado correctamente."
        TXT_CONFIG="Habilitando el plugin en Millennium..."
        TXT_CONFIG_OK="Plugin habilitado."
        TXT_BETA="Eliminando configuración beta de Steam..."
        TXT_TEMP="Limpiando archivos temporales..."
        TXT_STEAM_START="Iniciando Steam..."
        TXT_DONE="¡Instalación completada correctamente!"
        TXT_RESTART="Steam se iniciará de nuevo. El primer inicio puede tardar un poco."
        TXT_ERROR="Error:"
        TXT_LINKS="Enlaces:"
        TXT_DISCORD="Discord:"
        TXT_GITHUB="GitHub:"
        TXT_PLUGIN="Plugin:"
        TXT_LOCATION="Ubicación:"
        TXT_MILL_LOCATION="Millennium:"
        ;;
    ru)
        TXT_TITLE="Установщик SkyTools.Linux"
        TXT_START="Запуск установщика SkyTools.Linux..."
        TXT_STEAM_SEARCH="Поиск установки Steam..."
        TXT_STEAM_OK="Steam найден:"
        TXT_STEAM_MISSING="Установка Steam не найдена."
        TXT_STEAM_CLOSE="Закрытие Steam..."
        TXT_DEPS="Проверка зависимостей..."
        TXT_DEPS_MISSING="Отсутствует зависимость:"
        TXT_DEP_INSTALL="Установите необходимые зависимости и повторите попытку."
        TXT_DOWNLOAD="Загрузка SkyTools.Linux..."
        TXT_DOWNLOAD_OK="Загрузка SkyTools завершена."
        TXT_ZIP_TEST="Проверка ZIP-файла..."
        TXT_ZIP_OK="ZIP-файл корректен."
        TXT_PLUGIN_PREP="Подготовка директории плагинов Millennium..."
        TXT_PLUGIN_CLEAN="Удаление старых файлов SkyTools..."
        TXT_PLUGIN_INSTALL="Распаковка SkyTools непосредственно в директорию плагинов..."
        TXT_PLUGIN_OK="SkyTools успешно установлен."
        TXT_MILL="Установка или обновление Millennium..."
        TXT_MILL_OK="Millennium успешно установлен."
        TXT_CONFIG="Включение плагина в Millennium..."
        TXT_CONFIG_OK="Плагин включён."
        TXT_BETA="Удаление beta-конфигурации Steam..."
        TXT_TEMP="Очистка временных файлов..."
        TXT_STEAM_START="Запуск Steam..."
        TXT_DONE="Установка успешно завершена!"
        TXT_RESTART="Steam будет запущен снова. Первый запуск может занять немного больше времени."
        TXT_ERROR="Ошибка:"
        TXT_LINKS="Ссылки:"
        TXT_DISCORD="Discord:"
        TXT_GITHUB="GitHub:"
        TXT_PLUGIN="Плагин:"
        TXT_LOCATION="Расположение:"
        TXT_MILL_LOCATION="Millennium:"
        ;;
    *)
        TXT_TITLE="SkyTools.Linux Installer"
        TXT_START="Starting SkyTools.Linux installer..."
        TXT_STEAM_SEARCH="Searching for Steam installation..."
        TXT_STEAM_OK="Steam found at:"
        TXT_STEAM_MISSING="Steam installation was not found."
        TXT_STEAM_CLOSE="Closing Steam..."
        TXT_DEPS="Checking dependencies..."
        TXT_DEPS_MISSING="Missing dependency:"
        TXT_DEP_INSTALL="Install the required dependencies and try again."
        TXT_DOWNLOAD="Downloading SkyTools.Linux..."
        TXT_DOWNLOAD_OK="SkyTools download completed."
        TXT_ZIP_TEST="Validating ZIP file..."
        TXT_ZIP_OK="ZIP file is valid."
        TXT_PLUGIN_PREP="Preparing Millennium plugin directory..."
        TXT_PLUGIN_CLEAN="Removing old SkyTools files..."
        TXT_PLUGIN_INSTALL="Extracting SkyTools directly into the plugin directory..."
        TXT_PLUGIN_OK="SkyTools installed successfully."
        TXT_MILL="Installing or updating Millennium..."
        TXT_MILL_OK="Millennium installed successfully."
        TXT_CONFIG="Enabling plugin in Millennium..."
        TXT_CONFIG_OK="Plugin enabled."
        TXT_BETA="Removing Steam beta configuration..."
        TXT_TEMP="Cleaning temporary files..."
        TXT_STEAM_START="Starting Steam..."
        TXT_DONE="Installation completed successfully!"
        TXT_RESTART="Steam will start again. The first startup may take a little longer."
        TXT_ERROR="Failed:"
        TXT_LINKS="Links:"
        TXT_DISCORD="Discord:"
        TXT_GITHUB="GitHub:"
        TXT_PLUGIN="Plugin:"
        TXT_LOCATION="Location:"
        TXT_MILL_LOCATION="Millennium:"
        ;;
esac

log() {
    TYPE="$1"
    MESSAGE="$2"
    DATE="$(date '+%H:%M:%S')"

    case "$TYPE" in
        OK)
            COLOR="\033[0;32m"
            ;;
        INFO)
            COLOR="\033[0;36m"
            ;;
        WARN)
            COLOR="\033[0;33m"
            ;;
        ERR)
            COLOR="\033[0;31m"
            ;;
        *)
            COLOR="\033[0m"
            ;;
    esac

    printf "\033[0;36m[%s]\033[0m %s[%s]\033[0m %s\n" \
        "$DATE" "$COLOR" "$TYPE" "$MESSAGE"
}

fail() {
    log "ERR" "$1"
    exit 1
}

countdown() {
    MESSAGE="$1"
    NUMBER=5

    while [ "$NUMBER" -ge 1 ]; do
        log "INFO" "$MESSAGE $NUMBER..."
        sleep 1
        NUMBER=$((NUMBER - 1))
    done
}

cleanup() {
    if [ -n "${TMP_ROOT:-}" ] && [ -d "$TMP_ROOT" ]; then
        rm -rf "$TMP_ROOT"
    fi
}

trap cleanup EXIT INT TERM

clear 2>/dev/null || true

printf "\n"
printf "\033[1;33m============================================================\033[0m\n"
printf "\033[1;33m                    %s                    \033[0m\n" "$TXT_TITLE"
printf "\033[1;33m============================================================\033[0m\n"
printf "\n"

printf "\033[1;37mSkyTools.Linux\033[0m\n"
printf "Discord: \033[0;36m%s\033[0m\n" "$DISCORD_URL"
printf "GitHub:  \033[0;36m%s\033[0m\n" "$GITHUB_URL"
printf "\n"

if [ "$(uname -s)" != "Linux" ]; then
    fail "This installer is exclusive to Linux."
fi

if [ "$(id -u)" -eq 0 ]; then
    fail "Do not run this installer as root."
fi

log "INFO" "$TXT_START"
printf "\n"

log "INFO" "$TXT_DEPS"

REQUIRED_COMMANDS="curl unzip bash sudo pkill pgrep mktemp"

for COMMAND_NAME in $REQUIRED_COMMANDS; do
    if ! command -v "$COMMAND_NAME" >/dev/null 2>&1; then
        log "ERR" "$TXT_DEPS_MISSING $COMMAND_NAME"
        fail "$TXT_DEP_INSTALL"
    fi
done

log "OK" "$TXT_DEPS"
printf "\n"

STEAM_CANDIDATES="
${STEAM_PATH:-}
$HOME/.local/share/Steam
$HOME/.steam/steam
$HOME/.steam/debian-installation
$HOME/.steam/root
"

STEAM=""

log "INFO" "$TXT_STEAM_SEARCH"

for CANDIDATE in $STEAM_CANDIDATES; do
    if [ -n "$CANDIDATE" ] && [ -x "$CANDIDATE/steam.sh" ]; then
        STEAM="$CANDIDATE"
        break
    fi
done

if [ -z "$STEAM" ] && command -v steam >/dev/null 2>&1; then
    for CANDIDATE in \
        "/usr/lib/steam" \
        "/usr/lib/steam/steam" \
        "$HOME/.local/share/Steam" \
        "$HOME/.steam/steam" \
        "$HOME/.steam/debian-installation"
    do
        if [ -x "$CANDIDATE/steam.sh" ]; then
            STEAM="$CANDIDATE"
            break
        fi
    done
fi

if [ -z "$STEAM" ]; then
    fail "$TXT_STEAM_MISSING"
fi

case "$STEAM" in
    "$HOME/.var/app/"*)
        fail "Flatpak Steam is not supported by this automatic installer."
        ;;
esac

log "OK" "$TXT_STEAM_OK $STEAM"
printf "\n"

MILLENNIUM_PLUGIN_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/millennium/plugins"
MILLENNIUM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/millennium"
MILLENNIUM_CONFIG="$MILLENNIUM_CONFIG_DIR/config.json"
MILLENNIUM_ROOT="/usr/lib/millennium"

TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/skytools-installer.XXXXXX")"
PLUGIN_ZIP="$TMP_ROOT/SkyTools.Linux.Plugin.zip"
CONFIG_TMP="$TMP_ROOT/config.json"

printf "\n"

log "INFO" "$TXT_LINKS"
log "INFO" "$TXT_DISCORD $DISCORD_URL"
log "INFO" "$TXT_GITHUB $GITHUB_URL"
printf "\n"

log "INFO" "$TXT_STEAM_CLOSE"

if pgrep -x "steam" >/dev/null 2>&1; then
    if command -v steam >/dev/null 2>&1; then
        steam -shutdown >/dev/null 2>&1 || true
    fi

    sleep 3

    pkill -TERM -x steam >/dev/null 2>&1 || true
    pkill -TERM -x steamwebhelper >/dev/null 2>&1 || true

    sleep 3

    pkill -KILL -x steam >/dev/null 2>&1 || true
    pkill -KILL -x steamwebhelper >/dev/null 2>&1 || true
fi

log "OK" "$TXT_STEAM_CLOSE"
printf "\n"

countdown "Starting SkyTools Installation in"

printf "\n"

log "INFO" "$TXT_DOWNLOAD"

if ! curl \
    -fL \
    --retry 3 \
    --connect-timeout 10 \
    --max-time 180 \
    --progress-bar \
    "$SKYTOOLS_DOWNLOAD_URL" \
    -o "$PLUGIN_ZIP"
then
    fail "$TXT_ERROR $TXT_DOWNLOAD"
fi

log "OK" "$TXT_DOWNLOAD_OK"
printf "\n"

log "INFO" "$TXT_ZIP_TEST"

if ! unzip -tq "$PLUGIN_ZIP" >/dev/null 2>&1; then
    fail "$TXT_ERROR The SkyTools ZIP is invalid or corrupted."
fi

log "OK" "$TXT_ZIP_OK"
printf "\n"

log "INFO" "$TXT_MILL"

if ! curl \
    -fsSL \
    --retry 3 \
    --connect-timeout 10 \
    --max-time 180 \
    "$MILLENNIUM_INSTALLER_URL" |
    bash -s -- --yes
then
    fail "$TXT_ERROR Millennium installation failed."
fi

log "OK" "$TXT_MILL_OK"
printf "\n"

if [ -f "$STEAM/package/beta" ]; then
    log "INFO" "$TXT_BETA"
    rm -f "$STEAM/package/beta" 2>/dev/null || true
    log "OK" "$TXT_BETA"
    printf "\n"
fi

countdown "Starting SkyTools Plugin Installation in"

printf "\n"

log "INFO" "$TXT_PLUGIN_PREP"

mkdir -p "$MILLENNIUM_PLUGIN_DIR" ||
    fail "$TXT_ERROR Could not create plugin directory."

log "OK" "$MILLENNIUM_PLUGIN_DIR"
printf "\n"

log "INFO" "$TXT_PLUGIN_CLEAN"

find "$MILLENNIUM_PLUGIN_DIR" -maxdepth 1 \
    \( -name "*skytools*" -o -name "*SkyTools*" \) \
    -exec rm -rf {} + 2>/dev/null || true

log "OK" "$TXT_PLUGIN_CLEAN"
printf "\n"

log "INFO" "$TXT_PLUGIN_INSTALL"

if ! unzip -qo "$PLUGIN_ZIP" -d "$MILLENNIUM_PLUGIN_DIR"; then
    fail "$TXT_ERROR Failed to extract SkyTools plugin."
fi

log "OK" "$TXT_PLUGIN_OK"
printf "\n"

log "INFO" "$TXT_CONFIG"

mkdir -p "$MILLENNIUM_CONFIG_DIR" ||
    fail "$TXT_ERROR Could not create Millennium config directory."

if [ ! -f "$MILLENNIUM_CONFIG" ]; then
    cat > "$MILLENNIUM_CONFIG" <<EOF
{
  "plugins": {
    "enabledPlugins": [
      "$SKYTOOLS_NAME"
    ]
  }
}
EOF
else
    if command -v jq >/dev/null 2>&1; then
        if ! jq empty "$MILLENNIUM_CONFIG" >/dev/null 2>&1; then
            fail "$TXT_ERROR Existing Millennium config.json is invalid."
        fi

        if ! jq \
            --arg plugin "$SKYTOOLS_NAME" \
            '
            .plugins = (.plugins // {})
            |
            .plugins.enabledPlugins = (
                ((.plugins.enabledPlugins // []) + [$plugin])
                | unique
            )
            ' \
            "$MILLENNIUM_CONFIG" > "$CONFIG_TMP"
        then
            fail "$TXT_ERROR Could not update Millennium config."
        fi

        mv "$CONFIG_TMP" "$MILLENNIUM_CONFIG"
    else
        log "WARN" "jq not found. Keeping existing Millennium configuration."
    fi
fi

log "OK" "$TXT_CONFIG_OK"
printf "\n"

log "INFO" "$TXT_TEMP"

rm -f "$PLUGIN_ZIP"
rm -f "$CONFIG_TMP"

log "OK" "$TXT_TEMP"
printf "\n"

printf "\033[1;33m============================================================\033[0m\n"
log "OK" "$TXT_DONE"
printf "\033[1;33m============================================================\033[0m\n"
printf "\n"

log "INFO" "$TXT_PLUGIN $SKYTOOLS_NAME"
log "INFO" "$TXT_LOCATION $MILLENNIUM_PLUGIN_DIR"
log "INFO" "$TXT_MILL_LOCATION $MILLENNIUM_ROOT"
printf "\n"

log "WARN" "$TXT_RESTART"
printf "\n"

log "INFO" "$TXT_DISCORD $DISCORD_URL"
log "INFO" "$TXT_GITHUB $GITHUB_URL"
printf "\n"

countdown "Starting Steam in"

printf "\n"

log "INFO" "$TXT_STEAM_START"

STEAM_SCRIPT="$STEAM/steam.sh"

if [ ! -x "$STEAM_SCRIPT" ]; then
    fail "$TXT_ERROR Steam launcher not found: $STEAM_SCRIPT"
fi

(
    cd "$STEAM" || exit 1
    nohup ./steam.sh -clearbeta >/dev/null 2>&1 &
)

log "OK" "$TXT_STEAM_START"

printf "\n"
printf "\033[1;33m============================================================\033[0m\n"
printf "\033[1;32m                       SkyTools.Linux                       \033[0m\n"
printf "\033[1;33m============================================================\033[0m\n"
printf "\n"
printf "Discord: \033[0;36m%s\033[0m\n" "$DISCORD_URL"
printf "GitHub:  \033[0;36m%s\033[0m\n" "$GITHUB_URL"
printf "\n"
