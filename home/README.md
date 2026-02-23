# 🏠 User Environment (`home/`)

このディレクトリは、`home-manager` を用いて管理される、ユーザー（現在は `unipota`）固有の環境設定や、パッケージのインストール定義を行っています。

## 📦 主な導入ツールと機能

*   **⚡️ モダン CLI ツール**: 
    *   `fzf` (あいまい検索)
    *   `ripgrep` (`rg`, 高速検索)
    *   `fd` (高速な `find` 代替)
    *   `jq` (JSON プロセッサ)
    *   `bat` (シンタックスハイライト付き `cat`)
    *   `eza` (モダンな `ls` 代替)
    *   `zoxide` (賢い `cd` 代替)
    *   `btop` (リソースモニター)
    *   `gh` (GitHub CLI)
    *   `fastfetch` (システム情報表示)
*   **🛠️ 開発環境**:
    *   `nodejs`, `pnpm`
    *   `rustc`, `cargo`
    *   `go`
*   **💻 シェルとターミナル**:
    *   `Zsh` + `Oh-My-Zsh`
    *   `Starship` (プロンプト)
    *   各種インテグレーション (`Atuin`, `Carapace`, `Direnv`)
    *   `Ghostty` (ターミナルエミュレータ - Nord テーマ適用済み)

## 📂 構成ファイル

*   `default.nix`: エントリーポイント。各プログラムやシェルの設定モジュールをインポートします。
*   `packages.nix`: ユーザー環境にインストールする CLI や依存関係の定義です。
*   `shell.nix`: Zsh やエイリアス、プロンプト周りの設定。
*   `programs/`: 各種アプリケーションごとの詳細設定 (例：`git.nix`, `cli.nix`, `ghostty.nix`)。
