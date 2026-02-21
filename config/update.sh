#!/usr/bin/env bash
set -e
FLAKE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
cd "$FLAKE_DIR" || exit 1

echo "Updating flake..."
nix flake update
echo "Updating nix-darwin..."
nh darwin switch .
echo "Update complete!"
