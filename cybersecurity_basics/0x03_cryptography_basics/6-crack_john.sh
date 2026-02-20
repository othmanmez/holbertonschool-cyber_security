#!/bin/bash
john --wordlist=rockyou --format=sha256 "$1"
