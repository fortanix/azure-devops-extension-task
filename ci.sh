#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
MANIFEST_FILE="$SCRIPT_DIR/manifest.env"
BACKUP_FILE="$SCRIPT_DIR/manifest.env.ci.bak"

CI_ID="${ID:-12345678-1234-1234-1234-123456789012}"
CI_PUBLISHER_ID="${PUBLISHER_ID:-dummy-publisher}"

cleanup() {
  if [ -f "$BACKUP_FILE" ]; then
    mv "$BACKUP_FILE" "$MANIFEST_FILE"
  fi
}

trap cleanup EXIT

cp "$MANIFEST_FILE" "$BACKUP_FILE"

sed -i \
  -e "s|^ID=<Unique GUID identifier for your task>|ID=$CI_ID|" \
  -e "s|^PUBLISHER_ID=<Azure_DevOps_publisher_ID>|PUBLISHER_ID=$CI_PUBLISHER_ID|" \
  "$MANIFEST_FILE"

"$SCRIPT_DIR/build.sh"
