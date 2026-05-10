# Nix-Config & Home Manager

`nix-darwin` と `home-manager` を用いた macOS 用 Dotfiles です。詳細は各ディレクトリの `README.md` を参照してください。

## 構成
- **[`flake.nix`](./flake.nix)**: エントリーポイント
- **`config/`**: 設定ファイル（Starship, Kanata）
- **`scripts/`**: セットアップと更新用スクリプト
- **[`home/`](./home/README.md)**: ユーザー環境・パッケージ
- **[`hosts/`](./hosts/README.md)**: Mac ごとのシステム構成・Homebrew

## 新規セットアップ

### 1. 事前準備

1. [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer/releases) の `.pkg` で Nix をインストールします。
2. `git` がない場合は `xcode-select --install` で Apple Command Line Tools を入れます。
3. Mac App Store アプリを入れる場合は、App Store にサインインしておきます。

### 2. 初回適用

以下を実行すると、リポジトリの clone、ホスト別設定の生成、初回の `nix-darwin switch` まで行います。

```bash
bash <(curl -sL https://raw.githubusercontent.com/unipota/nix-config/main/scripts/install.sh)
```

ホスト名は `scutil --get LocalHostName` を優先します。別名で作りたい場合は次のように指定できます。

```bash
HOST_NAME=macbookair bash <(curl -sL https://raw.githubusercontent.com/unipota/nix-config/main/scripts/install.sh)
```

## 日常運用

設定変更後は以下で適用します。

```bash
nh darwin switch
```

同じことは、リポジトリ付属の更新入口からも実行できます。

```bash
darwin-update
```

flake の入力を更新してから適用する場合:

```bash
darwin-update -- --update
```

ビルド確認だけ行う場合:

```bash
darwin-update -- --build
```

> 新しく作成した `.nix` ファイルは `git add` してから適用してください。Git 管理下の flake では、未追跡ファイルは Nix から見えません。

## トラブルシュート

- `Path ... is not tracked by Git` が出たら、表示されたファイルを `git add` します。
- `Missing host configuration` が出たら、`hosts/<ホスト名>/default.nix` があるか確認します。
- Homebrew / Mac App Store の適用で止まる場合は、Homebrew の初回セットアップや App Store ログイン状態を確認します。
