# ⚙️ Configuration Files (`config/`)

このディレクトリには、システムやユーザー環境の各種設定ファイルとユーティリティスクリプトが含まれています。

## 📝 ファイル一覧

*   **`update.sh`**: Nix の Flake を更新し、`nh darwin switch .` を実行して設定を適用するラッパースクリプトです。
*   **`starship.toml`**: `Starship` クロスシェルプロンプト用のカスタム設定。モダンで情報量の多いプロンプトを提供します。
*   **`kanata.kbd`**: `Kanata` を使ったキーボードリマッピングの定義ファイルです。
    *   **左右 Command (タップ)**: IME 切り替え (英数 / かな)
    *   **左右 Command (長押し)**: 通常の Command キー動作
    *   **CapsLock**: Control キーへの入れ替え

これらのファイルは、`home-manager` や `nix-darwin` のモジュールから直接参照され、シンボリックリンクまたはファイル内容の埋め込みとしてシステムに適用されます。
