#!/bin/bash

# Exemplo Cauã
:<<"END"
#echo "Peixonauta" >> /userdata/app.py
if [ -f /userdata/app.py ]; then
    rm -f /userdata/app.py
fi
END

# 1
# Verificcação MGames

touch "/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/MGames"

chmod -R 777 "/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp"

mgames="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/MGames"
new="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/fbneo_alpha.so_new"
old="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/fbneo_alpha.so"
ativo="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/fbneo_alpha.so"
# Adicionando configs
configs_url="https://raw.githubusercontent.com/RetroLuxxo/batocera-upgrade/refs/heads/main/scripts/configs-new/configs"
work="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin"

if [ -f "$new" ]; then
    cp -f "$new" "$old"
    rm -f "$ativo"
    mv -f "$new" "$ativo"

    wget -q -O "$work/configs" "$configs_url"
    chmod +x "$work/configs"
fi

