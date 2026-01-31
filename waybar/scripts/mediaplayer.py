#!/usr/bin/env python3
import subprocess
import json

def get_spotify_info():
    try:
        # Get metadata using playerctl
        artist = subprocess.check_output(["playerctl", "-p", "spotify", "metadata", "artist"]).decode("utf-8").strip()
        title = subprocess.check_output(["playerctl", "-p", "spotify", "metadata", "title"]).decode("utf-8").strip()

        # Truncate if too long
        display_text = f"{artist} - {title}"
        if len(display_text) > 30:
            display_text = display_text[:27] + "..."

        return {"text": display_text, "class": "custom-spotify"}
    except:
        return {"text": "", "class": "stopped"}

print(json.dumps(get_spotify_info()))
