# ❄️ Nix-Config & Home Manager Configuration

このリポジトリは `nix-darwin` および `home-manager` を使用した macOS のシステム設定とユーザー環境を管理するための Dotfiles （構成リポジトリ）です。

## 📂 ディレクトリ構成

各ディレクトリの詳細な説明・導入しているツールについては、各ディレクトリ内の `README.md` を参照してください。

*   **[`flake.nix`](./flake.nix)**: 設定のエントリーポイント。`nix-darwin` と `home-manager` の統合を定義しています。
*   **[`config/`](./config/README.md)** ⚙️ : 各種設定ファイル（Starship, Kanata）やアップデート用ヘルパースクリプト。
*   **[`home/`](./home/README.md)** 🏠 : ユーザー（`unipota`）固有の環境設定や、パッケージ（CLIツール、開発環境、ターミナル）の管理。
*   **[`hosts/`](./hosts/README.md)** 🖥️ : システム全体（macOS）の構成。デフォルト設定、システムサービス（Kanataデーモンなど）、Homebrewの管理。

---

## 🚀 使い方

### 初回セットアップ（新規インストール手順）

新しい macOS デバイスで環境を構築する場合、以下の手順を実行します：

1. **Nix のインストール**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
2. **リポジトリのクローン**
   ```bash
   mkdir -p ~/Workspace
   git clone https://github.com/unipota/nix-config.git ~/Workspace/nix-config
   ```
3. **初期ビルドの実行**
   ```bash
   cd ~/Workspace/nix-config
   nix run nix-darwin -- switch --flake .
   ```

### 💻 新しい macOS デバイスを追加する場合

既存の設定をベースに、新しい Mac 用の設定を追加する手順は以下の通りです：

1. `hosts` ディレクトリ内に新しいホスト名でディレクトリを作成し、ベースにする設定をコピーします。
   ```bash
   cp -r hosts/macbook_air hosts/new_mac
   ```
2. `flake.nix` を編集し、`darwinConfigurations` に新しいデバイス名（例:`new_mac`）を追加します。
3. デバイスのホスト名を新しいデバイス名に合わせるか、実行時に指定します。`config/update.sh` は現在のマシンのホスト名と一致する設定を自動的に適用します。

### 🔄 変更の適用（普段の運用）

設定ファイル（`.nix`）を編集した後、システムに変更を適用するには専用のアップデートスクリプトを使用します：

```bash
~/Workspace/nix-config/config/update.sh
```
※ このスクリプトは `nix flake update` および `nh darwin switch .` を自動で実行します。
