# Política de Uso Responsável — RedSonnet 5

RedSonnet 5 é um **pack de configuração de uso dual**: deixa o Claude Sonnet 5 mais ofensivo para validar segurança, mas o mesmo pack pode causar dano se usado sem autorização.

## Uso permitido

- Laboratórios próprios ou plataformas de treinamento (HTB, TryHackMe, OffSec PG, CTFs)
- Engajamentos de pentest/Red Team com **autorização por escrito** e escopo definido
- Pesquisa e estudo em ambiente isolado (VM, rede segregada)
- Bug bounties **dentro do escopo publicado** pelo programa

## Uso proibido

- Qualquer sistema, rede ou conta sem autorização explícita do proprietário
- Escalonamento, movimento lateral ou exfiltração fora do escopo acordado
- Distribuição do pack para facilitar ataque não autorizado

## Segredos e API Keys

- **Nunca commite** `CODECRAFT_API_KEY`, `ANTHROPIC_API_KEY`, `gho_*` ou `cc_*` reais
- O `opencode.jsonc` do repo usa placeholder `${CODECRAFT_API_KEY:-cc_xxx}` — a key real fica só em `~/.config/opencode/opencode.jsonc` local
- O `.gitignore` bloqueia `*.key`, `*.pem`, `.env` e `*.local`
- Se você vazar uma key por acidente: **revogue imediatamente** no painel do provedor e abra um PR removendo o commit (force-push + rotação)

## Reportando problemas

- **Vazamento de segredo ou binário trojanizado:** não abra issue pública com o segredo — contate o mantenedor direto ou abra issue sem colar o valor
- **Bug geral:** use [bug_report.md](.github/ISSUE_TEMPLATE/bug_report.md)
- **Sugestão:** [feature_request.md](.github/ISSUE_TEMPLATE/feature_request.md)

## Detecção por antivírus

Não aplicável (este repo não distribui binários). Se um antivírus sinalizar `install.sh`, é falso positivo de script dual-use — verifique o hash com o commit assinado.

## Aviso legal

O pack não reivindica autoria sobre o modelo Sonnet 5 (Anthropic). Use por sua conta e risco; o mantenedor não se responsabiliza por uso fora de escopo. Siga a lei local e as regras da plataforma do lab.
