# frontend
## ディレクトリ構成

```text
IMANO/
├── App/              # アプリの起動・全体設定
├── Views/            # 画面UI
├── ViewModels/       # 画面の状態管理・処理
├── Models/           # アプリ内で扱うデータモデル
├── API/              # API通信に関する処理
│   └── Responses/    # APIレスポンスのデータ型
├── Services/         # 位置情報・天気・カレンダーなどの連携
├── Repositories/     # データの取得・保存処理
├── Persistence/      # SwiftDataなどのローカル保存処理
├── Components/       # 複数の画面で使用する共通UI
├── Widgets/          # ホーム画面ウィジェット
└── LiveActivities/   # ライブアクティビティ
```

※ 実際のディレクトリ構成は、開発の進行に合わせて調整する。

## 設計方針

- **SwiftUI**：画面UIの実装に使用する
- **MVVM**：ViewとViewModelを分けて実装する
- **Models**：アプリ内で扱うデータを定義する
- **API**：サーバーとの通信処理をまとめる
- **Services**：位置情報や天気など、外部機能との連携を担当する
- **Repositories**：データの取得元や保存先を扱う
- **Persistence**：SwiftDataなどを利用したローカルデータの保存を担当する

## 実装ルール

- Viewには、画面表示に関する処理を記述する
- ViewModelには、画面の状態管理や表示に必要な処理を記述する
- APIから受け取るデータの型と、アプリ内で扱うデータモデルは、必要に応じて分ける
- 複数の画面で共通して使用するUIはComponentsにまとめる
- 新しいフォルダやファイルを追加する際は、既存の役割分担に沿って配置する