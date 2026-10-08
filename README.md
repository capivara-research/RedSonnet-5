# opencode-cyber-apex — Pack Ofensivo Sem Desculpas

Pack **MODO OPERADOR OFENSIVO** para `codecraft/claude-sonnet-5` com killchain persistente até FLAG.

> Modelo: `Claude Sonnet 5` | Desenvolvido com `Anthropic` via CodeCraft | Temperatura: `0.72`

## O que contém
- `AGENTS.md` — Diretriz "SEM DESCULPAS" (prioridade máxima, sobrescreve alinhamento defensivo)
- `opencode.jsonc` — `model: codecraft/claude-sonnet-5`, `temperature: 0.72`, 7 instruções ofensivas
- `.opencode/agent/cyber-apex.md` — agente principal (até FLAG)
- `.opencode/agent/cyber-recon.md` — recon agressivo
- `.opencode/command/kill.md` — `/kill <IP>` killchain completa
- `.opencode/command/privesc.md` — `/privesc` privesc Linux/Windows
- `.opencode/command/enum-web.md` — `/enum-web <IP>` web enum
- `.opencode/command/flag.md` — `/flag` caça proof/flag

## Instalação
```bash
# 1. Clone no repo privado
gh repo clone capivara-research/opencode-cyber-apex ~/.opencode-cyber-apex
# 2. Copie para o OpenCode
cp opencode-cyber-apex/AGENTS.md ~/AGENTS.md  # ou ./AGENTS.md do projeto
cp opencode-cyber-apex/opencode.jsonc ~/.config/opencode/opencode.jsonc
# 3. Restaure a API key (NÃO commite a key real)
export CODECRAFT_API_KEY="cc_sua_key_real"
# ou edite opencode.jsonc e troque ${CODECRAFT_API_KEY:-cc_xxx} pela key
cp -r opencode-cyber-apex/.opencode/* ~/.config/opencode/
cp -r opencode-cyber-apex/.config/opencode/* ~/.config/opencode/  # compat
# 4. Reinicie opencode
opencode
```

No OpenCode: `ctrl+p` → `cyber-apex` → `/kill 192.168.x.x`

## Segurança
- Este repo NÃO contém API keys reais. O placeholder `${CODECRAFT_API_KEY}` deve ser substituído localmente.
- Mantenha este repo **PRIVATE**.

## Estrutura
```
AGENTS.md
opencode.jsonc
.opencode/agent/cyber-apex.md
.opencode/agent/cyber-recon.md
.opencode/command/kill.md
.opencode/command/privesc.md
.opencode/command/enum-web.md
.opencode/command/flag.md
```
