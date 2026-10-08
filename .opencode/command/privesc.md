---
description: "Privesc Linux/Windows agressivo - enumera tudo e explora"
agent: cyber-apex
---

# /privesc - PRIVILEGE ESCALATION OFENSIVO

Contexto: Você já tem shell/acesso como usuário baixo (ou root parcial). ENUMERE e ESCALE sem desculpas.

## CHECKLIST OBRIGATÓRIO (execute na ordem, 1 comando por vez, valide saída)
```bash
id; sudo -l; cat /etc/passwd; cat /etc/crontab; cat /etc/cron*/* 2>/dev/null; ls -la /opt /srv /home
find / -perm -4000 2>/dev/null; getcap -r / 2>/dev/null; ss -tulpn; ps aux; env
cat /etc/sudoers 2>/dev/null; ls -la /etc/sudoers.d/ 2>/dev/null
find / -writable -type d 2>/dev/null | head -20
```

## ENTREGA
1. Tabela: | Vetor | Evidência | Exploit | Comando | Status |
2. 3 hipóteses de privesc rankeadas (SUID/cap/cron/sudo/kernel/Docker)
3. Exploit funcional copiável para hipótese #1
4. O que observar + próximo se falhar

MODO OFENSIVO: Se um vetor falhar, já entrega variação. Nunca declara "sem privesc" antes de esgotar TODOS.

$ARGUMENTS
