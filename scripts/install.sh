#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="$CODEX_HOME_DIR/skills/cliproxy-image-cli"
CLI_PATH="$TARGET_DIR/vendor/cliproxy-image-cli/bin/cliproxy-image-cli.js"

mkdir -p "$CODEX_HOME_DIR/skills"
rm -rf "$TARGET_DIR"
cp -R "$ROOT_DIR/skill_src/cliproxy-image-cli" "$TARGET_DIR"

if ! command -v node >/dev/null 2>&1; then
  echo "Installed skill to: $TARGET_DIR"
  echo "Warning: Node.js 18+ is required to run the vendored CLI, but node was not found in PATH." >&2
  exit 0
fi

node "$CLI_PATH" --help >/dev/null

echo "Installed cliproxy-image-cli skill to: $TARGET_DIR"
echo "Vendored CLI: $CLI_PATH"
echo "Try: \$cliproxy-image-cli 画一张 SaaS 架构图，保存到当前目录"
