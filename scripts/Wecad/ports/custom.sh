#!/bin/bash
# Curitiba 11 de Junho de 2026.
# Editor: Jeverson D Silva   ///@JCGAMESCLASSICOS...
# fliperama-comercial

# O Batocera chama este script com "start" no boot e "stop" no desligamento.
# Só executamos no boot.
if [ "$1" = "stop" ]; then
    exit 0
fi

pkill unclutter

# JC GAMES — variáveis usadas mais abaixo (estavam faltando, causavam
# cp/awk/sed em arquivo vazio e falha silenciosa da configuração de input).
# Caminhos confirmados por SSH no cabinet (192.168.18.4) em 20/09/2026.
ES_INPUT="/userdata/system/configs/emulationstation/es_input.cfg"
BATOCERA_CONF="/userdata/system/batocera.conf"
ES_INPUT_TEMPLATE="/userdata/system/.dev/es_input_livre.bkp"
JC_PROCESSOS="/userdata/system/.dev/scripts/jc_processos.sh"
LAUNCHER_OFF="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/Launcher_off.sh"
LOG="/userdata/system/logs/jc_games_erros.log"

jc_alerta_template_ausente() {
    mkdir -p "$(dirname "$LOG")"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] custom.sh: ERRO CRÍTICO — $ES_INPUT_TEMPLATE não encontrado, es_input.cfg NÃO foi restaurado!" >> "$LOG"
}

# Verifica se a linha MODO_COMERCIAL_DESATIVADO = 1 (com ou sem espaços) existe no conf
if grep -q "^MODO_COMERCIAL_DESATIVADO *= *1" /userdata/system/batocera.conf; then
    echo "Modo Livre detectado (1). Restaurando controles..."
    # Antes apontava para es_input.cfg.bkp, que nunca existiu nesse diretório —
    # o backup íntegro (262 controles completos) é o es_input_livre.bkp em .dev/
    if [ -f "$ES_INPUT_TEMPLATE" ]; then
        cp -f "$ES_INPUT_TEMPLATE" "$ES_INPUT"
    else
        echo "ERRO: Template $ES_INPUT_TEMPLATE não encontrado!"
        jc_alerta_template_ausente
    fi

    # Mesmo em modo livre, o boot deixa o es_input.cfg no mesmo estado
    # "em repouso" de entre-jogos (start/select bloqueados no menu da ES),
    # reaproveitando o Launcher_off.sh em vez de duplicar a lógica aqui.
    if [ -x "$LAUNCHER_OFF" ]; then
        "$LAUNCHER_OFF"
    else
        echo "AVISO: $LAUNCHER_OFF não encontrado ou sem permissão de execução, pulando bloqueio do menu."
    fi

    # Desativa (comenta) as configurações do modo comercial no batocera.conf
    sed -i 's/^\(global\.retroarch\.menu_driver=rgui\)/##\1/;
s/^\(global\.retroarch\.crt_switch_resolution = "4"\)/##\1/;
s/^\(global notifications can be avoid with replacing "true" by "false"\)/##\1/;
s/^\(global\.retroarch\.notification_show_autoconfig = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_cheats_applied = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_config_override_load = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_fast_forward = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_netplay_extra = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_patch_applied = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_remap_load = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_screenshot = "true"\)/##\1/;
s/^\(global\.retroarch\.notification_show_set_initial_disk = "true"\)/##\1/;
s/^\(mame\.rotation=none\)/##\1/;
s/^\(fbneo\.video_allow_rotate=off\)/##\1/;' "$BATOCERA_CONF"
    echo "Configurações do modo comercial comentadas no batocera.conf"

# ===========================================================================
# MODO COMERCIAL  (qualquer valor != 1, inclusive vazio/ausente -> padrão)
# ===========================================================================
else
    echo "Modo comercial ativo. Restaurando configuração padrão de input..."

    if [ -f "$ES_INPUT_TEMPLATE" ]; then
        cp -f "$ES_INPUT_TEMPLATE" "$ES_INPUT"
        echo "es_input.cfg restaurado a partir do template."
    else
        echo "ERRO: Template $ES_INPUT_TEMPLATE não encontrado!"
        jc_alerta_template_ausente
    fi

    # Limpa inputs desnecessários dos joysticks no es_input.cfg.
    # NÃO altera o bloco do teclado.
    awk '
    /<inputConfig type="joystick"/ { injoy=1 }
    injoy && /<\/inputConfig>/ { injoy=0 }
    injoy && $0 ~ /name="(start|select|a|x|y|l2|r2|hotkey)"/ { next } #|pagedown|pageup|left|right|joystick2left|joystick1left
    { print }
    ' "$ES_INPUT" > "$ES_INPUT.tmp" && mv "$ES_INPUT.tmp" "$ES_INPUT"
    echo "Limpeza de inputs concluída em $ES_INPUT"

    # Inicia os daemons do modo comercial (one, 3ree, fbneo), se não estiverem rodando.
    # Chamado UMA vez só (duplicata removida).
    "$JC_PROCESSOS" iniciar

    # Reativa (descomenta) as configurações do modo comercial no batocera.conf
    sed -i 's/^##\(global\.retroarch\.menu_driver=rgui\)/\1/;
s/^##\(global\.retroarch\.crt_switch_resolution = "4"\)/\1/;
s/^##\(global notifications can be avoid with replacing "true" by "false"\)/\1/;
s/^##\(global\.retroarch\.notification_show_autoconfig = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_cheats_applied = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_config_override_load = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_fast_forward = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_netplay_extra = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_patch_applied = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_remap_load = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_screenshot = "true"\)/\1/;
s/^##\(global\.retroarch\.notification_show_set_initial_disk = "true"\)/\1/;
s/^##\(mame\.rotation=none\)/\1/;
s/^##\(fbneo\.video_allow_rotate=off\)/\1/;' "$BATOCERA_CONF"
    echo "Configurações do modo comercial reativadas no batocera.conf"
fi

# ===========================================================================
# Guarda-chuva: backup/restore do batocera.conf por contagem de linhas
# ===========================================================================
ARQUIVO="/userdata/system/batocera.conf"
BKP="/userdata/system/.dev/batocera.conf.bkp"

LINHAS=$(wc -l < "$ARQUIVO")

if [ "$LINHAS" -gt 10 ]; then
    echo "Arquivo tem mais de 10 linhas ($LINHAS). Criando backup..."
    cp "$ARQUIVO" "$BKP"
elif [ "$LINHAS" -lt 10 ]; then
    echo "Arquivo tem menos de 10 linhas ($LINHAS). Restaurando backup..."
    if [ -f "$BKP" ]; then
        cp "$BKP" "$ARQUIVO"
    else
        echo "Backup não encontrado!"
    fi
else
    echo "Arquivo tem exatamente 10 linhas. Nenhuma ação."
fi
