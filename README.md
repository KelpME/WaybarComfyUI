# WaybarComfyUI

Waybar module that shows ComfyUI status on port 8188 and toggles the server on click. Built for the Omarchy Quattro bar (`~/.config/omarchy/shell.json`).

## What it does

- **○** — ComfyUI is stopped (nothing listening on port 8188)
- **🟢** — ComfyUI is running; the tooltip shows queue status, available models by category, and the active checkpoint
- **Click** — toggles the ComfyUI server (starts/stops via the `ComfyUI-Waybar` Makefile)

## Install

Run the installer:

```bash
./install.sh
```

This copies `waybar-comfyui-status` and `waybar-comfyui-toggle` to `~/.local/bin/` (with `chmod +x`) and adds the `comfyui` module to the `right` array of `bar.layout` in `~/.config/omarchy/shell.json`. The bar hot-reloads on save — no restart needed.

Or install manually: copy both scripts to `~/.local/bin/` and add this entry to the `right` array of `bar.layout` in `~/.config/omarchy/shell.json`:

```json
{"id":"comfyui","type":"command","exec":"$HOME/.local/bin/waybar-comfyui-status","interval":5,"onClick":"$HOME/.local/bin/waybar-comfyui-toggle"}
```

The module runs the status script every 5 seconds; the status script checks `http://localhost:8188` (default port, override with `--port`).