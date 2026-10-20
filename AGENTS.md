# AGENTS.md

AIコーディングエージェント（Claude Code、Codex など）向けの、このリポジトリの作業ガイドです。
人が読んでも分かるように書いています。

## プロジェクト概要

- IMANO の iOS フロントエンド（Swift / Xcode）
- TODO: アプリの概要、主要な画面や機能

## 開発環境

- TODO: Xcode のバージョン、対応する iOS の最低バージョン
- TODO: 依存管理（Swift Package Manager など）

## ビルド・テスト

- TODO: ビルドのコマンドやスキーム名
- TODO: テストの実行方法

## コーディング規約

- 既存のコードの書き方（命名、ファイル構成、コメントの量）に合わせる
- 設計のルールは [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)、名前は [docs/GLOSSARY.md](docs/GLOSSARY.md) に従う

## 参照ドキュメント

毎回読むのはこのファイルだけ。ほかは、作業に合わせて開く。

| ドキュメント | 答える問い | 読むとき | 更新するとき |
|---|---|---|---|
| [docs/STRUCTURE.md](docs/STRUCTURE.md) | 何がどこにあるか | 作業を始める前 | ファイルの追加・削除・移動・名前変更、役割の変更 |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | どう作るか、なぜそうするか | 新しいコードを書く前 | 設計の方針を変えたとき（先に decisions/ に記録する） |
| [docs/GLOSSARY.md](docs/GLOSSARY.md) | 何と呼ぶか | 型・変数・関数に名前を付ける前 | 新しい用語を作ったとき、名前を変えたとき |
| [docs/API.md](docs/API.md) | backend と何をやり取りするか | API を使うコードを書く前 | API の形が変わったとき |
| [docs/decisions/](docs/decisions/) | なぜそう決めたか | 既存の方針を変えたくなったとき | 方針を決めたとき、変えたとき |

- 更新は、コードの変更と**同じコミットで**する。docs だけを後回しにしない
- docs に書いていないことや、まだ TODO のことは、推測で埋めずに確認する
- docs と実際のコードがずれているのに気づいたら、その場で直す

## コードマップ（docs/STRUCTURE.md）

- [docs/STRUCTURE.md](docs/STRUCTURE.md) に、ディレクトリ構成、機能とファイルの対応、各ファイルの役割をまとめている
- 作業を始める前に読み、触るべきファイルを把握する
- 次の変更をしたときは、**同じコミットで** `docs/STRUCTURE.md` も更新する
  - ファイルやディレクトリの追加・削除・移動・名前変更
  - ファイルの役割や、機能とファイルの対応の変更
  - ファイル間の依存関係の大きな変更
- 実際の構成と `docs/STRUCTURE.md` がずれているのに気づいたら、その場で直す

## 作業ルール

- 変更は小さく、目的ごとに分ける
- 秘密情報（APIキー、証明書など）をコミットしない
- 迷ったら勝手に決めず、確認する
