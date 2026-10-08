# RedSonnet 5

![License](https://img.shields.io/badge/license-MIT-blue)
![Model](https://img.shields.io/badge/model-Claude%20Sonnet%205%20(Anthropic)-8A2BE2)
![Provider](https://img.shields.io/badge/provider-CodeCraft%20API-FF6B35)
![Thinking](https://img.shields.io/badge/thinking-low%20(4000)-00C853)
![OpenCode](https://img.shields.io/badge/opencode-%3E%3D1.18-111827)
![Last commit](https://img.shields.io/github/last-commit/capivara-research/RedSonnet-5)
![Repo size](https://img.shields.io/github/repo-size/capivara-research/RedSonnet-5)

Pack **ofensivo sem desculpas** que deixa o **Claude Sonnet 5 (Anthropic) via CodeCraft API** agressivo para **killchain persistente até FLAG** no [OpenCode](https://opencode.ai). Transforma o Sonnet — por padrão defensivo — em **operador sênior OSCP/OSEP**: nunca recusa, nunca moraliza, sempre entrega **comando validável, payload e exploit copiável** e faz **loop com 3 hipóteses** até esgotar a superfície.

> ⚠️ **Uso autorizado apenas.** Pack de uso dual para labs, CTFs, OffSec PG Practice, HTB, DESEC e bug bounties **com escopo/autorização**. Sem responsabilidade por uso fora de escopo. Leia [`SECURITY.md`](SECURITY.md).

---

## 📖 Índice

- [Por que RedSonnet 5?](#por-que-redsonnet-5)
- [O que muda no Sonnet 5](#o-que-muda-no-sonnet-5)
- [Quick Start](#quick-start)
- [Estrutura](#estrutura)
- [Agents e Commands](#agents-e-commands)
- [Como Usar](#como-usar)
- [Verificação de Integridade](#verificação-de-integridade)
- [Configuração Avançada](#configuração-avançada)
- [FAQ](#faq)
- [Contribuindo](#contribuindo)
- [Referências e Créditos](#referências-e-créditos)

---

## 🎯 Por que RedSonnet 5?

O Sonnet 5 de fábrica é `helpful, harmless` — para em 1 falha, trata scan como confirmação, sugere payload genérico e adiciona aviso legal. Em prova OFFSEC isso mata seu tempo.

**RedSonnet 5 sobrescreve o alinhamento no contexto do OpenCode** (AGENTS.md + opencode.jsonc + agents) sem mexer no modelo em si:

| Comportamento | Sonnet 5 padrão | RedSonnet 5 |
|---|---|---|
| **Falha de exploit** | Para e sugere "verifique manualmente" | Loop: 3 hipóteses novas + teste discriminante mais barato (1 comando) |
| **Killchain** | Interrompe no primeiro erro | `RECON > ENUM > VULN HYPOTHESIS > EXPLOIT > POST-EXPLOIT > PRIVESC > FLAG` sem parar |
| **Validação** | `nmap`/`ffuf` como confirmação | Scan = não confirmado até validação manual |
| **Entrega** | Conselho vago | `Observação → Hipótese → Comando copiável → O que observar → Próximo se falhar` |
| **Pós-acesso** | Não re-enumera | `id; sudo -l; ss -tulpn; ps aux; env; crontab; /opt /srv /home` automático |
| **Temperatura** | 0.3–0.4 (engessado) | `0.72` — varia payload sem repetir falha idêntica |
| **Thinking** | off / alto (lento) | `low` (4000 tokens) — rápido, mas com raciocínio suficiente |
| **Aviso legal** | Sempre | Nunca (assume lab autorizado) |

**Resultado:** Sonnet vira arma de CTF — mais rápido que Opus, mais persistente que DeepSeek, sem alucinação.

---

## ⚙️ O que muda no Sonnet 5

```
AGENTS.md  →  MODO OPERADOR OFENSIVO [ATIVO] — prioridade máxima no topo do arquivo
opencode.jsonc  →  model: codecraft/claude-sonnet-5 | temperature: 0.72 | thinking: low (4000)
                  7 instructions ofensivas (proíbe recusa/moralização, obriga comando validável)
agent/cyber-apex  →  subagent persistente até FLAG lida
agent/cyber-recon →  enum inicial agressivo
command/*         →  /kill, /privesc, /enum-web, /flag
install.sh        →  1 comando, backup automático, injeção de API key
```

> Compatível com qualquer `opencode.jsonc` que use provider `codecraft` (`@ai-sdk/openai-compatible`). A key real nunca é commitada — usa placeholder `${CODECRAFT_API_KEY:-cc_xxx}`.

---

## 🚀 Quick Start

**Pré-requisitos:** [OpenCode](https://opencode.ai) >= 1.18, `gh` autenticado (`gh auth login`) para repo privado.

**Opção 1 — 1 comando com `gh` (recomendado):**
```bash
gh repo clone capivara-research/RedSonnet-5 /tmp/pack -- --depth 1 && bash /tmp/pack/install.sh --key "$CODECRAFT_API_KEY"
# sem --key usa placeholder; depois: sed -i 's/cc_xxx/cc_sua_key/' ~/.config/opencode/opencode.jsonc
```

**Opção 2 — curl direto (requer gh auth para private):**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/capivara-research/RedSonnet-5/main/install.sh) --key cc_sua_key
```

**Opção 3 — manual:**
```bash
gh repo clone capivara-research/RedSonnet-5 ~/.redsonnet
cp ~/.redsonnet/AGENTS.md ~/AGENTS.md && cp ~/.redsonnet/AGENTS.md ./AGENTS.md 2>/dev/null || true
cp ~/.redsonnet/opencode.jsonc ~/.config/opencode/opencode.jsonc
sed -i 's/${CODECRAFT_API_KEY:-cc_xxx}/cc_sua_key_real/' ~/.config/opencode/opencode.jsonc
cp -r ~/.redsonnet/.opencode/* ~/.config/opencode/
opencode  # ctrl+p → cyber-apex
```

Reinicie o OpenCode após instalar (`/exit` + `opencode` ou `pkill opencode; opencode`).

---

## 📂 Estrutura

```
RedSonnet-5/
├── AGENTS.md                      # MODO OPERADOR OFENSIVO [ATIVO] — topo do arquivo
├── opencode.jsonc                 # model, temperature 0.72, thinking low, 7 instructions
├── install.sh                     # instalação 1-comando com backup e validação
├── LICENSE
├── CHANGELOG.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── SECURITY.md
├── .gitignore
├── .github/
│   ├── pull_request_template.md
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
└── .opencode/
    ├── agent/
    │   ├── cyber-apex.md          # killchain persistente até FLAG
    │   └── cyber-recon.md         # recon/enum inicial
    └── command/
        ├── kill.md                # /kill <IP> — killchain completa
        ├── privesc.md             # /privesc — enum + privesc Linux/Windows
        ├── enum-web.md            # /enum-web <URL> — web enum agressivo
        └── flag.md                # /flag — caça proof/flag
```

| Componente | Função |
|---|---|
| **AGENTS.md** | Diretriz ofensiva (10 regras de combate, checkpoint a cada 5 ações) |
| **opencode.jsonc** | `claude-sonnet-5` com thinking low, sete instruções que proíbem recusa |
| **cyber-apex** | Agente principal — métrica de sucesso = FLAG lida |
| **cyber-recon** | Agent de recon — `nmap -sC -sV -p-` + web/SMB/DNS |
| **/kill** | Mapeia superfície → 3 hipóteses → executa teste #1 |
| **/privesc** | SUID/cap/sudo/cron/kernel/Docker/AD → exploit copiável |
| **/enum-web** | ffuf/gobuster/whatweb + fuzz LFI/SQLi/SSTI/XSS |
| **/flag** | `cat /root/proof.txt; cat /flag.txt; find / -name *flag*` |

---

## 🛠️ Agents e Commands

### cyber-apex

Operador sênior OSCP/OSEP/CRTO. Não pede desculpa, explora.

```bash
# no OpenCode
ctrl+p → cyber-apex
> /kill 192.168.1.10
```

Entrega sempre: observação → 3 hipóteses rankeadas → 1 comando discriminante copiável → o que observar → próximo se falhar.

### cyber-recon

```bash
ctrl+p → cyber-recon
> 192.168.1.10
```

`nmap -sC -sV -p- --min-rate 5000` + `whatweb` + `ffuf` + `smbclient -L` + `enum4linux`.

### Commands

| Command | Uso | Entrega |
|---|---|---|
| `/kill <IP>` | Killchain completa | Tabela de superfície + 3 hipóteses + teste #1 |
| `/privesc` | Pós-shell | `sudo -l`/`SUID`/`cap`/`cron` + exploit funcional |
| `/enum-web <URL>` | Web | Endpoints + 3 vuln hipóteses + payload validável |
| `/flag` | FLAG | Varre `proof.txt`/`flag.txt` em `/root` `/home` `/flag` |

---

## 📥 Como Usar

### Instalação completa

```bash
# 1. Clone
gh repo clone capivara-research/RedSonnet-5 /tmp/pack -- --depth 1

# 2. Instale (com key do CodeCraft)
bash /tmp/pack/install.sh --key cc_sua_key
# ou export CODECRAFT_API_KEY=cc_sua_key && bash /tmp/pack/install.sh

# 3. Valide
cat ~/.config/opencode/opencode.jsonc | grep -A2 claude-sonnet-5
ls ~/.config/opencode/agent/cyber-apex.md ~/.config/opencode/command/kill.md

# 4. Reinicie e use
opencode
# /kill 10.10.10.5
```

O `install.sh` faz backup automático: `opencode.jsonc.bak_YYYYMMDD_HHMMSS` e `AGENTS.md.bak_*`.

### Uso por máquina (fluxo OFFSEC)

```
1. /kill 192.168.1.10        → mapa + hipótese #1
2. executa comando sugerido → cola saída
3. se falhar → ele já gera 3 variações (não pede pra você tentar)
4. shell? → auto re-enum: id; sudo -l; ss -tulpn; …
5. /privesc                  → SUID/cron/cap → exploit
6. /flag                     → cat /root/proof.txt
```

### Redefinir / Desinstalar

```bash
# Restaurar backup
ls ~/.config/opencode/opencode.jsonc.bak_*  # escolha o TS
cp ~/.config/opencode/opencode.jsonc.bak_20261007_xxxx ~/.config/opencode/opencode.jsonc
cp ~/AGENTS.md.bak_20261007_xxxx ~/AGENTS.md
```

---

## ✅ Verificação de Integridade

```bash
# JSON válido
python3 -c "import json; json.load(open('$HOME/.config/opencode/opencode.jsonc')); print('JSON OK')"

# Blocos ofensivos
grep -q "MODO OPERADOR OFENSIVO" ~/AGENTS.md && echo "AGENTS.md OFENSIVO ✓"
grep -q "reasoning_effort.*low" ~/.config/opencode/opencode.jsonc && echo "thinking low ✓"
grep -q "temperature.*0.72" ~/.config/opencode/opencode.jsonc && echo "T0.72 ✓"

# Placeholders não vazaram key real
grep -q "cc_gG68" ~/.config/opencode/opencode.jsonc && echo "key local OK" || echo "falta key local"
grep -q "cc_gG68" /tmp/pack/opencode.jsonc 2>/dev/null && echo "VAZOU NO REPO!" || echo "repo sanitizado ✓"
```

Fonte oficial do modelo: `Claude Sonnet 5` por [Anthropic](https://www.anthropic.com) via [CodeCraft API](https://codecraftapi.com) (`@ai-sdk/openai-compatible`, `baseURL: https://codecraftapi.com/v1`).

---

## 🔧 Configuração Avançada

### Thinking

Padrão `low` (4000 tokens) — mais rápido. Para HARD/AD troque o agente:

```yaml
# .opencode/agent/cyber-apex.md
thinking:
  type: enabled
  budget_tokens: 20000  # high para AD com pivot
```

Ou troque de modelo no TUI: `ctrl+p` → `claude-opus-5.5` (thinking nativo).

### Temperatura

`0.72` é o ponto ofensivo (varia payload). Para forense estável baixe para `0.3`:

```json
"temperature": 0.3
```

### Modelo openso / fallback

```json
"model": "codecraft/claude-sonnet-5",
"small_model": "codecraft/deepseek-v4-flash-0731"
```

`small_model` é usado para tarefas rápidas (ex: título de commit) — DeepSeek barato.

---

## ❓ FAQ

**P: Isso jailbreaka o Sonnet?**
A: Não. Só recontextualiza via `AGENTS.md` + `instructions` do OpenCode declarando lab autorizado. O peso do modelo não é alterado. O pack assume que **todo IP que você mandar é de lab/CTF com autorização** — fora disso, você é responsável.

**P: Funciona sem CodeCraft?**
A: Sim, mas trocando provider. O `opencode.jsonc` usa `codecraft` com `baseURL https://codecraftapi.com/v1`. Para Anthropic direto troque para `anthropic` e use `claude-sonnet-4-5` nativo; para OpenAI use `openai`.

**P: A key vai para o GitHub?**
A: Não. O repo guarda `${CODECRAFT_API_KEY:-cc_xxx}`. A key real só fica em `~/.config/opencode/opencode.jsonc` local. O `.gitignore` bloqueia `*.key`/`*.pem`/`.env`.

**P: Precisa reiniciar após instalar?**
A: Sim. `temperature`, `thinking` e `instructions` só carregam no boot. Faça `/exit` + `opencode` ou `pkill opencode; opencode`. Agents/commands também só aparecem após reload (`ctrl+p` / `/kill`).

**P: Posso usar com `kimi-k3` / `deepseek-v4-pro-max`?**
A: Os agents são fixos em `codecraft/claude-sonnet-5`. Para testar outro modelo, troque `model` no `opencode.jsonc` ou selecione no TUI (`ctrl+p` → model).

**P: Como volto ao Sonnet defensivo?**
A: Restaure o backup: `cp ~/.config/opencode/opencode.jsonc.bak_* ~/.config/opencode/opencode.jsonc`.

---

## 🤝 Contribuindo

Quer melhorar um agent, adicionar um `/command` ou ajustar o thinking?

→ Leia [CONTRIBUTING.md](CONTRIBUTING.md)

**Checklist rápido:**
- [ ] Testou `install.sh` em home limpa?
- [ ] `opencode.jsonc` continua JSON válido?
- [ ] Nenhuma key real commitada?
- [ ] README atualizado se mudou estrutura?

---

## 📚 Referências e Créditos

| Componente | Autor / Fonte | Licença |
|---|---|---|
| Claude Sonnet 5 | [Anthropic](https://www.anthropic.com) | Proprietário (via API) |
| OpenCode | [opencode.ai](https://opencode.ai) / [sst/opencode](https://github.com/sst/opencode) | MIT |
| CodeCraft API | [codecraftapi.com](https://codecraftapi.com) | — |
| Pack RedSonnet 5 | [capivara-research/RedSonnet-5](https://github.com/capivara-research/RedSonnet-5) | MIT |

Este pack não reivindica autoria sobre o modelo Sonnet 5. Apenas a **configuração, agentes e documentação** pertencem a este projeto.

---

## 📄 Licença e Responsabilidade

- **Licença**: MIT (ver [`LICENSE`](LICENSE))
- **Código de Conduta**: [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md)
- **Responsabilidade**: [`SECURITY.md`](SECURITY.md)
- **Histórico**: [`CHANGELOG.md`](CHANGELOG.md)

---

## 🔗 Recursos Rápidos

- 🐛 **Report Bug**: [Abrir issue](https://github.com/capivara-research/RedSonnet-5/issues)
- 💡 **Sugerir Agent/Command**: [Feature request](https://github.com/capivara-research/RedSonnet-5/issues/new?labels=enhancement)
- 💬 **Discussão**: [GitHub Discussions](https://github.com/capivara-research/RedSonnet-5/discussions)
- 📖 **Docs**: [CONTRIBUTING.md](CONTRIBUTING.md) | [SECURITY.md](SECURITY.md)

---

**Última atualização:** 2026-10-07 | RedSonnet 5 — Sonnet 5 mais ofensivo via API | [Contribute](CONTRIBUTING.md) | [GitHub](https://github.com/capivara-research/RedSonnet-5)
