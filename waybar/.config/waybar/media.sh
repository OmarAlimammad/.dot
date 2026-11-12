#!/bin/bash
MAX=20
LAST_PID=0

escape_pango() {
    echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
}

# Emit waybar JSON: scrolling text, full title as tooltip
emit() {
    jq -cn --arg text "$(escape_pango "$1")" --arg tooltip "$(escape_pango "$2")" \
        '{text: $text, tooltip: $tooltip}'
}

# Clean up background processes if the main script exits
cleanup() {
    if [ "$LAST_PID" -ne 0 ]; then
        kill "$LAST_PID" 2>/dev/null
    fi
    exit 0
}
trap cleanup EXIT INT TERM

stdbuf -oL playerctl -p spotify metadata --format '{{title}} - {{artist}}' -F 2>/dev/null | while read -r NEW; do
    # Nuke the old background loop using its exact PID
    if [ "$LAST_PID" -ne 0 ]; then
        kill "$LAST_PID" 2>/dev/null
        wait "$LAST_PID" 2>/dev/null
        LAST_PID=0
    fi

    LEN=${#NEW}

    if [ $LEN -le $MAX ]; then
        emit "$NEW" "$NEW"
    else
        TEXT="$NEW    $NEW    "
        TOTAL_LEN=$((LEN + 4)) 
        
        # Spawn the loop and instantly capture its PID ($!)
        {
            POS=0
            while true; do
                RAW_CHUNK="${TEXT:$POS:$MAX}"
                emit "$RAW_CHUNK" "$NEW"
                POS=$(( (POS + 1) % TOTAL_LEN ))
                sleep 0.25
            done
        } &
        LAST_PID=$!
    fi
done
