#!/bin/sh

if [ "$(uname)" != "Linux" ]; then
    printf "\033[0;31m[ERROR] Este script é exclusivo para sistemas Linux.\033[0m\n"
    exit 1
fi

SYSTEM_LANG=$(echo "${LANG:-en}" | cut -c1-2)

case "$SYSTEM_LANG" in
    pt)
        TXT_USAGE="Uso: curl -fsSL <script> | sh -s -- <URL_DO_ZIP>"
        TXT_NO_URL="Você precisa fornecer a URL do arquivo .zip do plugin."
        TXT_START="Iniciando Instalador Automatizado Millennium..."
        TXT_MILL_MISSING="Millennium não encontrado. Baixando instalador oficial..."
        TXT_MILL_OK="Millennium já está instalado."
        TXT_PREP="Preparando diretórios do plugin..."
        TXT_DOWN="Baixando plugin de:"
        TXT_ERR_DOWN="Erro ao baixar o arquivo .zip."
        TXT_EXTRACT="Extraindo arquivos em:"
        TXT_ERR_UNZIP="Erro ao descompactar. Verifique se o pacote 'unzip' está instalado."
        TXT_SUCCESS="Instalação concluída com sucesso!"
        TXT_RESTART="Reinicie a Steam para aplicar as alterações."
        ;;
    es)
        TXT_USAGE="Uso: curl -fsSL <script> | sh -s -- <URL_DEL_ZIP>"
        TXT_NO_URL="Debe proporcionar la URL del archivo .zip del complemento."
        TXT_START="Iniciando el Instalador Automatizado de Millennium..."
        TXT_MILL_MISSING="Millennium no encontrado. Descargando el instalador oficial..."
        TXT_MILL_OK="Millennium ya está instalado."
        TXT_PREP="Preparando directorios del complemento..."
        TXT_DOWN="Descargando complemento desde:"
        TXT_ERR_DOWN="Error al descargar el archivo .zip."
        TXT_EXTRACT="Extrayendo archivos en:"
        TXT_ERR_UNZIP="Error al descomprimir. Verifique que el paquete 'unzip' esté instalado."
        TXT_SUCCESS="¡Instalación completada con éxito!"
        TXT_RESTART="Reinicie Steam para aplicar los cambios."
        ;;
    ru)
        TXT_USAGE="Использование: curl -fsSL <скрипт> | sh -s -- <URL_ZIP_АРХИВА>"
        TXT_NO_URL="Вам необходимо указать URL-адрес .zip файла плагина."
        TXT_START="Запуск автоматического установщика Millennium..."
        TXT_MILL_MISSING="Millennium не найден. Скачивание официального установщика..."
        TXT_MILL_OK="Millennium уже установлен."
        TXT_PREP="Подготовка директорий плагина..."
        TXT_DOWN="Скачивание плагина из:"
        TXT_ERR_DOWN="Ошибка при скачивании .zip файла."
        TXT_EXTRACT="Распаковка файлов в:"
        TXT_ERR_UNZIP="Ошибка при распаковке. Убедитесь, что утилита 'unzip' установлена."
        TXT_SUCCESS="Установка успешно завершена!"
        TXT_RESTART="Перезапустите Steam, чтобы применить изменения."
        ;;
    *)
        TXT_USAGE="Usage: curl -fsSL <script> | sh -s -- <ZIP_URL>"
        TXT_NO_URL="You must provide the URL of the plugin's .zip file."
        TXT_START="Starting Millennium Automated Installer..."
        TXT_MILL_MISSING="Millennium not found. Downloading official installer..."
        TXT_MILL_OK="Millennium is already installed."
        TXT_PREP="Preparing plugin directories..."
        TXT_DOWN="Downloading plugin from:"
        TXT_ERR_DOWN="Failed to download the .zip file."
        TXT_EXTRACT="Extracting files into:"
        TXT_ERR_UNZIP="Failed to extract. Make sure the 'unzip' package is installed."
        TXT_SUCCESS="Installation completed successfully!"
        TXT_RESTART="Restart Steam to apply changes."
        ;;
esac

log_ok()    { printf "\033[0;32m[OK]\033[0m %s\n" "$1"; }
log_info()  { printf "\033[0;34m[INFO]\033[0m %s\n" "$1"; }
log_warn()  { printf "\033[0;33m[WARN]\033[0m %s\n" "$1"; }
log_error() { printf "\033[0;31m[ERROR]\033[0m %s\n" "$1"; }

if [ -z "$1" ]; then
    log_error "$TXT_NO_URL"
    log_info "$TXT_USAGE"
    exit 1
fi

PLUGIN_ZIP_URL="$1"
PLUGIN_NAME=$(basename "$PLUGIN_ZIP_URL" .zip)

MILLENNIUM_DIR="$HOME/.millennium"
PLUGINS_DIR="$MILLENNIUM_DIR/plugins"
TARGET_PLUGIN_DIR="$PLUGINS_DIR/$PLUGIN_NAME"
TEMP_ZIP="/tmp/millennium_plugin_$$.zip"

log_info "$TXT_START"

if [ ! -d "$MILLENNIUM_DIR" ]; then
    log_warn "$TXT_MILL_MISSING"
    curl -fsSL "https://steambrew.app" | sh
else
    log_ok "$TXT_MILL_OK"
fi

log_info "$TXT_PREP"
mkdir -p "$TARGET_PLUGIN_DIR"

log_info "$TXT_DOWN $PLUGIN_ZIP_URL"
curl -L "$PLUGIN_ZIP_URL" -o "$TEMP_ZIP"

if [ $? -ne 0 ]; then
    log_error "$TXT_ERR_DOWN"
    rm -rf "$TARGET_PLUGIN_DIR"
    exit 1
fi

log_info "$TXT_EXTRACT $TARGET_PLUGIN_DIR"
unzip -qo "$TEMP_ZIP" -d "$TARGET_PLUGIN_DIR"

if [ $? -ne 0 ]; then
    log_error "$TXT_ERR_UNZIP"
    rm -f "$TEMP_ZIP"
    rm -rf "$TARGET_PLUGIN_DIR"
    exit 1
fi

rm -f "$TEMP_ZIP"

echo "------------------------------------------"
log_ok "$TXT_SUCCESS ($PLUGIN_NAME)"
log_info "$TXT_RESTART"
echo "------------------------------------------"
