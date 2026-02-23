#!/usr/bin/env bash
set -e
FLAKE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
cd "$FLAKE_DIR" || exit 1

echo "Adding changes to Git..."
git add .

echo "Updating flake..."
nix flake update
echo "Updating nix-darwin..."
if command -v nh >/dev/null 2>&1; then
  nh darwin switch .
else
  echo "nh is not installed yet. Falling back to nix run nix-darwin..."
  nix run nix-darwin -- switch --flake .
fi
echo "Update complete!"
