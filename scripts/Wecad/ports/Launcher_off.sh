#!/bin/bash
# Curitiba 05 de Janeiro de 2025
# Editor: Jeverson Dias da Silva   ///@JCGAMESCLASSICOS...
# Overlay Principal



# Script para limpar inputs desnecessários dos joysticks no es_input.cfg
# Remove APENAS start e select (bloqueia o acesso ao menu do frontend)
# Mantém up, down, left, right, a, x, y, l2, r2 e hotkey funcionando
# NÃO altera o bloco do teclado

ARQ="/userdata/system/configs/emulationstation/es_input.cfg"
BAK="/userdata/system/.dev/es_input_livre.bkp"
LOG="/userdata/system/logs/jc_games_erros.log"

# Fonte fixa e somente-leitura (ninguém escreve nela). Antes usava um
# es_input.cfg.jcbak que só era criado "se ainda não existisse" — se essa
# primeira criação pegasse um es_input.cfg já cortado, o corte ficava
# permanente. es_input_livre.bkp nunca é escrito por nenhum script.
if [ ! -f "$BAK" ]; then
    mkdir -p "$(dirname "$LOG")"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Launcher_off.sh: ERRO CRÍTICO — $BAK não encontrado, es_input.cfg NÃO foi alterado!" >> "$LOG"
    echo "ERRO: $BAK não encontrado, abortando limpeza."
    exit 1
fi

# Remove linhas indesejadas apenas dentro dos blocos joystick
# Sempre parte do template completo, pra não acumular cortes em cima de cortes
awk '
/<inputConfig type="joystick"/ { injoy=1 }
injoy && /<\/inputConfig>/ { injoy=0 }
injoy && $0 ~ /name="(start|select)"/ { next } #|pagedown|pageup|left|right|joystick2left|joystick1left
{ print }
' "$BAK" > "$ARQ.tmp" && mv "$ARQ.tmp" "$ARQ"

echo "Limpeza concluída em $ARQ"
