# STRUCTURE.md

このリポジトリのディレクトリ構成、機能とファイルの対応、各ファイルの役割をまとめたコードマップです。
AI エージェントは作業の前にこのファイルを読み、どこを触るべきかを把握してください。

> **常に最新に保つこと。** ファイルやディレクトリを追加・削除・移動・名前変更したとき、
> または役割が変わったときは、同じコミットでこのファイルも更新する（[AGENTS.md](../AGENTS.md) 参照）。
> `.gitignore` で除外されているファイルは載せない。
>
> **担当範囲**: ここには「何がどこにあるか」だけを書く。「どう作るか」のルールは [ARCHITECTURE.md](ARCHITECTURE.md) に書く。

最終更新: 2026-10-20

## ディレクトリ構成

```
frontend/
├── AGENTS.md              AI エージェント向けの作業ガイド
├── README.md              リポジトリの概要
├── .gitignore             Git の除外設定
├── .claude/
│   └── settings.json      Claude Code の設定（秘密情報を読ませない）
└── docs/
    ├── STRUCTURE.md       このファイル（コードマップ）
    ├── ARCHITECTURE.md    設計のルール
    ├── GLOSSARY.md        用語と、コード上の名前の対応表
    ├── API.md             backend とのやり取り
    └── decisions/         決めたことと理由の記録（ADR）
        ├── README.md
        └── 0001-record-decisions.md
```

## ディレクトリの役割

| ディレクトリ | 役割 |
|---|---|
| `/` | 設定ファイルとドキュメントの入口 |
| `.claude/` | Claude Code の設定 |
| `docs/` | 開発用ドキュメント |
| `docs/decisions/` | 決めたことと理由の記録（ADR）。1件1ファイル |

## 機能とファイルの対応

機能（画面、ドメイン、共通処理など）ごとに、関係するファイルをまとめる。
「この機能を直したいときはどこを見ればいいか」が分かるように書く。

| 機能 | 主なファイル | 説明 |
|---|---|---|
| （まだなし） | | |

## ファイル一覧

| パス | 役割 | 依存・関連 |
|---|---|---|
| `AGENTS.md` | AI エージェント向けの作業ガイド。ルールと、どの docs をいつ読むかの本体 | `docs/` 以下すべて |
| `README.md` | リポジトリの概要 | |
| `.gitignore` | Git の除外設定（Xcode、SwiftPM、CocoaPods、Carthage、fastlane、ローカルの AI 設定） | |
| `.claude/settings.json` | Claude Code の設定。秘密情報のファイルを読ませない deny ルールと sandbox | |
| `docs/STRUCTURE.md` | このファイル。構成と役割のコードマップ | `AGENTS.md`、`docs/ARCHITECTURE.md` |
| `docs/ARCHITECTURE.md` | 設計のルール。層の分け方、依存の向き、データの流れ | `docs/decisions/` |
| `docs/GLOSSARY.md` | IMANO の用語と、コード上の名前の対応表 | `docs/API.md` |
| `docs/API.md` | backend とのやり取り。エンドポイント、モデル、認証、エラー | `docs/GLOSSARY.md` |
| `docs/decisions/README.md` | ADR の書き方、テンプレート、一覧 | `docs/decisions/` 以下 |
| `docs/decisions/0001-record-decisions.md` | ADR で決定を記録すると決めたこと | `docs/ARCHITECTURE.md` |

## 書き方のルール

- **ディレクトリ構成**: ツリーで書く。ファイルが多いディレクトリは中身を省略し、「ディレクトリの役割」で説明する
- **機能とファイルの対応**: 機能を追加したら1行追加する。複数ディレクトリにまたがる機能は、関係するファイルを全部書く
- **ファイル一覧**: 1ファイル1行。役割は1文で書き、何をするファイルかが分かるようにする
- **依存・関連**: そのファイルを変えたときに一緒に確認すべきファイルを書く
- 生成ファイルやビルド成果物は載せない
- 更新したら「最終更新」の日付も変える
