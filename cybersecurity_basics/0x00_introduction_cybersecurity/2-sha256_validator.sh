#!/bin/bash
hash=$(sha256sum "$1" 2>/dev/null | cut -d" " -f1)
[ "$hash" = "$2" ] && echo "$1: OK" || echo "$1: FAIL"