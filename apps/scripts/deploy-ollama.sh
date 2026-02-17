#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="llm"
RELEASE="ollama"

helm repo add ollama-helm https://helm.otwld.com >/dev/null 2>&1 || true
helm repo update >/dev/null

echo "$(pwd)"

kubectl apply -f ollama/manifests/namespace.yaml

helm upgrade --install "${RELEASE}" ollama-helm/ollama \
  --namespace "${NAMESPACE}" \
  --create-namespace \
  -f ollama/values/base.yaml \
  -f ollama/values/rpi.yaml

kubectl apply -f ollama/manifests/ingress.yaml
