#!/usr/bin/env bash
# install.sh - opencode-cyber-apex | 1 comando pra instalar o pack OFENSIVO SEM DESCULPAS
# Uso: curl -fsSL https://raw.githubusercontent.com/capivara-research/opencode-cyber-apex/main/install.sh | bash
#   ou: ./install.sh [--key cc_xxx] [--target ~/.config/opencode] [--with-agents]
set -euo pipefail

REPO="capivara-research/opencode-cyber-apex"
RAW="https://raw.githubusercontent.com/${REPO}/main"

# Cores
G="\033[32m"; Y="\033[33m"; R="\033[31m"; C="\033[36m"; B="\033[1m"; N="\033[0m"

KEY="${CODECRAFT_API_KEY:-}"
TARGET_CFG="${HOME}/.config/opencode"
TARGET_AGENTS="${HOME}/AGENTS.md"
DO_AGENTS=true

while [[ $# -gt 0 ]]; do
  case "$1" in
    --key) KEY="$2"; shift 2;;
    --target) TARGET_CFG="$2"; shift 2;;
    --no-agents) DO_AGENTS=false; shift;;
    -h|--help) echo "Uso: $0 [--key cc_xxx] [--target ~/.config/opencode] [--no-agents]"; exit 0;;
    *) echo -e "${R}Flag desconhecida: $1${N}"; exit 1;;
  esac
done

echo -e "${C}▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁${N}"
echo -e "${B} opencode-cyber-apex — MODO OPERADOR OFENSIVO${N}"
echo -e "${C} codecraft/claude-sonnet-5 | T=0.72 | Anthropic${N}"
echo -e "${C}▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔${N}"

need() { command -v "$1" >/dev/null 2>&1 || { echo -e "${R}Falta: $1${N}"; exit 1; }; }

# Detecta método de instalação
TMPDIR="$(mktemp -d)"; trap 'rm -rf "$TMPDIR"' EXIT

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  echo -e "${G}[+] ${N}Clonando via gh (privado)..."
  gh repo clone "$REPO" "$TMPDIR/pack" -- --depth 1 2>&1 | sed 's/^/    /'
  SRC="$TMPDIR/pack"
elif command -v git >/dev/null 2>&1; then
  echo -e "${Y}[!] ${N}gh não autenticado, tentando git clone via https..."
  if git clone "https://github.com/${REPO}.git" "$TMPDIR/pack" --depth 1 2>&1 | sed 's/^/    /'; then
    true
  else
    echo -e "${R}[✗] ${N}Repo é PRIVADO. Faça: ${B}gh auth login${N} e tente de novo."
    echo -e "    Ou: ${B}gh repo clone ${REPO} /tmp/pack -- --depth 1${N}"
    echo -e "    Fallback curl falhará (404) para repo privado sem token."
    exit 1
  fi
  SRC="$TMPDIR/pack"
else
  need curl
  echo -e "${Y}[*] ${N}Sem gh/git, baixando via curl..."
  mkdir -p "$TMPDIR/pack/.opencode/agent" "$TMPDIR/pack/.opencode/command"
  curl -fsSL "${RAW}/AGENTS.md" -o "$TMPDIR/pack/AGENTS.md"
  curl -fsSL "${RAW}/opencode.jsonc" -o "$TMPDIR/pack/opencode.jsonc"
  for f in cyber-apex.md cyber-recon.md; do curl -fsSL "${RAW}/.opencode/agent/${f}" -o "$TMPDIR/pack/.opencode/agent/${f}"; done
  for f in kill.md privesc.md enum-web.md flag.md; do curl -fsSL "${RAW}/.opencode/command/${f}" -o "$TMPDIR/pack/.opencode/command/${f}"; done
  SRC="$TMPDIR/pack"
fi

# Valida pack
[[ -f "$SRC/AGENTS.md" ]] || { echo -e "${R}AGENTS.md não encontrado em $SRC${N}"; exit 1; }
[[ -f "$SRC/opencode.jsonc" ]] || { echo -e "${R}opencode.jsonc não encontrado${N}"; exit 1; }

# Backup
TS="$(date +%Y%m%d_%H%M%S)"
mkdir -p "$TARGET_CFG"
if [[ -f "$TARGET_CFG/opencode.jsonc" ]]; then
  cp "$TARGET_CFG/opencode.jsonc" "$TARGET_CFG/opencode.jsonc.bak_${TS}"
  echo -e "${Y}[*] ${N}Backup: $TARGET_CFG/opencode.jsonc.bak_${TS}"
fi
if [[ -f "$TARGET_AGENTS" ]]; then
  cp "$TARGET_AGENTS" "${TARGET_AGENTS}.bak_${TS}"
  echo -e "${Y}[*] ${N}Backup: ${TARGET_AGENTS}.bak_${TS}"
fi
if [[ -f "./AGENTS.md" ]]; then
  cp "./AGENTS.md" "./AGENTS.md.bak_${TS}"
  echo -e "${Y}[*] ${N}Backup: ./AGENTS.md.bak_${TS}"
fi

# Instala AGENTS.md
if $DO_AGENTS; then
  cp "$SRC/AGENTS.md" "$TARGET_AGENTS"
  cp "$SRC/AGENTS.md" "./AGENTS.md" 2>/dev/null || true
  echo -e "${G}[+] ${N}AGENTS.md → $TARGET_AGENTS + ./AGENTS.md"
fi

# Instala opencode.jsonc (com key)
if [[ -n "$KEY" ]]; then
  sed "s|\${CODECRAFT_API_KEY:-cc_xxx}|${KEY}|g" "$SRC/opencode.jsonc" > "$TARGET_CFG/opencode.jsonc"
  echo -e "${G}[+] ${N}opencode.jsonc → $TARGET_CFG/opencode.jsonc (key injetada via --key / env)"
else
  cp "$SRC/opencode.jsonc" "$TARGET_CFG/opencode.jsonc"
  echo -e "${Y}[!] ${N}opencode.jsonc → $TARGET_CFG/opencode.jsonc (SEM KEY - placeholder)"
  echo -e "    ${Y}→ export CODECRAFT_API_KEY='cc_sua_key' && $0 --key \"\$CODECRAFT_API_KEY\"${N}"
  echo -e "    ${Y}→ ou edite manualmente: sed -i 's/cc_xxx/cc_sua_key/' $TARGET_CFG/opencode.jsonc${N}"
fi

# Instala agents/commands
mkdir -p "$TARGET_CFG/agent" "$TARGET_CFG/command"
cp -r "$SRC/.opencode/agent/"* "$TARGET_CFG/agent/" 2>/dev/null || true
cp -r "$SRC/.opencode/command/"* "$TARGET_CFG/command/" 2>/dev/null || true
echo -e "${G}[+] ${N}agents → $TARGET_CFG/agent/ (cyber-apex, cyber-recon)"
echo -e "${G}[+] ${N}commands → $TARGET_CFG/command/ (/kill, /privesc, /enum-web, /flag)"

# Validação
echo ""
echo -e "${C}━━━ Validação ━━━${N}"
python3 -c "import json; json.load(open('$TARGET_CFG/opencode.jsonc')); print('  ✓ opencode.jsonc JSON válido')" 2>&1 || echo -e "  ${R}✗ JSON inválido${N}"
grep -q "MODO OPERADOR OFENSIVO" "$TARGET_AGENTS" 2>/dev/null && echo "  ✓ AGENTS.md ofensivo ativo" || echo -e "  ${R}✗ AGENTS.md sem bloco ofensivo${N}"
[[ -f "$TARGET_CFG/agent/cyber-apex.md" ]] && echo "  ✓ cyber-apex.md" || echo -e "  ${R}✗ falta cyber-apex${N}"
if grep -q "cc_xxx\|\${CODECRAFT" "$TARGET_CFG/opencode.jsonc" 2>/dev/null; then
  echo -e "  ${Y}⚠ opencode.jsonc ainda com placeholder - injete a key antes de usar${N}"
else
  echo "  ✓ API key presente"
fi

echo ""
echo -e "${G}${B}✔ Instalação concluída!${N}"
echo -e "  ${C}→${N} Reinicie: ${B}opencode${N}"
echo -e "  ${C}→${N} Use: ${B}ctrl+p → cyber-apex${N}  ou  ${B}/kill 192.168.x.x${N}"
if grep -q "cc_xxx\|\${CODECRAFT" "$TARGET_CFG/opencode.jsonc" 2>/dev/null; then
  echo -e "  ${Y}→ Falta key:${N} ${B}CODECRAFT_API_KEY=cc_xxx $0 --key cc_xxx${N}"
fi
