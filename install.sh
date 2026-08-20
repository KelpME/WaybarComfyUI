#!/bin/bash

add_omarchy_module() {
  python3 - "$1" <<'PYEOF'
import json, os, sys
path = os.path.expanduser("~/.config/omarchy/shell.json")
entry = json.loads(sys.argv[1])
with open(path) as f:
    cfg = json.load(f)
right = cfg.setdefault("bar", {}).setdefault("layout", {}).setdefault("right", [])
right = [m for m in right if m.get("id") != entry["id"]]
right.append(entry)
cfg["bar"]["layout"]["right"] = right
with open(path, "w") as f:
    json.dump(cfg, f, indent=2)
    f.write("\n")
print(f"Added '{entry['id']}' module to ~/.config/omarchy/shell.json")
PYEOF
}

set -e

mkdir -p "$HOME/.local/bin"
install -m 755 waybar-comfyui-status waybar-comfyui-toggle "$HOME/.local/bin/"

add_omarchy_module "{\"id\":\"comfyui\",\"type\":\"command\",\"exec\":\"$HOME/.local/bin/waybar-comfyui-status\",\"interval\":5,\"onClick\":\"$HOME/.local/bin/waybar-comfyui-toggle\"}"

echo "Omarchy bar hot-reloads on save - no restart needed."