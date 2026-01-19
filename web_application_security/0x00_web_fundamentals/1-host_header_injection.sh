#!/bin/bash
curl -s "$2" \
  -X POST \
  -H "Host: $1" \
  -H "X-Forwarded-Host: $1" \
  -d "$3"
