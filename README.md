# Nix-Darwin Configuration

このリポジトリは `nix-darwin` を使用した macOS のシステム設定を管理しています。

## 使い方

### 変更の適用
設定ファイルを編集した後、変更を適用するには以下のコマンドを実行してください：

```bash
darwin-rebuild switch --flake ~/.config/nix-darwin
```

## ディレクトリ構成

*   **`flake.nix`**: 設定のエントリーポイントです。
*   **`modules/`**: カテゴリ分けされた設定モジュールが含まれています。
    *   `default.nix`: 他のすべてのモジュールをインポートします。
    *   `packages.nix`: Nix 経由でシステム全体にインストールされるパッケージのリスト。
    *   `homebrew.nix`: Homebrew (Casks と Formulas) の設定。
    *   `services.nix`: システムサービスの設定 (Launchd agents/daemons)。
    *   `system.nix`: macOS のシステムデフォルト設定。
    *   `kanata.kbd`: Kanata の設定ファイル (キーボードリマッピング)。

## 主な機能

### キーボードリマッピング (Kanata)
`kanata` を使用して高度なキーボードカスタマイズを行っています。
設定リソースは `modules/kanata.kbd` にあります。

**現在のマッピング:**
*   **Left/Right Command (タップ)**: IME 切り替え (左 -> 英数, 右 -> かな)。
*   **Left/Right Command (長押し)**: 通常の Command キーとして動作。
*   **CapsLock**: Control キーにマッピング。

**サービス管理:**
*   Kanata は Karabiner ドライバとやり取りするため、**System Daemon** (root 権限) として実行されます。
*   定義場所: `modules/services.nix`
*   **ログ**: `/var/log/kanata.err.log` および `/var/log/kanata.out.log`

**トラブルシューティング:**
もし Kanata が動作しなくなった場合は、以下を確認してください：
1.  **権限**: システム設定で `kanata` (または実行しているシェル) に「入力監視」の権限があるか確認してください。
2.  **ドライバ**: `Karabiner-Elements` がインストールされており、システム拡張機能が許可されているか確認してください。
3.  **ログ**: `/var/log/kanata.err.log` で権限エラーが出ていないか確認してください。
