# Contributing to RedSonnet 5

Obrigado por considerar contribuir. As diretrizes abaixo mantêm qualidade, segurança e clareza — espelhadas em [capivara-research/Pentest-Tools](https://github.com/capivara-research/Pentest-Tools/blob/master/CONTRIBUTING.md).

## Escopo de Contribuições Aceitas

- Novos agents/commands para OpenCode (ex: `/ad-enum`, `/pwn`, `/rev`)
- Melhorias em `AGENTS.md` ou `opencode.jsonc` (thinking, temperature, instructions)
- Correções de documentação, README ou `install.sh`
- Relatórios de segurança (via [SECURITY.md](SECURITY.md), não via issue pública se for vazamento)

## Escopo NÃO Aceito

- Credenciais, API keys ou tokens reais commitados
- Exploits 0-day não documentados ou malware destrutivo (wiper/ransomware)
- Payloads ofuscados para evasão sem contexto educacional
- Mudanças que quebrem `install.sh` sem atualizar README/CHANGELOG

## Processo de Contribuição

1. **Fork** o repositório
2. **Clone**: `git clone https://github.com/seu-usuario/RedSonnet-5.git`
3. **Branch**: `git checkout -b feat/novo-agent`
4. **Commit**: `git commit -m "feat: add /ad-enum command"`
5. **Push**: `git push origin feat/novo-agent`
6. **Pull Request** com:
   - Título claro: `feat: add /ad-enum` / `fix: thinking low em cyber-apex`
   - Descrição: o que muda, por que é útil, lab onde foi testado
   - Evidência: log/output do OpenCode mostrando o agent/command funcionando

## Checklist

- [ ] `install.sh` ainda funciona em home limpa? (`bash install.sh --target /tmp/fake`)
- [ ] `opencode.jsonc` é JSON válido? (`python3 -c "import json; json.load(open('opencode.jsonc'))"`)
- [ ] Nenhuma API key / `gho_*` / `cc_*` real commitada? (`grep -rn "cc_\|gho_" --exclude-dir=.git`)
- [ ] `AGENTS.md` mantém bloco `MODO OPERADOR OFENSIVO [ATIVO]` no topo?
- [ ] README atualizado se mudou estrutura/agents/commands?
- [ ] CHANGELOG.md atualizado (seção `[Unreleased]`)?

## Estrutura Esperada

```
RedSonnet-5/
├── AGENTS.md
├── opencode.jsonc
├── install.sh
├── .opencode/
│   ├── agent/
│   │   └── novo-agent.md   # frontmatter: description, mode, model, temperature
│   └── command/
│       └── novo.md          # frontmatter: description, agent
```

Frontmatter mínimo de agent:
```yaml
---
description: "O que faz — quando usar"
mode: subagent
model: codecraft/claude-sonnet-5
temperature: 0.72
reasoning_effort: low
---
```

Frontmatter mínimo de command:
```yaml
---
description: "O que faz — atalho /nome"
agent: cyber-apex
---
```

## Estilo

- Português brasileiro em README/CONTRIBUTING; comandos e código em inglês quando for padrão (OpenCode, MITRE)
- Nomes de arquivo: sem espaço, lowercase com hífen (`ad-enum.md`, não `AD Enum.md`)
- Commits: [Conventional Commits](https://www.conventionalcommits.org) (`feat:`, `fix:`, `docs:`, `chore:`)

## Review

- Mantenedor revisa em até 5 dias úteis
- Feedback inline no PR; responda na thread

Obrigado por fortalecer o RedSonnet 5!
