#!/bin/sh

if [ "$(uname -s)" != "Linux" ]; then
    printf "\033[0;31m[ERROR]\033[0m This installer is exclusive to Linux.\n"
    exit 1
fi

if [ "$(uname -m)" != "x86_64" ]; then
    printf "\033[0;31m[ERROR]\033[0m SkyTools.Linux currently requires Linux x86_64.\n"
    exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
    printf "\033[0;31m[ERROR]\033[0m Do not run this installer as root.\n"
    exit 1
fi

SYSTEM_LANG=$(printf '%s' "${LANG:-en}" | cut -c1-2)

case "$SYSTEM_LANG" in
    pt)
        TXT_START="Iniciando instalador do SkyTools.Linux..."
        TXT_STEAM_SEARCH="Procurando instalação do Steam..."
        TXT_STEAM_OK="Steam encontrado em:"
        TXT_STEAM_MISSING="Instalação do Steam não encontrada."
        TXT_STEAM_CLOSE="Fechando o Steam..."
        TXT_DEPS="Verificando dependências..."
        TXT_DEPS_MISSING="Dependência ausente:"
        TXT_SKYTOOLS="Iniciando instalação do SkyTools..."
        TXT_SKYTOOLS_DOWNLOAD="Baixando componentes principais do SkyTools..."
        TXT_SKYTOOLS_OK="SkyTools instalado com sucesso."
        TXT_CLEAN="Limpando arquivos antigos do SkyTools..."
        TXT_MILL="Iniciando instalação do Millennium..."
        TXT_MILL_OK="Millennium instalado com sucesso."
        TXT_RELEASE="Procurando a versão mais recente do plugin SkyTools..."
        TXT_RELEASE_OK="Release encontrada:"
        TXT_PLUGIN="Instalando plugin SkyTools..."
        TXT_PLUGIN_OK="Plugin SkyTools instalado com sucesso."
        TXT_CONFIG="Habilitando plugin..."
        TXT_CONFIG_OK="Plugin habilitado."
        TXT_CLEAN_TEMP="Limpando arquivos temporários..."
        TXT_DONE="Instalação concluída com sucesso!"
        TXT_RESTART="O Steam será iniciado novamente. A primeira inicialização pode demorar um pouco."
        TXT_ERROR="Falha:"
        TXT_STEAM_START="Iniciando Steam..."
        TXT_FLATPAK="Steam Flatpak foi detectado. Esta instalação automática requer uma instalação nativa do Steam."
        ;;
    es)
        TXT_START="Iniciando el instalador de SkyTools.Linux..."
        TXT_STEAM_SEARCH="Buscando la instalación de Steam..."
        TXT_STEAM_OK="Steam encontrado en:"
        TXT_STEAM_MISSING="Instalación de Steam no encontrada."
        TXT_STEAM_CLOSE="Cerrando Steam..."
        TXT_DEPS="Comprobando dependencias..."
        TXT_DEPS_MISSING="Falta la dependencia:"
        TXT_SKYTOOLS="Iniciando la instalación de SkyTools..."
        TXT_SKYTOOLS_DOWNLOAD="Descargando componentes principales de SkyTools..."
        TXT_SKYTOOLS_OK="SkyTools instalado correctamente."
        TXT_CLEAN="Limpiando archivos antiguos de SkyTools..."
        TXT_MILL="Iniciando la instalación de Millennium..."
        TXT_MILL_OK="Millennium instalado correctamente."
        TXT_RELEASE="Buscando la versión más reciente del plugin SkyTools..."
        TXT_RELEASE_OK="Release encontrada:"
        TXT_PLUGIN="Instalando el plugin SkyTools..."
        TXT_PLUGIN_OK="Plugin SkyTools instalado correctamente."
        TXT_CONFIG="Habilitando el plugin..."
        TXT_CONFIG_OK="Plugin habilitado."
        TXT_CLEAN_TEMP="Limpiando archivos temporales..."
        TXT_DONE="¡Instalación completada correctamente!"
        TXT_RESTART="Steam se iniciará de nuevo. El primer inicio puede tardar un poco."
        TXT_ERROR="Error:"
        TXT_STEAM_START="Iniciando Steam..."
        TXT_FLATPAK="Se detectó Steam Flatpak. Esta instalación automática requiere una instalación nativa de Steam."
        ;;
    ru)
        TXT_START="Запуск установщика SkyTools.Linux..."
        TXT_STEAM_SEARCH="Поиск установки Steam..."
        TXT_STEAM_OK="Steam найден:"
        TXT_STEAM_MISSING="Установка Steam не найдена."
        TXT_STEAM_CLOSE="Закрытие Steam..."
        TXT_DEPS="Проверка зависимостей..."
        TXT_DEPS_MISSING="Отсутствует зависимость:"
        TXT_SKYTOOLS="Запуск установки SkyTools..."
        TXT_SKYTOOLS_DOWNLOAD="Загрузка основных компонентов SkyTools..."
        TXT_SKYTOOLS_OK="SkyTools успешно установлен."
        TXT_CLEAN="Очистка старых файлов SkyTools..."
        TXT_MILL="Запуск установки Millennium..."
        TXT_MILL_OK="Millennium успешно установлен."
        TXT_RELEASE="Поиск последней версии плагина SkyTools..."
        TXT_RELEASE_OK="Найдена версия:"
        TXT_PLUGIN="Установка плагина SkyTools..."
        TXT_PLUGIN_OK="Плагин SkyTools успешно установлен."
        TXT_CONFIG="Включение плагина..."
        TXT_CONFIG_OK="Плагин включён."
        TXT_CLEAN_TEMP="Очистка временных файлов..."
        TXT_DONE="Установка успешно завершена!"
        TXT_RESTART="Steam будет запущен снова. Первый запуск может занять немного больше времени."
        TXT_ERROR="Ошибка:"
        TXT_STEAM_START="Запуск Steam..."
        TXT_FLATPAK="Обнаружен Steam Flatpak. Для автоматической установки требуется нативная версия Steam."
        ;;
    *)
        TXT_START="Starting SkyTools.Linux installer..."
        TXT_STEAM_SEARCH="Searching for Steam installation..."
        TXT_STEAM_OK="Steam found at:"
        TXT_STEAM_MISSING="Steam installation was not found."
        TXT_STEAM_CLOSE="Closing Steam..."
        TXT_DEPS="Checking dependencies..."
        TXT_DEPS_MISSING="Missing dependency:"
        TXT_SKYTOOLS="Starting SkyTools installation..."
        TXT_SKYTOOLS_DOWNLOAD="Downloading SkyTools core components..."
        TXT_SKYTOOLS_OK="SkyTools installed successfully."
        TXT_CLEAN="Cleaning old SkyTools files..."
        TXT_MILL="Starting Millennium installation..."
        TXT_MILL_OK="Millennium installed successfully."
        TXT_RELEASE="Finding the latest SkyTools plugin release..."
        TXT_RELEASE_OK="Release found:"
        TXT_PLUGIN="Installing SkyTools plugin..."
        TXT_PLUGIN_OK="SkyTools plugin installed successfully."
        TXT_CONFIG="Enabling plugin..."
        TXT_CONFIG_OK="Plugin enabled."
        TXT_CLEAN_TEMP="Cleaning temporary files..."
        TXT_DONE="Installation completed successfully!"
        TXT_RESTART="Steam will start again. The first startup may take a little longer."
        TXT_ERROR="Failed:"
        TXT_STEAM_START="Starting Steam..."
        TXT_FLATPAK="Steam Flatpak was detected. This automatic installer requires a native Steam installation."
        ;;
esac

log_ok() {
    printf "\033[0;32m[OK]\033[0m %s\n" "$1"
}

log_info() {
    printf "\033[0;36m[INFO]\033[0m %s\n" "$1"
}

log_warn() {
    printf "\033[0;33m[WARN]\033[0m %s\n" "$1"
}

log_error() {
    printf "\033[0;31m[ERROR]\033[0m %s\n" "$1"
}

COUNTDOWN() {
    MESSAGE="$1"

    i=5
    while [ "$i" -ge 1 ]; do
        printf "\033[0;36m[INFO]\033[0m %s %s...\n" "$MESSAGE" "$i"
        sleep 1
        i=$((i - 1))
    done
}

fail() {
    log_error "$1"
    exit 1
}

log_info "$TXT_START"
echo ""

log_info "$TXT_DEPS"

for command_name in curl jq unzip tar sha256sum bash sudo mktemp; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        log_error "$TXT_DEPS_MISSING $command_name"
        exit 1
    fi
done

log_ok "$TXT_DEPS"
echo ""

STEAM_CANDIDATES="
$HOME/.local/share/Steam
$HOME/.steam/steam
$HOME/.steam/debian-installation
$HOME/.steam/root
$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam
$HOME/.var/app/com.valvesoftware.Steam/data/Steam
"

STEAM=""

log_info "$TXT_STEAM_SEARCH"

for candidate in $STEAM_CANDIDATES; do
    if [ -d "$candidate" ] && [ -e "$candidate/steam.sh" ]; then
        STEAM="$candidate"
        break
    fi
done

if [ -z "$STEAM" ]; then
    fail "$TXT_STEAM_MISSING"
fi

case "$STEAM" in
    *".var/app/com.valvesoftware.Steam"*)
        fail "$TXT_FLATPAK"
        ;;
esac

log_ok "$TXT_STEAM_OK $STEAM"
echo ""

TMP_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/skytools-installer.XXXXXX")

cleanup() {
    rm -rf "$TMP_ROOT"
}

trap cleanup EXIT INT TERM

SKYTOOLS_ZIP="$TMP_ROOT/skytools.zip"
PLUGIN_ZIP="$TMP_ROOT/skytools-plugin.zip"

MILLENNIUM_PLUGINS="$HOME/.local/share/millennium/plugins"
MILLENNIUM_CONFIG_DIR="$HOME/.config/millennium"
MILLENNIUM_CONFIG="$MILLENNIUM_CONFIG_DIR/config.json"

LEGACY_PLUGINS="$HOME/.millennium/plugins"

SKYTOOLS_NAME="skytools-plugin"
SKYTOOLS_FOLDER="SkyTools.Plugin"

SKYTOOLS_CORE_URL="https://github.com/skyflarefox/files/raw/refs/heads/main/skytools.zip"
SKYTOOLS_REPOSITORY="skyflarefox/skytoolsPlugin"

echo ""
COUNTDOWN "Starting SkyTools Installation in"

log_info "$TXT_STEAM_CLOSE"

pkill -TERM -x steam >/dev/null 2>&1 || true
pkill -TERM -x steamwebhelper >/dev/null 2>&1 || true

sleep 3

pkill -KILL -x steam >/dev/null 2>&1 || true
pkill -KILL -x steamwebhelper >/dev/null 2>&1 || true

log_ok "$TXT_STEAM_CLOSE"
echo ""

log_info "$TXT_CLEAN"

if [ -e "$STEAM/opensteamtool" ]; then
    rm -rf "$STEAM/opensteamtool"
    log_ok "Removed: opensteamtool"
fi

if [ -e "$STEAM/dwmapi.dll" ]; then
    rm -f "$STEAM/dwmapi.dll"
    log_ok "Removed: dwmapi.dll"
fi

if [ -e "$STEAM/xinput1_4.dll" ]; then
    rm -f "$STEAM/xinput1_4.dll"
    log_ok "Removed: xinput1_4.dll"
fi

if [ -d "$MILLENNIUM_PLUGINS/$SKYTOOLS_FOLDER" ]; then
    rm -rf "$MILLENNIUM_PLUGINS/$SKYTOOLS_FOLDER"
    log_ok "Removed old SkyTools plugin"
fi

if [ -d "$LEGACY_PLUGINS/$SKYTOOLS_FOLDER" ]; then
    rm -rf "$LEGACY_PLUGINS/$SKYTOOLS_FOLDER"
    log_ok "Removed legacy SkyTools plugin"
fi

if [ -d "$LEGACY_PLUGINS/$SKYTOOLS_NAME" ]; then
    rm -rf "$LEGACY_PLUGINS/$SKYTOOLS_NAME"
    log_ok "Removed legacy SkyTools plugin directory"
fi

echo ""

log_info "$TXT_SKYTOOLS_DOWNLOAD"

if ! curl -fL --progress-bar "$SKYTOOLS_CORE_URL" -o "$SKYTOOLS_ZIP"; then
    fail "$TXT_ERROR $TXT_SKYTOOLS_DOWNLOAD"
fi

log_ok "SkyTools core download completed"

if ! unzip -qo "$SKYTOOLS_ZIP" -d "$STEAM"; then
    fail "$TXT_ERROR Could not extract SkyTools core files."
fi

log_ok "$TXT_SKYTOOLS_OK"
echo ""

COUNTDOWN "Starting Millennium Installation in"

log_info "$TXT_MILL"

if ! curl -fsSL "https://steambrew.app/install.sh" | bash -s -- --yes; then
    fail "$TXT_ERROR Millennium installation failed."
fi

log_ok "$TXT_MILL_OK"
echo ""

COUNTDOWN "Starting SkyTools Plugin Installation in"

log_info "$TXT_RELEASE"

RELEASE_JSON=$(curl -fsSL \
    -H "Accept: application/vnd.github+json" \
    -H "User-Agent: SkyTools.Linux-Installer" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$SKYTOOLS_REPOSITORY/releases/latest") || fail "$TXT_ERROR Could not query GitHub."

PLUGIN_VERSION=$(printf '%s' "$RELEASE_JSON" | jq -r '.tag_name // empty')

if [ -z "$PLUGIN_VERSION" ]; then
    fail "$TXT_ERROR Could not determine the latest SkyTools release."
fi

PLUGIN_URL=$(
    printf '%s' "$RELEASE_JSON" |
        jq -r '
            [
                .assets[]
                | select(.browser_download_url != null)
                | select(.name | test("(?i)^skytools(?:[._-].*)?\\.zip$"))
                | .browser_download_url
            ][0] // empty
        '
)

if [ -z "$PLUGIN_URL" ]; then
    PLUGIN_URL=$(
        printf '%s' "$RELEASE_JSON" |
            jq -r '
                [
                    .assets[]
                    | select(.browser_download_url != null)
                    | select(.name | test("(?i)\\.zip$"))
                    | .browser_download_url
                ][0] // empty
            '
    )
fi

PLUGIN_ASSET=$(
    printf '%s' "$RELEASE_JSON" |
        jq -r '
            [
                .assets[]
                | select(.browser_download_url != null)
                | select(.name | test("(?i)^skytools(?:[._-].*)?\\.zip$"))
                | .name
            ][0] // empty
        '
)

if [ -z "$PLUGIN_ASSET" ]; then
    PLUGIN_ASSET=$(
        printf '%s' "$RELEASE_JSON" |
            jq -r '
                [
                    .assets[]
                    | select(.browser_download_url != null)
                    | select(.name | test("(?i)\\.zip$"))
                    | .name
                ][0] // empty
            '
    )
fi

if [ -z "$PLUGIN_URL" ] || [ "$PLUGIN_URL" = "null" ]; then
    fail "$TXT_ERROR The latest SkyTools release does not contain a ZIP asset."
fi

log_ok "$TXT_RELEASE_OK $PLUGIN_VERSION ($PLUGIN_ASSET)"

echo ""

log_info "$TXT_PLUGIN"

mkdir -p "$MILLENNIUM_PLUGINS"

if ! curl -fL --progress-bar "$PLUGIN_URL" -o "$PLUGIN_ZIP"; then
    fail "$TXT_ERROR Could not download SkyTools plugin."
fi

if ! unzip -qo "$PLUGIN_ZIP" -d "$MILLENNIUM_PLUGINS"; then
    fail "$TXT_ERROR Could not extract SkyTools plugin."
fi

if [ ! -d "$MILLENNIUM_PLUGINS/$SKYTOOLS_FOLDER" ]; then
    fail "$TXT_ERROR Plugin directory '$SKYTOOLS_FOLDER' was not created."
fi

log_ok "$TXT_PLUGIN_OK"
echo ""

log_info "$TXT_CONFIG"

mkdir -p "$MILLENNIUM_CONFIG_DIR"
mkdir -p "$MILLENNIUM_PLUGINS"

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
    CONFIG_TMP="$TMP_ROOT/config.json"

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
        "$MILLENNIUM_CONFIG" > "$CONFIG_TMP"; then
        fail "$TXT_ERROR Could not update Millennium configuration."
    fi

    mv "$CONFIG_TMP" "$MILLENNIUM_CONFIG"
fi

log_ok "$TXT_CONFIG_OK"
echo ""

log_info "$TXT_CLEAN_TEMP"

rm -f "$SKYTOOLS_ZIP"
rm -f "$PLUGIN_ZIP"

log_ok "$TXT_CLEAN_TEMP"
echo ""

log_ok "$TXT_DONE"
log_warn "$TXT_RESTART"
echo ""

COUNTDOWN "Starting Steam in"

STEAM_SCRIPT="$STEAM/steam.sh"

if [ ! -x "$STEAM_SCRIPT" ]; then
    fail "Steam launcher not found at $STEAM_SCRIPT"
fi

log_info "$TXT_STEAM_START"

(
    cd "$STEAM" || exit 1
    nohup ./steam.sh -clearbeta >/dev/null 2>&1 &
)

log_ok "$TXT_STEAM_START"

echo ""
echo "------------------------------------------"
log_ok "SkyTools.Linux"
log_info "Plugin: $SKYTOOLS_NAME"
log_info "Version: $PLUGIN_VERSION"
log_info "Steam: $STEAM"
log_info "Millennium plugins: $MILLENNIUM_PLUGINS"
echo "------------------------------------------"
