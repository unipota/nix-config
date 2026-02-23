# 🖥️ System & Host Configurations (`hosts/`)

このディレクトリは、`nix-darwin` を使用して macOS システム全体の設定を管理します。各デバイス（Mac）ごとの固有の設定はサブディレクトリ内に配置されます。

## 🍏 ホスト設定と `default` テンプレート

ホスト構成は `hosts/default` テンプレートに共通設定がまとめられており、各デバイス（例: `macbook_air`）はそれを継承して構築されます。

*   **`default/`**: すべての Mac で共通して使用されるベース構成。
    *   **`packages.nix`**: システム全体（全ユーザー共通）で必要となる基本パッケージを定義します。
    *   **`system.nix`**: macOS 固有のシステム設定（`system.defaults`）を宣言的に管理します。
        *   例: Dock、Finder、キーボード、トラックパッドなどのシステム環境設定。
    *   **`homebrew.nix`**: GUI アプリケーション（Casks）、Homebrew のフォーミュラ、および Mac App Store アプリケーションのインストール管理を行います。
    *   **`services.nix`**: システムのバックグラウンドサービスや Launchd デーモンを管理します。
*   **`デバイス名/`** (例: `macbook_air/`): 各デバイス固有の構成。基本的に `../default` をインポートし、差分（デバイス特有の設定）のみを定義します。

## ⌨️ サービス: Kanata (キーボードリマップ)

`services.nix` には、高度なキーボードカスタマイズツールである `Kanata` のデーモン化設定が含まれています。

*   **動作要件**: Kanata は `Karabiner-Elements` のドライバを介して入力をフックするため、Root権限（System Daemon）で実行されます。
*   **定義ファイル**: キーマップ自体は `../config/kanata.kbd` に定義されています。
*   **トラブルシューティング**:
    *   動作しない場合は「入力監視」の権限を確認してください。
    *   ログ: 
        *   エラー: `/var/log/kanata.err.log`
        *   標準出力: `/var/log/kanata.out.log`
