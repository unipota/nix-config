# Nix-Darwin & Home Manager Configuration

このリポジトリは `nix-darwin` および `home-manager` を使用した macOS のシステム設定とユーザー環境を管理しています。

## 使い方

### 新規デバイスでのセットアップ（インストール手順）
新しい macOS デバイスで環境を構築する場合、以下の手順を実行します：

1. Nix のインストール
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
2. リポジトリのクローン
   ```bash
   mkdir -p ~/Workspace
   git clone https://github.com/unipota/nix-darwin.git ~/Workspace/nix-darwin
   ```
3. 初期ビルドの実行（※ホスト名がFlakeの定義と一致していることを確認）
   ```bash
   cd ~/Workspace/nix-darwin
   nix run nix-darwin -- switch --flake .
   ```

### 変更の適用（普段の運用）
設定ファイル（`.nix`）を編集した後、システムに変更を適用するには専用のアップデートスクリプトを使用します：

```bash
~/Workspace/nix-darwin/config/update.sh
```
※ このスクリプトは `nix flake update` および `nh darwin switch` を自動で実行します。

## ディレクトリ構成

*   **`flake.nix`**: 設定のエントリーポイント。`nix-darwin` と `home-manager` の統合を定義しています。
*   **`config/`**: 各種設定ファイルやヘルパースクリプト。
    *   `update.sh`: 設定適用のためのラッパースクリプト。
    *   `starship.toml`: Starship プロンプトの設定。
    *   `zshrc.sh`: Zsh の初期化スクリプト。
    *   `kanata.kbd`: Kanata のキーリマップ設定。
*   **`modules/darwin/`**: システム全体（macOS）の設定モジュール。
    *   `default.nix`: 他のシステムモジュールをインポート。
    *   `packages.nix`: システム全体にインストールする基本パッケージ。
    *   `homebrew.nix`: Homebrew (Casks, Formulas, Mac App Store) によるアプリ管理。
    *   `services.nix`: Launchd デーモンなどのシステムサービス（Kanata など）。
    *   `system.nix`: macOS のシステムデフォルト設定。
*   **`modules/home/`**: ユーザー固有の環境設定モジュール。
    *   `default.nix`: ユーザー（unipota）のパッケージ（Zsh, Neovim, 各種モダンCLIツール）、Dotfiles などの管理。

## 主な導入ツール

*   **モダン CLI ツール**: `fzf`, `ripgrep` (rg), `fd`, `jq`, `bat`, `eza`, `zoxide`, `btop`, `gh`, `fastfetch`
*   **開発環境**: `nodejs`, `pnpm`, `rustc`, `cargo`, `go`
*   **シェル**: Zsh + Oh-My-Zsh + Starship + 各種インテグレーション（Atuin, Carapace, Direnv）
*   **ターミナル**: Ghostty (Catppuccin Macchiato テーマ)

## キーボードリマッピング (Kanata)

`kanata` を使用して高度なキーボードカスタマイズを行っています。
設定リソースは `config/kanata.kbd` にあります。

**現在のマッピング:**
*   **Left/Right Command (タップ)**: IME 切り替え (左 -> 英数, 右 -> かな)。
*   **Left/Right Command (長押し)**: 通常の Command キーとして動作。
*   **CapsLock**: Control キーにマッピング。

**サービス管理:**
*   Kanata は Karabiner ドライバとやり取りするため、**System Daemon** (root 権限) として実行されます。
*   定義場所: `modules/darwin/services.nix`
*   **ログ**: `/var/log/kanata.err.log` および `/var/log/kanata.out.log`

**トラブルシューティング:**
もし Kanata が動作しなくなった場合は、以下を確認してください：
1.  **権限**: システム設定で `kanata` (または実行しているシェル) に「入力監視」の権限があるか確認してください。
2.  **ドライバ**: `Karabiner-Elements` がインストールされており、システム拡張機能が許可されているか確認してください。
3.  **ログ**: `/var/log/kanata.err.log` で権限エラーが出ていないか確認してください。
