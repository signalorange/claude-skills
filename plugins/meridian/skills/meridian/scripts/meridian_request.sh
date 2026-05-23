#!/usr/bin/env bash
# meridian_request.sh — thin curl wrapper for the Meridian API.
#
# Usage:
#   ./meridian_request.sh METHOD /path [body-json-file]
#
# Required environment variables:
#   MERIDIAN_BASE_URL  — e.g. https://app.meridian.signalorange.com
#   MERIDIAN_API_KEY   — your personal Meridian API key (mer_...)
#
# Dependencies: curl (required), jq (optional, for pretty-printing)

set -euo pipefail

METHOD="${1:-}"
PATH_ARG="${2:-}"
BODY_FILE="${3:-}"

if [[ -z "$METHOD" || -z "$PATH_ARG" ]]; then
  echo "Usage: $(basename "$0") METHOD /path [body-json-file]" >&2
  exit 1
fi

if [[ -z "${MERIDIAN_BASE_URL:-}" ]]; then
  echo "Error: MERIDIAN_BASE_URL is not set." >&2
  exit 1
fi

if [[ -z "${MERIDIAN_API_KEY:-}" ]]; then
  echo "Error: MERIDIAN_API_KEY is not set." >&2
  exit 1
fi

BASE_URL="${MERIDIAN_BASE_URL%/}"
URL="${BASE_URL}${PATH_ARG}"

CURL_ARGS=(
  --silent
  --show-error
  --request "$METHOD"
  --header "Authorization: Bearer ${MERIDIAN_API_KEY}"
  --header "Content-Type: application/json"
  --header "Accept: application/json"
)

if [[ -n "$BODY_FILE" ]]; then
  if [[ ! -f "$BODY_FILE" ]]; then
    echo "Error: body file not found: $BODY_FILE" >&2
    exit 1
  fi
  CURL_ARGS+=(--data "@${BODY_FILE}")
fi

RESPONSE=$(curl "${CURL_ARGS[@]}" "$URL")

if command -v jq &>/dev/null; then
  echo "$RESPONSE" | jq .
else
  echo "$RESPONSE"
fi
