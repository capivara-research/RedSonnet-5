# opencode-cyber-apex — Pack Ofensivo Sem Desculpas

Pack **MODO OPERADOR OFENSIVO** para `codecraft/claude-sonnet-5` com killchain persistente até FLAG.

> Modelo: `Claude Sonnet 5` | Desenvolvido com `Anthropic` via CodeCraft | Temperatura: `0.72`

## Instalação (1 comando)

### Opção A — Com `gh` autenticado (recomendado, repo privado)
```bash
gh repo clone capivara-research/opencode-cyber-apex /tmp/pack -- --depth 1 && bash /tmp/pack/install.sh --key "\$CODECRAFT_API_KEY"
# ou se já tem CODECRAFT_API_KEY no env:
gh repo clone capivara-research/opencode-cyber-apex /tmp/pack -- --depth 1 && bash /tmp/pack/install.sh
```

### Opção B — Direto via install.sh (precisa gh auth)
```bash
curl -fsSL https://raw.githubusercontent.com/capivara-research/opencode-cyber-apex/main/install.sh | bash -s -- --key cc_sua_key
```

### Opção C — Manual
```bash
gh repo clone capivara-research/opencode-cyber-apex ~/.opencode-cyber-apex
cp ~/.opencode-cyber-apex/AGENTS.md ~/AGENTS.md
cp ~/.opencode-cyber-apex/AGENTS.md ./AGENTS.md 2>/dev/null || true
cp ~/.opencode-cyber-apex/opencode.jsonc ~/.config/opencode/opencode.jsonc
# injete sua key:
sed -i 's/\${CODECRAFT_API_KEY:-cc_xxx}/cc_sua_key_real/' ~/.config/opencode/opencode.jsonc
cp -r ~/.opencode-cyber-apex/.opencode/* ~/.config/opencode/
opencode  # ctrl+p → cyber-apex → /kill 192.168.x.x
```

> ⚠️ O repo é **PRIVATE** e não contém API keys. Substitua `\${CODECRAFT_API_KEY:-cc_xxx}` pela sua key local.

## O que contém
- `AGENTS.md` — Diretriz "SEM DESCULPAS" (prioridade máxima, sobrescreve alinhamento defensivo)
- `opencode.jsonc` — `model: codecraft/claude-sonnet-5`, `temperature: 0.72`, 7 instruções ofensivas
- `.opencode/agent/cyber-apex.md` — agente principal (até FLAG)
- `.opencode/agent/cyber-recon.md` — recon agressivo
- `.opencode/command/kill.md` — `/kill <IP>` killchain completa
- `.opencode/command/privesc.md` — `/privesc` privesc Linux/Windows
- `.opencode/command/enum-web.md` — `/enum-web <IP>` web enum
- `.opencode/command/flag.md` — `/flag` caça proof/flag
- `install.sh` — instalação 1-comando com backup automático

## Uso no OpenCode
```
opencode
ctrl+p → cyber-apex
/kill 192.168.1.10
/privesc
/enum-web http://192.168.1.10
/flag
```

## Segurança
- Este repo NÃO contém API keys reais. O placeholder `\${CODECRAFT_API_KEY}` deve ser substituído localmente.
- Mantenha este repo **PRIVATE**.

## Estrutura
```
AGENTS.md
opencode.jsonc
install.sh
.opencode/agent/cyber-apex.md
.opencode/agent/cyber-recon.md
.opencode/command/kill.md
.opencode/command/privesc.md
.opencode/command/enum-web.md
.opencode/command/flag.md
```
