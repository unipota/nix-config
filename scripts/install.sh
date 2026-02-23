#!/usr/bin/env bash

set -e

# リポジトリのURL
REPO_URL="https://github.com/unipota/nix-config.git"
# クローン先のディレクトリ
TARGET_DIR="$HOME/Workspace/nix-config"

echo "🚀 Starting nix-config initial setup..."

# 1. リポジトリのクローン・更新
if [ -d "$TARGET_DIR" ]; then
  echo "=> Repository already exists at $TARGET_DIR. Pulling latest changes..."
  cd "$TARGET_DIR"
  git pull origin main
else
  echo "=> Cloning repository to $TARGET_DIR..."
  mkdir -p "$HOME/Workspace"
  git clone "$REPO_URL" "$TARGET_DIR"
  cd "$TARGET_DIR"
fi

# 2. 現在のホスト名を取得
HOST_NAME=$(scutil --get LocalHostName)
if [ -z "$HOST_NAME" ]; then
  HOST_NAME=$(hostname -s)
fi

echo "=> Current HostName is: $HOST_NAME"

# 3. ホスト用ディレクトリと初期設定ファイルの作成
HOST_DIR="hosts/$HOST_NAME"
if [ ! -d "$HOST_DIR" ]; then
  echo "=> Creating new host configuration directory: $HOST_DIR"
  mkdir -p "$HOST_DIR"
  
  # default.nix を生成
  cat << 'EOF' > "$HOST_DIR/default.nix"
{ ... }:

{
  imports = [
    ../default
  ];
}
EOF
  echo "=> Initialized basic configuration for $HOST_NAME"
else
  echo "=> Host configuration for $HOST_NAME already exists. Skipping creation."
fi

# 4. アップデートスクリプトに実行権限を付与して実行
echo "=> Running initial build via scripts/update.sh..."
chmod +x scripts/update.sh
./scripts/update.sh

echo "✅ Setup complete!"
