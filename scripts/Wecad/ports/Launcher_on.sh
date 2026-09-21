#!/bin/bash
# Curitiba 20 de Setembro de 2026
# Editor: Jeverson Dias da Silva   ///@JCGAMESCLASSICOS...
# Restaura no es_input.cfg os botões removidos pelo Launcher_off.sh
# (start, select, a, x, y, l2, r2, hotkey), que o próprio jogo precisa
# pra montar a configuração de controles do emulador.
# Executado toda vez que um jogo é INICIADO.
#
# Restaura direto do template read-only em .dev/ (nao do es_input.cfg.jcbak,
# que ninguem mais cria nem le - Launcher_off.sh tambem usa este mesmo
# template agora). es_input_livre.bkp ninguem escreve, so le.

ARQ="/userdata/system/configs/emulationstation/es_input.cfg"
BAK="/userdata/system/.dev/es_input_livre.bkp"
LOG="/userdata/system/logs/jc_games_erros.log"

if [ -f "$BAK" ]; then
    cp "$BAK" "$ARQ"
    echo "Restauração concluída em $ARQ"
else
    # emulatorlauncher.py chama este script com stdout/stderr em DEVNULL,
    # entao um simples echo nunca seria visto. Grava em log de verdade.
    mkdir -p "$(dirname "$LOG")"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Launcher_on.sh: ERRO CRÍTICO — $BAK não encontrado, controles do jogo NÃO foram restaurados!" >> "$LOG"
fi
