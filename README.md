# ❄️ Nix-Config & Home Manager

`nix-darwin` と `home-manager` を用いた macOS 用 Dotfiles です。詳細は各ディレクトリの `README.md` を参照してください。

## 📂 構成
- **[`flake.nix`](./flake.nix)**: エントリーポイント
- **`config/`** ⚙️: 設定ファイル（Starship, Kanata）
- **`scripts/`** 📜: ヘルパースクリプト
- **[`home/`](./home/README.md)** 🏠: ユーザー環境・パッケージ
- **[`hosts/`](./hosts/README.md)** 🖥️: システム構成・Homebrew

## 🚀 使い方

### 1. 初回セットアップ / デバイス追加
[Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer/releases) の `.pkg` で Nix をインストール後、以下を実行します：

```bash
bash <(curl -sL https://raw.githubusercontent.com/unipota/nix-config/main/scripts/install.sh)
```
> ※クローンからホスト別設定の生成・ビルドまで自動で行われます。

### 2. 設定の適用
設定 (`.nix`) 変更後は以下でシステムに適用します：

```bash
nh darwin switch
```
> ※ `home/shell.nix` で `NH_FLAKE` が設定されているため、ディレクトリを移動せずに実行可能です。
> ※ flake を更新（`nix flake update` 相当）する場合は `nh darwin switch -u` を使用します。
> ※ **注意**: 新しく作成したファイルは `git add` してから実行してください（既存ファイルの変更はそのまま反映可能）。
