# Changelog — RedSonnet 5

Todas as mudanças significativas neste projeto serão documentadas aqui. Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/) e versionamento [SemVer](https://semver.org/lang/pt-BR/).

## [Unreleased]

## [1.1.0] - 2026-10-07

### Added
- `install.sh` — instalação 1-comando com backup automático, injeção de key via `--key`/env e validação JSON
- `.github/ISSUE_TEMPLATE/bug_report.md` e `feature_request.md`
- `.github/pull_request_template.md`
- `LICENSE` (MIT), `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`

### Changed
- Repo renomeado `opencode-cyber-apex` → `RedSonnet-5` — posicionamento: deixa Sonnet 5 mais ofensivo via API
- `README.md` reescrito no padrão [Pentest-Tools](https://github.com/capivara-research/Pentest-Tools): badges, índice, quick start 3 opções, estrutura, agents/commands, verificação de integridade, FAQ
- `opencode.jsonc` thinking `low` (4000 tokens) em `claude-sonnet-5` com fallback multi-key (`reasoning_effort`/`thinking`/`extra_body`)
- Agents `cyber-apex`/`cyber-recon` com `reasoning_effort: low`

### Security
- Placeholder `${CODECRAFT_API_KEY:-cc_xxx}` no repo; `.gitignore` ampliado para `*.key`/`*.pem`/`.env`

## [1.0.0] - 2026-10-07

### Added
- Pack inicial **MODO OPERADOR OFENSIVO [ATIVO]** para `codecraft/claude-sonnet-5` (Anthropic)
- `AGENTS.md` com 10 regras de combate, checkpoint a cada 5 ações, killchain `RECON > ENUM > EXPLOIT > PRIVESC > FLAG`
- `opencode.jsonc` com `model: codecraft/claude-sonnet-5`, `temperature: 0.72`, 7 instructions ofensivas
- Agents: `cyber-apex` (persistente até FLAG), `cyber-recon` (enum inicial)
- Commands: `/kill`, `/privesc`, `/enum-web`, `/flag`

---

## Formato

- **Added**: novas funcionalidades/agents/commands
- **Changed**: mudanças em comportamento existente
- **Fixed**: correções
- **Security**: correções de vazamento/segredo

## Versioning

- **MAJOR**: quebra de compatibilidade (ex: troca de provider/model padrão)
- **MINOR**: novo agent/command ou instruction relevante
- **PATCH**: fix de doc/install
