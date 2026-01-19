#!/bin/bash
curl -s -X POST "$2" -H "Host: $1" -H "X-Forwarded-Host: $1" -d "$3"
