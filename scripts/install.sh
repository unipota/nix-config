#!/usr/bin/env bash

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/unipota/nix-config.git}"
TARGET_DIR="${TARGET_DIR:-$HOME/Workspace/nix-config}"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

detect_host_name() {
  local host_name=""

  if command_exists scutil; then
    host_name="$(scutil --get LocalHostName 2>/dev/null || true)"
  fi

  if [ -z "$host_name" ]; then
    host_name="$(hostname -s)"
  fi

  printf '%s\n' "$host_name"
}

ensure_host_config() {
  local host_name="$1"
  local host_dir="hosts/$host_name"
  local host_file="$host_dir/default.nix"

  if [ ! -f "$host_file" ]; then
    echo "=> Creating host configuration: $host_file"
    mkdir -p "$host_dir"

    cat >"$host_file" <<'EOF'
{ ... }:

{
  imports = [
    ../default
  ];
}
EOF
  else
    echo "=> Host configuration already exists: $host_file"
  fi

  if ! git ls-files --error-unmatch "$host_file" >/dev/null 2>&1; then
    # Flakes built from a Git working tree only see tracked files.
    git add "$host_file"
  fi
}

echo "=> Starting nix-config setup"

if ! command_exists nix; then
  echo "Nix is not installed. Install it first, then run this script again:"
  echo "  https://github.com/DeterminateSystems/nix-installer/releases"
  exit 1
fi

if ! command_exists git; then
  echo "git is required before this setup can clone nix-config."
  echo "Install Apple's Command Line Tools, then run this script again:"
  echo "  xcode-select --install"
  exit 1
fi

if [ -d "$TARGET_DIR/.git" ]; then
  echo "=> Updating existing repository: $TARGET_DIR"
  git -C "$TARGET_DIR" pull --ff-only origin main
elif [ -e "$TARGET_DIR" ]; then
  echo "$TARGET_DIR already exists but is not a Git repository." >&2
  echo "Move it aside or set TARGET_DIR to another path, then run this script again." >&2
  exit 1
else
  echo "=> Cloning repository: $TARGET_DIR"
  mkdir -p "$(dirname "$TARGET_DIR")"
  git clone "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"

HOST_NAME="${HOST_NAME:-$(detect_host_name)}"
echo "=> Using host configuration: $HOST_NAME"

ensure_host_config "$HOST_NAME"

echo "=> Applying nix-darwin configuration"
nix --extra-experimental-features "nix-command flakes" run github:LnL7/nix-darwin -- switch --flake ".#$HOST_NAME"

echo "=> Setup complete"
