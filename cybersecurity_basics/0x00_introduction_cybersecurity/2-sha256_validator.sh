#!/bin/bash
[ -n "$1" ] && [ -n "$2" ] && [ "$(sha256sum "$1" 2>/dev/null | cut -d ' ' -f1)" = "$2" ] && echo "$1: OK" || echo "$1: FAILLED"