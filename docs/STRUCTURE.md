# STRUCTURE.md

このリポジトリのディレクトリ構成、機能とファイルの対応、各ファイルの役割をまとめたコードマップです。
AI エージェントは作業の前にこのファイルを読み、どこを触るべきかを把握してください。

> **常に最新に保つこと。** ファイルやディレクトリを追加・削除・移動・名前変更したとき、
> または役割が変わったときは、同じコミットでこのファイルも更新する（[AGENTS.md](../AGENTS.md) 参照）。
> `.gitignore` で除外されているファイルは載せない。
>
> **担当範囲**: ここには「何がどこにあるか」だけを書く。「どう作るか」のルールは [ARCHITECTURE.md](ARCHITECTURE.md) に書く。

最終更新: 2026-11-10

## ディレクトリ構成

```
frontend/
├── AGENTS.md                  AI エージェント向けの作業ガイド
├── README.md                  チームの開発ルール（設計方針、命名、View の分割、状態管理）
├── .gitignore                 Git の除外設定
├── .github/
│   └── pull_request_template.md  PR の説明のテンプレート
├── .claude/
│   └── settings.json          Claude Code の設定（秘密情報を読ませない）
├── .codex/
│   └── config.toml            Codex の設定（秘密情報を読ませない）
├── docs/
│   ├── STRUCTURE.md           このファイル（コードマップ）
│   ├── ARCHITECTURE.md        設計のルール
│   ├── GLOSSARY.md            用語と、コード上の名前の対応表
│   ├── API.md                 backend とのやり取り
│   └── decisions/             決めたことと理由の記録（ADR）
│       ├── README.md
│       └── 0001-record-decisions.md
└── IMANO/
    ├── IMANO.xcodeproj/       Xcode のプロジェクト
    └── IMANO/                 アプリのソースコード
        ├── App/               アプリの起動
        │   └── IMANOApp.swift
        ├── Views/             画面の UI
        │   ├── MainTab/
        │   │   ├── MainTabView.swift
        │   │   └── TabItem.swift
        │   ├── Home/
        │   │   └── HomeView.swift
        │   ├── Rule/
        │   │   └── RuleView.swift
        │   └── Setting/
        │       └── SettingView.swift
        ├── ViewModels/        画面の状態と処理
        │   ├── HomeViewModel.swift
        │   ├── DateViewModel.swift
        │   ├── LocationViewModel.swift
        │   └── WeatherViewModel.swift
        ├── Models/            アプリ内で扱うデータ
        │   ├── LocationInfo.swift
        │   ├── MovementState.swift
        │   └── WeatherInfo.swift
        ├── Services/          OS の機能（日付、位置情報、モーション、天気）との連携
        │   ├── DateService.swift
        │   ├── LocationService.swift
        │   ├── MotionService.swift
        │   └── WeatherService.swift
        ├── Persistence/       SwiftData のローカル保存
        │   └── Item.swift
        ├── Designs/           デザインの定義
        │   └── Fonts/
        │       ├── AppFonts.swift
        │       └── Data/      フォントファイル（M PLUS Rounded 1c の 7 ウェイト）
        ├── Assets.xcassets/   色、画像、アプリアイコン
        │   ├── Colors/        色の定義（中身は「ディレクトリの役割」参照）
        │   └── Images/
        │       └── Navigation/  タブバーのアイコン
        ├── Info.plist         アプリに同梱するフォントの登録
        └── IMANO.entitlements WeatherKit の利用許可
```

## ディレクトリの役割

| ディレクトリ | 役割 |
|---|---|
| `/` | 設定ファイルとドキュメントの入口 |
| `.github/` | GitHub の設定（PR テンプレート） |
| `.claude/` | Claude Code の設定 |
| `.codex/` | Codex の設定 |
| `docs/` | 開発用ドキュメント |
| `docs/decisions/` | 決めたことと理由の記録（ADR）。1件1ファイル |
| `IMANO/IMANO.xcodeproj/` | Xcode のプロジェクト。ソースのフォルダはフォルダ同期（`fileSystemSynchronizedGroups`）で取り込むので、ファイルを足しても project.pbxproj は基本的に変わらない |
| `IMANO/IMANO/App/` | アプリの入口（`@main`）と、全体の設定 |
| `IMANO/IMANO/Views/` | 画面の UI。画面ごとにフォルダを分ける |
| `IMANO/IMANO/ViewModels/` | 画面の状態と処理（`ObservableObject`） |
| `IMANO/IMANO/Models/` | アプリ内で扱うデータの型 |
| `IMANO/IMANO/Services/` | OS のフレームワーク（Foundation、CoreLocation、CoreMotion、WeatherKit）を呼ぶ処理 |
| `IMANO/IMANO/Persistence/` | SwiftData のモデル |
| `IMANO/IMANO/Designs/` | フォントなど、デザインの共通定義 |
| `IMANO/IMANO/Designs/Fonts/Data/` | 同梱するフォントファイル（`MPLUSRounded1c-*.ttf`：Black、Bold、ExtraBold、Light、Medium、Regular、Thin） |
| `IMANO/IMANO/Assets.xcassets/Colors/` | 色の定義：`BackgroundColor`、`BlackButtonColor`、`Gray`、`IconColor`、`MainButtonColor`、`MainColor`、`TextColor` |
| `IMANO/IMANO/Assets.xcassets/Images/Navigation/` | タブバーのアイコン：`icon_home`、`icon_rule`、`icon_setting`（PDF） |

## 機能とファイルの対応

機能（画面、ドメイン、共通処理など）ごとに、関係するファイルをまとめる。
「この機能を直したいときはどこを見ればいいか」が分かるように書く。

| 機能 | 主なファイル | 説明 |
|---|---|---|
| アプリの起動 | `App/IMANOApp.swift` | `MainTabView` を表示し、SwiftData の `ModelContainer` を用意する |
| タブの切り替え | `Views/MainTab/MainTabView.swift`、`Views/MainTab/TabItem.swift`、`Assets.xcassets/Images/Navigation/` | ホーム・ルール・設定の 3 タブ |
| ホーム画面 | `Views/Home/HomeView.swift`、`ViewModels/HomeViewModel.swift` | 日付・時刻、位置情報、移動状態、天気を表示する。今は値を文字で並べているだけの仮の画面 |
| 日付・時刻 | `ViewModels/DateViewModel.swift`、`Services/DateService.swift` | 日本語の日付・時刻の文字を作り、毎分 0 秒に更新する。アプリが前面に戻ったときも更新する |
| 位置情報 | `ViewModels/LocationViewModel.swift`、`Services/LocationService.swift`、`Models/LocationInfo.swift`、`IMANO.xcodeproj/project.pbxproj`（`NSLocationWhenInUseUsageDescription`） | 使用中のみの許可を求め、起動時に 1 回取得する。100m 以上動いたときだけ値を更新する。取得に失敗したら再取得できる |
| 移動状態 | `Services/MotionService.swift`、`Models/MovementState.swift`、`ViewModels/LocationViewModel.swift`、`IMANO.xcodeproj/project.pbxproj`（`NSMotionUsageDescription`） | 止まっている・歩き・走り・自転車・車を判定し、止まっている間は位置情報の更新を止める |
| 天気 | `ViewModels/WeatherViewModel.swift`、`Services/WeatherService.swift`、`Models/WeatherInfo.swift`、`IMANO.entitlements` | 位置情報が更新されたら WeatherKit で現在の天気、今日の最高・最低気温、降水確率を取る |
| ルール画面 | `Views/Rule/RuleView.swift` | まだ中身のない仮の画面 |
| 設定画面 | `Views/Setting/SettingView.swift` | まだ中身のない仮の画面 |
| 色とフォント | `Assets.xcassets/Colors/`、`Designs/Fonts/AppFonts.swift`、`Designs/Fonts/Data/`、`Info.plist` | 色は Asset Catalog、フォントは `AppFonts` の定数で使う。まだ画面からは使っていない |
| ローカル保存 | `Persistence/Item.swift`、`App/IMANOApp.swift` | Xcode のテンプレートのまま。まだアプリの機能では使っていない |

## ファイル一覧

| パス | 役割 | 依存・関連 |
|---|---|---|
| `AGENTS.md` | AI エージェント向けの作業ガイド。ルールと、どの docs をいつ読むかの本体 | `docs/` 以下すべて |
| `README.md` | チームの開発ルール。MVVM の設計方針、ディレクトリ構成の予定、命名、View の分割、状態管理 | `docs/ARCHITECTURE.md` |
| `.gitignore` | Git の除外設定（macOS の `.DS_Store`、Xcode、SwiftPM、CocoaPods、Carthage、fastlane、ローカルの AI 設定、個人用のフォルダ `personal/`、秘密情報のファイル） | `.claude/settings.json`、`.codex/config.toml` |
| `.github/pull_request_template.md` | PR の説明のテンプレート（概要、関連 Issue、変更内容、動作確認、スクリーンショット、レビューポイント） | |
| `.claude/settings.json` | Claude Code の設定。秘密情報のファイルを読ませない deny ルールと sandbox | `.codex/config.toml` |
| `.codex/config.toml` | Codex の設定。sandbox の中のコマンドから秘密情報のファイルを読ませない permission profile | `.claude/settings.json` |
| `docs/STRUCTURE.md` | このファイル。構成と役割のコードマップ | `AGENTS.md`、`docs/ARCHITECTURE.md` |
| `docs/ARCHITECTURE.md` | 設計のルール。層の分け方、依存の向き、データの流れ | `README.md`、`docs/decisions/` |
| `docs/GLOSSARY.md` | IMANO の用語と、コード上の名前の対応表 | `docs/API.md` |
| `docs/API.md` | backend とのやり取り。エンドポイント、モデル、認証、エラー | `docs/GLOSSARY.md` |
| `docs/decisions/README.md` | ADR の書き方、テンプレート、一覧 | `docs/decisions/` 以下 |
| `docs/decisions/0001-record-decisions.md` | ADR で決定を記録すると決めたこと | `docs/ARCHITECTURE.md` |
| `IMANO/IMANO.xcodeproj/project.pbxproj` | Xcode のプロジェクト設定。iOS 26.0 以上、iPhone と iPad、位置情報とモーションの利用目的の文言（`INFOPLIST_KEY_*`） | `IMANO/IMANO/Info.plist`、`IMANO/IMANO/IMANO.entitlements` |
| `IMANO/IMANO/App/IMANOApp.swift` | アプリの入口。`MainTabView` を表示し、SwiftData の `ModelContainer` を作る | `Views/MainTab/MainTabView.swift`、`Persistence/Item.swift` |
| `IMANO/IMANO/Views/MainTab/MainTabView.swift` | ホーム・ルール・設定の 3 タブを並べる `TabView` | `Views/MainTab/TabItem.swift`、各画面の View |
| `IMANO/IMANO/Views/MainTab/TabItem.swift` | タブの種類と、タブの名前・アイコン名 | `Assets.xcassets/Images/Navigation/` |
| `IMANO/IMANO/Views/Home/HomeView.swift` | ホーム画面。日付・時刻、位置情報、移動状態、天気を表示し、画面表示時に監視を始める | `ViewModels/HomeViewModel.swift`、`ViewModels/DateViewModel.swift` |
| `IMANO/IMANO/Views/Rule/RuleView.swift` | ルール画面（仮） | |
| `IMANO/IMANO/Views/Setting/SettingView.swift` | 設定画面（仮） | |
| `IMANO/IMANO/ViewModels/HomeViewModel.swift` | ホーム画面の状態。`LocationViewModel` と `WeatherViewModel` の値を Combine で受け取ってまとめ、位置情報が変わったら天気を取りにいく | `ViewModels/LocationViewModel.swift`、`ViewModels/WeatherViewModel.swift` |
| `IMANO/IMANO/ViewModels/DateViewModel.swift` | 日付と時刻の文字を持ち、毎分 0 秒に更新する | `Services/DateService.swift` |
| `IMANO/IMANO/ViewModels/LocationViewModel.swift` | 位置情報の許可、現在地、エラー、移動状態を持つ。移動状態に合わせて位置情報の更新を始めたり止めたりする | `Services/LocationService.swift`、`Services/MotionService.swift`、`Models/LocationInfo.swift`、`Models/MovementState.swift` |
| `IMANO/IMANO/ViewModels/WeatherViewModel.swift` | 天気、取得中かどうか、エラーを持つ。新しい取得を始めたら古い取得を取り消す | `Services/WeatherService.swift`、`Models/WeatherInfo.swift` |
| `IMANO/IMANO/Models/LocationInfo.swift` | 緯度・経度・取得した時刻 | `ViewModels/LocationViewModel.swift` |
| `IMANO/IMANO/Models/MovementState.swift` | 移動状態（止まっている、歩き、走り、自転車、車、不明）と、動いているかどうか | `Services/MotionService.swift` |
| `IMANO/IMANO/Models/WeatherInfo.swift` | 気温、天気の説明、SF Symbols の名前、最高・最低気温、降水確率、更新時刻 | `Services/WeatherService.swift` |
| `IMANO/IMANO/Services/DateService.swift` | 日付（年月日と曜日）と時刻（時分）を日本語の文字にする | `ViewModels/DateViewModel.swift` |
| `IMANO/IMANO/Services/LocationService.swift` | `CLLocationManager` を包み、許可の変化・現在地・エラーをクロージャで知らせる。精度 100m、100m 動いたら通知 | `ViewModels/LocationViewModel.swift` |
| `IMANO/IMANO/Services/MotionService.swift` | `CMMotionActivityManager` で移動状態を監視し、クロージャで知らせる | `Models/MovementState.swift`、`ViewModels/LocationViewModel.swift` |
| `IMANO/IMANO/Services/WeatherService.swift` | WeatherKit で天気を取り、`WeatherInfo` にして返す | `Models/WeatherInfo.swift`、`IMANO.entitlements` |
| `IMANO/IMANO/Persistence/Item.swift` | SwiftData のモデル。Xcode のテンプレートのまま | `App/IMANOApp.swift` |
| `IMANO/IMANO/Designs/Fonts/AppFonts.swift` | 用途ごとのフォント（ボタン、見出し、本文、注釈）の定数 | `Designs/Fonts/Data/`、`Info.plist` |
| `IMANO/IMANO/Info.plist` | 同梱フォントの登録（`UIAppFonts`）。ほかの項目は project.pbxproj の `INFOPLIST_KEY_*` にある | `Designs/Fonts/Data/` |
| `IMANO/IMANO/IMANO.entitlements` | WeatherKit を使う許可 | `Services/WeatherService.swift` |

## 書き方のルール

- **ディレクトリ構成**: ツリーで書く。ファイルが多いディレクトリは中身を省略し、「ディレクトリの役割」で説明する
- **機能とファイルの対応**: 機能を追加したら1行追加する。複数ディレクトリにまたがる機能は、関係するファイルを全部書く
- **ファイル一覧**: 1ファイル1行。役割は1文で書き、何をするファイルかが分かるようにする
- **依存・関連**: そのファイルを変えたときに一緒に確認すべきファイルを書く
- Asset Catalog の `Contents.json` やフォントファイルのように、同じ種類のファイルが並ぶものは1件ずつ書かず、ディレクトリでまとめる
- 生成ファイルやビルド成果物は載せない
- 更新したら「最終更新」の日付も変える
