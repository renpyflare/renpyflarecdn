#!/bin/sh

URL="https://renpyflare.vercel.app/plugin/SkyTools.Linux.Plugin.zip"
OUTPUT="SkyTools.Linux.Plugin.zip"

LANG_CODE="${LANG:-${LC_ALL:-${LC_MESSAGES:-en}}}"
LANG_CODE=$(printf '%s' "$LANG_CODE" | cut -d_ -f1 | cut -d. -f1)

case "$LANG_CODE" in
    pt)
        TITLE="SkyTools.Linux"
        DISCORD="Discord: https://discord.gg/XusNN6Pxe3"
        GITHUB="GitHub:  https://github.com/renpyflare"
        DOWNLOADING="Baixando"
        SUCCESS="Download concluído com sucesso."
        FILE="Arquivo"
        ERROR="Erro ao baixar o arquivo."
        ;;

    es)
        TITLE="SkyTools.Linux"
        DISCORD="Discord: https://discord.gg/XusNN6Pxe3"
        GITHUB="GitHub:  https://github.com/renpyflare"
        DOWNLOADING="Descargando"
        SUCCESS="Descarga completada correctamente."
        FILE="Archivo"
        ERROR="Error al descargar el archivo."
        ;;

    ru)
        TITLE="SkyTools.Linux"
        DISCORD="Discord: https://discord.gg/XusNN6Pxe3"
        GITHUB="GitHub:  https://github.com/renpyflare"
        DOWNLOADING="Загрузка"
        SUCCESS="Загрузка успешно завершена."
        FILE="Файл"
        ERROR="Ошибка при загрузке файла."
        ;;

    *)
        TITLE="SkyTools.Linux"
        DISCORD="Discord: https://discord.gg/XusNN6Pxe3"
        GITHUB="GitHub:  https://github.com/renpyflare"
        DOWNLOADING="Downloading"
        SUCCESS="Download completed successfully."
        FILE="File"
        ERROR="Error downloading the file."
        ;;
esac

printf '%s\n' "$TITLE"
printf '\n'
printf '%s\n' "$DISCORD"
printf '%s\n' "$GITHUB"
printf '\n'
printf '%s %s...\n' "$DOWNLOADING" "$OUTPUT"
printf '\n'

if curl -fL "$URL" -o "$OUTPUT"; then
    printf '\n%s\n' "$SUCCESS"
    printf '%s: %s\n' "$FILE" "$OUTPUT"
else
    printf '\n%s\n' "$ERROR"
    rm -f "$OUTPUT"
    exit 1
fi

