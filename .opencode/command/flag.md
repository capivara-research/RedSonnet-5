---
description: "Caça à FLAG - varre proof.txt e flags após comprometer alvo"
agent: cyber-apex
---

# /flag - CAÇA À FLAG

Você comprometeu o alvo. Agora busque a FLAG sem parar.

```bash
cat /root/proof.txt 2>/dev/null; cat /root/flag.txt 2>/dev/null; cat /flag.txt 2>/dev/null
cat /home/*/flag.txt 2>/dev/null; cat /home/*/proof.txt 2>/dev/null; ls -la /root/ /home/*/
find / -name "*flag*" -o -name "*proof*" 2>/dev/null | head -20
id; hostname; ip a
```

Se encontrar credencial/token novo, RE-ENUMERE do zero e tente pivot.

$ARGUMENTS
