#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/update.sh [--update] [--build] [--host HOST]

Apply this nix-darwin flake for the current Mac.

Options:
  -u, --update     Update flake.lock before applying.
  -b, --build      Build only. Do not activate the result.
  -h, --host HOST  Use a specific darwinConfigurations host name.
  --help           Show this help.

Environment:
  FLAKE_DIR         Path to the editable nix-config repository.
EOF
}

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

script_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
repo_root="${FLAKE_DIR:-}"

if [ -z "$repo_root" ]; then
  if [ -d "$script_root/.git" ]; then
    repo_root="$script_root"
  else
    repo_root="${NH_FLAKE:-$HOME/Workspace/nix-config}"
  fi
fi

host_name="${HOST_NAME:-$(detect_host_name)}"
action="switch"
update_lock="false"

while [ "$#" -gt 0 ]; do
  case "$1" in
    -u | --update)
      update_lock="true"
      shift
      ;;
    -b | --build)
      action="build"
      shift
      ;;
    -h | --host)
      host_name="${2:-}"
      if [ -z "$host_name" ]; then
        echo "--host requires a value" >&2
        exit 2
      fi
      shift 2
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

cd "$repo_root"

if [ ! -d ".git" ]; then
  echo "Could not find the editable nix-config repository: $repo_root" >&2
  echo "Set FLAKE_DIR to the repository path and run again." >&2
  exit 1
fi

if [ ! -f "hosts/$host_name/default.nix" ]; then
  echo "Missing host configuration: hosts/$host_name/default.nix" >&2
  echo "Create it or run scripts/install.sh on the target Mac." >&2
  exit 1
fi

if ! git ls-files --error-unmatch "hosts/$host_name/default.nix" >/dev/null 2>&1; then
  echo "Host configuration exists but is not tracked by Git: hosts/$host_name/default.nix" >&2
  echo "Run: git add hosts/$host_name/default.nix" >&2
  exit 1
fi

if [ "$update_lock" = "true" ]; then
  nix flake update
fi

if command_exists nh; then
  if [ "$action" = "build" ]; then
    nh darwin build "$repo_root#$host_name"
  else
    nh darwin switch "$repo_root#$host_name"
  fi
else
  nix --extra-experimental-features "nix-command flakes" run github:LnL7/nix-darwin -- "$action" --flake "$repo_root#$host_name"
fi
