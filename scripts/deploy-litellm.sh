#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="llm"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFESTS_DIR="${SCRIPT_DIR}/../apps/litellm/manifests"

echo "Deploying LiteLLM to namespace: ${NAMESPACE}"

# Namespace already exists (managed by ollama deploy)
kubectl apply -f "${MANIFESTS_DIR}/secret.yaml"
kubectl apply -f "${MANIFESTS_DIR}/configmap.yaml"
kubectl apply -f "${MANIFESTS_DIR}/deployment.yaml"
kubectl apply -f "${MANIFESTS_DIR}/service.yaml"

echo "Waiting for LiteLLM rollout..."
kubectl rollout status deployment/litellm -n "${NAMESPACE}" --timeout=120s

echo "LiteLLM is up at: http://litellm.llm.svc.cluster.local:4000/v1"
echo "Admin UI:         http://<node-ip>:4000/ui  (login with master key from secret.yaml)"
