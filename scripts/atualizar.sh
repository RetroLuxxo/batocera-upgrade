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
work="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin"
if [ -f "$next" ]; then

    
    wget -q -O "$work"/Launcher_off.sh "$launcher_off_url"
    chmod +x "$work"/Launcher_off.sh

fi




# Wecad
# Wecad
# Wecad
# Wecad
# Wecad
# Wecad
next="/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/.bkp/Wecad"




