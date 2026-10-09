#!/usr/bin/env bash
# Installa la configurazione personale di Claude Code nella home dell'utente (idempotente).
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"
STAMP="$(date +%Y%m%d%H%M%S)"

mkdir -p "$DEST/skills"

# Copia CLAUDE.md salvando un backup se esiste già con contenuto diverso
if [ -f "$DEST/CLAUDE.md" ] && ! cmp -s "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"; then
  cp "$DEST/CLAUDE.md" "$DEST/CLAUDE.md.bak-$STAMP"
  echo "Backup creato: $DEST/CLAUDE.md.bak-$STAMP"
fi
cp "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"

# Copia le skill (sovrascrive solo quelle di questo repo)
for skill in "$SRC"/skills/*/; do
  name="$(basename "$skill")"
  mkdir -p "$DEST/skills/$name"
  cp -r "$skill". "$DEST/skills/$name/"
done

# Registra i server MCP a livello utente in ~/.claude.json (merge, senza toccare il resto)
CFG="$HOME/.claude.json"
[ -f "$CFG" ] && cp "$CFG" "$CFG.bak-$STAMP"
node -e '
const fs = require("fs");
const p = process.argv[1];
const cfg = fs.existsSync(p) ? JSON.parse(fs.readFileSync(p, "utf8")) : {};
cfg.mcpServers = cfg.mcpServers || {};
cfg.mcpServers.sapui5 = { type: "stdio", command: "npx", args: ["-y", "@ui5/mcp-server"], env: {} };
fs.writeFileSync(p, JSON.stringify(cfg, null, 2));
' "$CFG"

echo "Configurazione installata. Riavvia la sessione di Claude Code per applicarla."
