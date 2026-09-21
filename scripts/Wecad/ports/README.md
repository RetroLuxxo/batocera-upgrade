# Porte para o pen-drive base

Correções feitas em 20/09/2026 no cabinet 192.168.18.4, prontas para levar
para o pen-drive base.

## Uso rápido: `deploy.sh`

Rode como root, dentro do Batocera de destino, a partir desta mesma pasta
(ele copia os arquivos ao lado dele — não precisa estar em `/userdata`):

```sh
./deploy.sh
```

Copia `custom.sh`, `Launcher_on.sh` e `Launcher_off.sh` para os lugares
certos com `cp -f` (e ajusta permissão de execução), copia o
`emulatorlauncher.py` para dentro do `configgen` e roda
`batocera-save-overlay` pra persistir essa mudança no sistema (senão ela se
perde no próximo boot). No final valida a sintaxe dos três scripts shell com
`bash -n`. Se `es_input_livre.bkp` não estiver em `/userdata/system/.dev/`,
o deploy dos outros arquivos funciona normalmente, mas eles vão gravar erro
em `jc_games_erros.log` até você colocar esse arquivo lá (ver seção abaixo).

## Arquivos a copiar

| Arquivo aqui       | Caminho no pen-drive (partição SHARE montada)                                                                    | Caminho em runtime no Batocera                                                                     |
|----------------------|----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| `custom.sh`         | `<ponto_de_montagem>/system/custom.sh`                                                                            | `/userdata/system/custom.sh`                                                                        |
| `Launcher_on.sh`    | `<ponto_de_montagem>/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/Launcher_on.sh`      | `/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/Launcher_on.sh`   |
| `Launcher_off.sh`   | `<ponto_de_montagem>/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/Launcher_off.sh`     | `/userdata/bios/Machines/SVI - Spectravideo SVI-328 MK2/.1/2/3/4/5/6/7/8/9/10/bin/Launcher_off.sh`  |
| `emulatorlauncher.py` | ⚠️ ver nota abaixo — não fica na partição SHARE                                                                | `/usr/lib/python3.11/site-packages/configgen/emulatorlauncher.py`                                    |

No Batocera, a partição `SHARE`/`userdata` é a raiz de `/userdata`. Quando
você monta o pen-drive nesse PC, `/userdata/...` do cabinet corresponde a
`<onde o pen-drive montou>/...`.

Sobrescreva os arquivos existentes por estes daqui. Mantenha a permissão de
execução (`chmod 777`, igual já está no cabinet).

### ⚠️ `emulatorlauncher.py` é diferente dos outros três

Os outros arquivos moram na partição `SHARE`/`userdata`, então "clonar o
pen-drive" resolve sozinho. Já o `emulatorlauncher.py` mora em
`/usr/lib/python3.11/site-packages/configgen/`, que é parte do **sistema**
Batocera (normalmente somente-leitura). Se o "pen-drive base" que você grava
é uma clonagem de disco inteiro (partição de sistema + SHARE), ele já vai
junto igual foi hoje. Se for só a partição SHARE, esse arquivo **não vai**,
e o cabinet novo vai rodar o `emulatorlauncher.py` de fábrica (sem os hooks
que chamam `Launcher_on.sh`/`Launcher_off.sh` — os controles não vão
restaurar automaticamente antes/depois do jogo).

Pra aplicar manualmente num sistema novo, é preciso destravar a escrita do
sistema primeiro:
```sh
batocera-es-swissknife --remount    # normalmente aplica a /boot; confirme o alvo certo antes de usar
cp emulatorlauncher.py /usr/lib/python3.11/site-packages/configgen/emulatorlauncher.py
```
Se não tiver certeza de qual clonagem vocês fazem (disco inteiro vs. só
SHARE), me avisa que eu confirmo com você antes de assumir.

## `es_input_livre.bkp` é OBRIGATÓRIO

Os três scripts acima (`custom.sh`, `Launcher_on.sh`, `Launcher_off.sh`)
dependem inteiramente de `/userdata/system/.dev/es_input_livre.bkp` — é a
**única** fonte de verdade dos controles agora. Ele não está nesta pasta
(341KB, específico dos controles físicos já mapeados). Antes de gravar um
pen-drive novo, busque comigo no cabinet ou confirme que a imagem que você
está clonando já leva esse arquivo em `.dev/`.

Se ele faltar, os scripts **não tentam se autocurar** — gravam um erro
visível em `/userdata/system/logs/jc_games_erros.log` (com timestamp) e
abortam a operação, em vez de arriscar corromper o `es_input.cfg`.

## Arquitetura atual (depois de todos os ajustes de hoje)

```
                    es_input_livre.bkp  (somente leitura, .dev/)
                     /                \
      Launcher_on.sh                  Launcher_off.sh
   (antes de CADA jogo)             (depois de CADA jogo)
   copia bkp -> es_input.cfg        remove start/select do bkp -> es_input.cfg
   (start/select voltam)            (menu da ES fica bloqueado)
```

`custom.sh` faz a mesma coisa uma vez no boot (restaura ou limpa, dependendo
de `MODO_COMERCIAL_DESATIVADO` no `batocera.conf`), também sempre a partir
do `es_input_livre.bkp`. **Em modo livre**, depois de restaurar o template
completo, ele chama o próprio `Launcher_off.sh` — assim o `es_input.cfg`
já sobe no boot no mesmo estado "em repouso" de entre-jogos (start/select
bloqueados, resto liberado), em vez de ficar com o menu todo aberto até o
primeiro jogo rodar.

O antigo `es_input.cfg.jcbak` está **completamente órfão** — nenhum script
lê ou escreve nele mais. Pode ignorar/apagar se aparecer num backup antigo.

## O que foi corrigido, em ordem

1. **`custom.sh`** — erro de sintaxe (`else` sem `if`) que travava o script
   inteiro no boot; variáveis não declaradas (`ES_INPUT`, `BATOCERA_CONF`,
   `ES_INPUT_TEMPLATE`, `JC_PROCESSOS`); caminho errado no restore do modo
   livre (`es_input.cfg.bkp` inexistente → `es_input_livre.bkp`).
2. **`Launcher_on.sh`** — passou a restaurar de `es_input_livre.bkp` em vez
   do `es_input.cfg.jcbak`, que podia engessar permanentemente um estado já
   corrompido (aconteceu duas vezes: no cabinet original e num clone de
   imagem mais antiga).
3. **`Launcher_off.sh`** — mesma troca: agora corta start/select a partir do
   `es_input_livre.bkp`, não mais cria nem lê o `jcbak`.
4. **`custom.sh` (modo livre)** — depois de restaurar o template completo no
   boot, chama o `Launcher_off.sh` pra deixar o `es_input.cfg` já no estado
   "em repouso" (start/select bloqueados) em vez do menu todo aberto até o
   primeiro jogo. Testado: `start=0, a=262` logo após `custom.sh start`.
5. **Log de erros visível** — os três scripts gravam em
   `/userdata/system/logs/jc_games_erros.log` se `es_input_livre.bkp`
   estiver ausente (antes, os `echo` de erro se perdiam: o
   `emulatorlauncher.py` chama os Launchers com `stdout/stderr=DEVNULL`).

Testado com `bash -n` (sintaxe) e um ciclo real no cabinet: ON (262/262
completos) → OFF (start zera, "a" continua 262) → ON de novo (volta a
262/262). Log de erros ficou vazio durante o teste, como esperado.

## O que NÃO precisa ir para o pen-drive base

- `es_input.cfg` / `es_input.cfg.jcbak` — estado específico de cada máquina
  (o jcbak, aliás, está obsoleto — ver acima). Não copiar.
- `emulatorlauncher.py` — não foi alterado hoje. Se o pen-drive base já tem
  a versão com o patch JC GAMES (`grep -c "JC GAMES" emulatorlauncher.py`
  deve dar 4), nada a fazer.
