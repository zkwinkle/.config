#!/usr/bin/env python3
"""Set the Feishin theme's mode from its background luminance.

flavours templates can't tell light schemes from dark ones, so the template
always writes "dark" and this hook corrects it afterwards.
"""
import json
import sys
from pathlib import Path

path = Path(sys.argv[1]).expanduser()
theme = json.loads(path.read_text())
colors = theme["colors"]


def luminance(hex_color: str) -> float:
    def channel(c: int) -> float:
        c /= 255
        return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4

    r, g, b = (int(hex_color.lstrip("#")[i : i + 2], 16) for i in (0, 2, 4))
    return 0.2126 * channel(r) + 0.7152 * channel(g) + 0.0722 * channel(b)


light = luminance(colors["background"]) > 0.5
theme["mode"] = "light" if light else "dark"
if light:
    # In a light scheme base00 is the light end, so black/white come out swapped.
    colors["black"], colors["white"] = colors["white"], colors["black"]
    # Matches Feishin's built-in light theme.
    theme["mantineOverride"] = {"primaryShade": {"light": 4}}

path.write_text(json.dumps(theme, indent=4) + "\n")
