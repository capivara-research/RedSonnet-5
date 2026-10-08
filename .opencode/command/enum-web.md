---
description: "Enumeração web ofensiva - ffuf + source + fuzz + validação manual"
agent: cyber-apex
---

# /enum-web - ENUM WEB OFENSIVO

Alvo web fornecido. Seja AGRESSIVO e VALIDE manualmente.

## FLUXO OBRIGATÓRIO
1. `whatweb http://$IP; curl -s -i http://$IP; curl -s http://$IP | html2text | head -n 100`
2. `ffuf -u http://$IP/FUZZ -w /usr/share/wordlists/dirb/common.txt -fc 404 -o ffuf.txt`
3. `gobuster dir -u http://$IP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x .php,.txt,.bak,.old,.zip`
4. Análise de source: robots.txt, sitemap, .git/, /backup, comentários HTML, JS
5. Fuzz de parâmetros: `ffuf -u "http://$IP/index.php?FUZZ=1" -w params.txt` + teste LFI/SQLi/SSTI/XSS

## ENTREGA
- Endpoints encontrados + status
- 3 hipóteses de vuln web (com evidência: erro, param, header, versão)
- Payload validável para hipótese #1 (ex: LFI `curl http://$IP/page.php?file=../../../../etc/passwd` ou SQLi `sqlmap` one-liner)
- O que observar na resposta + próximo teste

$ARGUMENTS
