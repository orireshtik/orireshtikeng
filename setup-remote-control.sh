#!/bin/bash
# Enable Remote Control for all Claude Code sessions on this machine

set -e

SETTINGS_FILE="$HOME/.claude/settings.json"

mkdir -p "$HOME/.claude"

if [ -f "$SETTINGS_FILE" ]; then
  # Update existing file
  if command -v python3 &>/dev/null; then
    python3 - <<'EOF'
import json, os
path = os.path.expanduser("~/.claude/settings.json")
with open(path) as f:
    s = json.load(f)
s["remoteControl"] = True
with open(path, "w") as f:
    json.dump(s, f, indent=2)
print("Updated ~/.claude/settings.json — Remote Control enabled.")
EOF
  else
    echo "python3 not found. Run: claude /config and enable 'Remote Control for all sessions'"
  fi
else
  echo '{ "remoteControl": true }' > "$SETTINGS_FILE"
  echo "Created ~/.claude/settings.json — Remote Control enabled."
fi

echo ""
echo "Done! Now run:  claude --remote-control"
echo "Or just:        claude     (Remote Control will start automatically)"
