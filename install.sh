#!/bin/bash
# BDK Install Script
# Usage: bash bilge-development-kit/install.sh [target-dir]

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-.}"

# Resolve target to absolute path
TARGET="$(cd "$TARGET" 2>/dev/null && pwd || echo "$TARGET")"

if [ ! -d "$TARGET" ]; then
  echo "Error: Target directory '$TARGET' does not exist."
  exit 1
fi

if [ "$SCRIPT_DIR" = "$TARGET" ]; then
  echo "Error: Target cannot be the BDK repo itself."
  exit 1
fi

# Check if .agent/ already exists
if [ -d "$TARGET/.agent" ]; then
  echo "Warning: $TARGET/.agent already exists."
  read -p "Overwrite? (y/N): " CONFIRM
  if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "Aborted."
    exit 0
  fi
  rm -rf "$TARGET/.agent"
fi

# Check if .claude/ already exists
if [ -d "$TARGET/.claude" ]; then
  echo "Warning: $TARGET/.claude already exists."
  read -p "Overwrite? (y/N): " CONFIRM
  if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "Skipping .claude/ (keeping existing)"
  else
    rm -rf "$TARGET/.claude"
    cp -r "$SCRIPT_DIR/.claude" "$TARGET/.claude"
    echo "  [+] .claude/ copied to project root"
  fi
else
  cp -r "$SCRIPT_DIR/.claude" "$TARGET/.claude"
  echo "  [+] .claude/ copied to project root"
fi

echo "Installing BDK to: $TARGET"
echo ""

# Copy .agent/ (main toolkit)
cp -r "$SCRIPT_DIR" "$TARGET/.agent"
echo "  [+] .agent/ copied"

# Remove nested .git if exists
rm -rf "$TARGET/.agent/.git"

# Remove install scripts from .agent/ (not needed inside project)
rm -f "$TARGET/.agent/install.sh"
rm -f "$TARGET/.agent/install.ps1"
echo "  [+] cleaned up"

echo ""
echo "BDK installed successfully!"
echo ""
echo "Next steps:"
echo "  1. cd $TARGET"
echo "  2. Run /onboard to initialize project context"
echo ""
