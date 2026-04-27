#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="$CODEX_HOME_DIR/skills/cliproxy-image-cli"

mkdir -p "$CODEX_HOME_DIR/skills"
rm -rf "$TARGET_DIR"
cp -R "$ROOT_DIR/skill_src/cliproxy-image-cli" "$TARGET_DIR"

echo "Installed cliproxy-image-cli skill to: $TARGET_DIR"
echo "Try: \$cliproxy-image-cli 画一张 SaaS 架构图，保存到当前目录"
