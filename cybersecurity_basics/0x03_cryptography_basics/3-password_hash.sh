#!/bin/bash
echo -n "$1$openssl rand -base64 20" | sha512sum > 3_hash.txt