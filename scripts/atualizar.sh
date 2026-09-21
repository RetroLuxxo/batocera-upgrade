#!/bin/bash

# Exemplo Cauã
:<<"END"
#echo "Peixonauta" >> /userdata/app.py
if [ -f /userdata/app.py ]; then
    rm -f /userdata/app.py
fi
END


#MGames
#MGames
#MGames
#MGames
#MGames
#MGames
# 1
# Verificcação MGames
:<<"END"

touch "/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/MGames"

chmod -R 777 "/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp"

mgames="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/MGames"
new="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/fbneo_alpha.so_new"
old="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/fbneo_alpha.so"
ativo="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/fbneo_alpha.so"
# Adicionando configs
configs_url="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/configs-new/configs"
work="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin"

#if [ -f "$new" ]; then
if [ -f "$mgames" ]; then

    cp -f "$new" "$old"
    rm -f "$ativo"
    mv -f "$new" "$ativo"

    wget -q -O "$work/configs" "$configs_url"
    chmod +x "$work/configs"
fi
END

# 2 Atualizar lista única numerada e configuração do valor do pix no configs

#mgames=/userdata/teste
mgames="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/MGames"
configs_url="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/configs-new/configs"
work="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin"
lista_unica_link="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/lista_unica/lista_unica"
R3ree="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/R3ree/R3ree"
if [ -f "$mgames" ]; then
    wget -q -O "$work/configs" "$configs_url"
    chmod +x "$work/configs"    
    wget -q -O "$work/lista_unica" "$lista_unica_link"
    wget -q -O "$work/R3ree" "$R3ree"
    chmod +x "$work/lista_unica"   
    chmod +x "$work/R3ree"
    #touch /userdata/atualizado
fi


# Sega Model



# Next
# Next
# Next
# Next
# Next
# Next
next="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/Next"
launcher_off_url="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/Next/Launcher_off.sh"
emulatorlauncher_url="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/Next/emulatorlauncher"
work="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin"
if [ -f "$next" ]; then

    
    wget -q -O "$work"/Launcher_off.sh "$launcher_off_url"
    chmod +x "$work"/Launcher_off.sh
    wget -q -O "$work"/emulatorlauncher "$emulatorlauncher_url"
    chmod +x "$work"/emulatorlauncher

fi




# Wecad
# Wecad
# Wecad
# Wecad
# Wecad
# Wecad


:<< "END"
END
mgames="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/MGames"
next="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/Next"
wecad="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/Wecad"

# Se MGames ou Next já existir, não executa novamente
if [ -f "$mgames" ] || [ -f "$next" ]; then
    exit 0
fi

# Marca a instalação como executada
touch "$wecad"

SISTEM_DIR="/userdata/system"
BIN_DIR="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin"
CONFIGGEN_DIR="/usr/lib/python3.11/site-packages/configgen"

# URLs oficiais dos arquivos RAW
Launcher_off="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/Wecad/ports/Launcher_off.sh"
Launcher_on="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/Wecad/ports/Launcher_on.sh"
Emulatorlauncher="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/Wecad/ports/emulatorlauncher.py"
Custom="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/Wecad/ports/custom.sh"


# ============================================================
# CRIA OS DIRETÓRIOS NECESSÁRIOS
# ============================================================

mkdir -p "$SISTEM_DIR"
mkdir -p "$BIN_DIR"
mkdir -p "$CONFIGGEN_DIR"


# ============================================================
# DOWNLOAD DO custom.sh
# ============================================================

wget -q "$Custom" -O "$SISTEM_DIR/custom.sh" || exit 1

chmod +x "$SISTEM_DIR/custom.sh" || exit 1


# ============================================================
# DOWNLOAD DO Launcher_off.sh
# ============================================================

wget -q "$Launcher_off" -O "$BIN_DIR/Launcher_off.sh" || exit 1

chmod +x "$BIN_DIR/Launcher_off.sh" || exit 1


# ============================================================
# DOWNLOAD DO Launcher_on.sh
# ============================================================

wget -q "$Launcher_on" -O "$BIN_DIR/Launcher_on.sh" || exit 1

chmod +x "$BIN_DIR/Launcher_on.sh" || exit 1


# ============================================================
# DOWNLOAD DO emulatorlauncher.py
# ============================================================

wget -q "$Emulatorlauncher" -O "$CONFIGGEN_DIR/emulatorlauncher.py" || exit 1

chmod +x "$CONFIGGEN_DIR/emulatorlauncher.py" || exit 1


# ============================================================
# SALVA O OVERLAY
# ============================================================

batocera-save-overlay 250 &




