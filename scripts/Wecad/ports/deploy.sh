#!/bin/bash
# JC GAMES — copia os arquivos deste diretório para o lugar certo no
# Batocera e persiste o emulatorlauncher.py no overlay do sistema.
#
# Rode este script já dentro do Batocera de destino (SSH ou terminal local),
# a partir do mesmo diretório onde estão custom.sh, Launcher_on.sh,
# Launcher_off.sh e emulatorlauncher.py.

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

BIN_DIR="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin"
CONFIGGEN_DIR="/usr/lib/python3.11/site-packages/configgen"

echo "=== Diretório de origem: $DIR ==="

copiar() {
    src="$1"
    dst="$2"
    if [ ! -f "$DIR/$src" ]; then
        echo "AVISO: $src não encontrado em $DIR, pulando."
        return 1
    fi
    mkdir -p "$(dirname "$dst")"
    cp -f "$DIR/$src" "$dst"
    echo "OK: $src -> $dst"
}

echo
echo "--- custom.sh ---"
copiar "custom.sh" "/userdata/system/custom.sh"
chmod 777 "/userdata/system/custom.sh" 2>/dev/null || true

echo
echo "--- Launcher_on.sh ---"
copiar "Launcher_on.sh" "$BIN_DIR/Launcher_on.sh"
chmod 777 "$BIN_DIR/Launcher_on.sh" 2>/dev/null || true

echo
echo "--- Launcher_off.sh ---"
copiar "Launcher_off.sh" "$BIN_DIR/Launcher_off.sh"
chmod 777 "$BIN_DIR/Launcher_off.sh" 2>/dev/null || true

echo
echo "--- emulatorlauncher.py (parte do sistema, precisa persistir no overlay) ---"
if copiar "emulatorlauncher.py" "$CONFIGGEN_DIR/emulatorlauncher.py"; then
    echo "Rodando batocera-save-overlay para persistir a mudança..."
    batocera-save-overlay
fi

echo
echo "=== Validando sintaxe dos scripts shell copiados ==="
for f in "/userdata/system/custom.sh" "$BIN_DIR/Launcher_on.sh" "$BIN_DIR/Launcher_off.sh"; do
    if [ -f "$f" ]; then
        bash -n "$f" && echo "OK: $f" || echo "ERRO DE SINTAXE: $f"
    fi
done

echo
echo "=== Concluído ==="
