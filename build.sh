#!/bin/bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
TASK_DIR="$SCRIPT_DIR/Fortanix-Secret-Management"
VSS_EXTENSION="$SCRIPT_DIR/vss-extension.json"
TASK_JSON="$TASK_DIR/task.json"
handle_error() {
    echo "ERROR: $1"
    exit 1
}
cleanup() {
    # cleanup the node_modules and json files
    echo "cleanup the node_modules and json files"
    rm -rf "$SCRIPT_DIR/node_modules" "$SCRIPT_DIR/package.json" "$SCRIPT_DIR/package-lock.json" "$VSS_EXTENSION"
    rm -rf "$TASK_DIR/index.js" "$TASK_JSON" "$TASK_DIR/node_modules" "$TASK_DIR/package.json" "$TASK_DIR/package-lock.json"
}
trap cleanup EXIT
# Load environment variables
set -a
source "$SCRIPT_DIR/manifest.env"
set +a
echo "manifest.env is exported."
# check if npm is installed
if command -v npm >/dev/null 2>&1; then
  echo "npm is already installed at: $(which npm)"
else
  handle_error "npm not found. Please install it and try again."
fi
npm init -y >/dev/null
# check if tfx-cli is installed
if command -v tfx > /dev/null 2>&1; then
  echo "tfx is already installed globally."
elif npx --no-install tfx-cli --version >/dev/null 2>&1; then
  echo "tfx is already installed locally."
else
  echo "tfx not found — installing it locally"
  npm install --save-dev "tfx-cli@$TFX_CLI_VERSION"
  echo "tfx installed successfully."
fi
pushd "$TASK_DIR"
npm init -y >/dev/null
# Check if TypeScript compiler exists
if npx --no-install tsc --version > /dev/null 2>&1; then
  echo "tsc is already installed locally"
else
  echo "tsc not found — installing it locally"
  npm install --save-dev "typescript@$TYPE_SCRIPT_VERSION"
  echo "tsc installed successfully."
fi
# Check if Node compiler exists
if npm list @types/node >/dev/null 2>&1; then
  echo "types/node is already installed"
else
  echo "Installing types/node"
  npm install --save-dev "@types/node@$TYPE_NODE_VERSION"
  echo "types/node installed successfully."
fi
# Check if azure-pipelines-task-lib is installed
if npm list azure-pipelines-task-lib >/dev/null 2>&1; then
  echo "azure-pipelines-task-lib is already installed"
else
  echo "Installing azure-pipelines-task-lib"
  npm install --save-exact "azure-pipelines-task-lib@$AZURE_PIPELINES_VERSION"
  echo "azure-pipelines-task-lib installed successfully."
fi
# check if tsconfig.json exists
if [ ! -f tsconfig.json ]; then
  npx tsc --init
fi
# Compile the code
npx tsc
popd
echo "Build started"
# Replace placeholders in the  vss-extension.json
envsubst < "$SCRIPT_DIR/vss-extension.template.json" > "$VSS_EXTENSION"
[ -f "$VSS_EXTENSION" ] || handle_error "$VSS_EXTENSION was not created."
echo "$VSS_EXTENSION is created."
# Replace placeholders in the Fortanix-Secret-Management/task.json
envsubst < "$TASK_DIR/task.template.json" > "$TASK_JSON"
[ -f "$TASK_JSON" ] || handle_error "$TASK_JSON was not created."
echo "$TASK_JSON is created."
# build the extension
npx tfx extension create || handle_error "Extension packaging failed."