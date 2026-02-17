#!/usr/bin/env bash
set -euo pipefail

HOST="rocketbyte-llm.duckdns.org"

curl -i "https://${HOST}/api/tags" | sed -n '1,30p'
echo
curl -s "https://${HOST}/api/tags" | grep -i qwen3 || true
