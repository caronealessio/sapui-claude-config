# claude-config

Configurazione personale di Claude Code, da installare in ogni nuovo dev space.

- `CLAUDE.md`: regole generali caricate in ogni sessione
- `skills/coding-guidelines`: linee guida di scrittura del codice
- `install.sh`: copia i file in `~/.claude/` e registra il server MCP `sapui5` in `~/.claude.json`

## Uso

```bash
git clone <url-del-repo> && cd claude-config && ./install.sh
```

Lo script è idempotente e salva un backup dei file che sovrascrive. Richiede `node`.
Dopo aver modificato i file in `~/.claude/`, riportali qui e fai commit.
