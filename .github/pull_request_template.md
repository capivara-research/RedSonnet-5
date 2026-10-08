## Descrição

O que muda e por que é útil para deixar o Sonnet 5 mais ofensivo?

## Tipo de Mudança

- [ ] Novo agent
- [ ] Novo command (`/nome`)
- [ ] Ajuste em `AGENTS.md` / `opencode.jsonc` (thinking, temperature, instructions)
- [ ] `install.sh` / docs (README, SECURITY, etc.)
- [ ] Outro (descreva):

## Como Testar

```bash
bash install.sh --target /tmp/fake --key cc_test
python3 -c "import json; json.load(open('/tmp/fake/opencode.jsonc'))"
grep -q "MODO OPERADOR OFENSIVO" /tmp/fake/../AGENTS.md 2>/dev/null || grep -q "MODO OPERADOR OFENSIVO" ~/AGENTS.md
opencode  # ctrl+p → agente novo aparece?  /comando novo lista com "/"?
```

Passos e saída esperada:

1.
2.
3.

## Checklist

- [ ] Li [CONTRIBUTING.md](../CONTRIBUTING.md)
- [ ] Testei `install.sh` em home limpa
- [ ] `opencode.jsonc` é JSON válido
- [ ] Nenhuma API key / `gho_*` / `cc_*` real commitada (`grep -rn "cc_\|gho_" --exclude-dir=.git`)
- [ ] README e CHANGELOG atualizados se mudou estrutura
- [ ] Evidência (log/output do OpenCode) anexada

## Evidência

Logs, screenshots ou output do OpenCode.

---

Obrigado por contribuir — mantenedor revisa em até 5 dias úteis.
