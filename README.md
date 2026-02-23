# ❄️ Nix-Config & Home Manager Configuration

このリポジトリは `nix-darwin` および `home-manager` を使用した macOS のシステム設定とユーザー環境を管理するための Dotfiles です。

## 📂 ディレクトリ構成

各ディレクトリの詳細な説明・導入しているツールについては、各ディレクトリ内の `README.md` を参照してください。

*   **[`flake.nix`](./flake.nix)**: 設定のエントリーポイント。`nix-darwin` と `home-manager` の統合を定義しています。
*   **`config/`** ⚙️ : 各種設定ファイル（Starship, Kanata）
*   **`scripts/`** 📜 : アップデートや初回セットアップ用のヘルパースクリプト。
*   **[`home/`](./home/README.md)** 🏠 : ユーザー（`unipota`）固有の環境設定や、パッケージ（CLIツール、開発環境、ターミナル）の管理。
*   **[`hosts/`](./hosts/README.md)** 🖥️ : システム全体（macOS）の構成。デフォルト設定、システムサービス（Kanataデーモンなど）、Homebrewの管理。

---

## 🚀 使い方

### 初回セットアップ（新規インストール手順）

新しい macOS デバイスで環境を構築する場合、以下の手順を実行します：

1. **Nix のインストール**
   macOS では GUI インストーラー（`.pkg`）からの導入が推奨されています。[Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer/releases) の最新リリースから macOS 用の `.pkg` をダウンロードしてインストールしてください。

2. **セットアップスクリプトの実行**
   ターミナルを開き、以下のコマンドを実行します。これにより、リポジトリのクローン・ホストごとの設定ディレクトリの自動生成・初期ビルドまでが一括で行われます。
   ```bash
   bash <(curl -sL https://raw.githubusercontent.com/unipota/nix-config/main/scripts/install.sh)
   ```

### 💻 新しい macOS デバイスを追加する場合

デバイスを追加する手順も初回セットアップと同一です。新しい Mac で前述のセットアップスクリプトを実行するだけで、現在のホスト名に基づいて新しい設定ディレクトリが自動で作成され、環境構築が完了します。

後からデバイス固有の設定を追加したい場合は、自動生成された `hosts/<ホスト名>/default.nix` を編集し、後述するアップデートスクリプトを実行してください。

### 🔄 変更の適用（普段の運用）

設定ファイル（`.nix`）を編集した後、システムに変更を適用するには専用のアップデートスクリプトを使用します：

```bash
~/Workspace/nix-config/scripts/update.sh
```
※ このスクリプトは `nix flake update` および `nh darwin switch .` を自動で実行します。
