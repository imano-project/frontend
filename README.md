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

### 設計方針

- **SwiftUI**：画面UIの実装に使用する
- **MVVM**：ViewとViewModelを分けて実装する
- **Models**：アプリ内で扱うデータを定義する
- **API**：サーバーとの通信処理をまとめる
- **Services**：位置情報や天気など、外部機能との連携を担当する
- **Repositories**：データの取得元や保存先を扱う
- **Persistence**：SwiftDataなどを利用したローカルデータの保存を担当する

### 実装ルール

- Viewには、画面表示に関する処理を記述する
- ViewModelには、画面の状態管理や表示に必要な処理を記述する
- APIから受け取るデータの型と、アプリ内で扱うデータモデルは、必要に応じて分ける
- 複数の画面で共通して使用するUIはComponentsにまとめる
- 新しいフォルダやファイルを追加する際は、既存の役割分担に沿って配置する

## 命名ルール（Naming Convention）

ファイル名は、単語をアンダースコア（`_`）で区切る `snake_case` を採用する。

### ファイル名

- すべて小文字を使用する
- 複数の単語は `_` で区切る
- ファイル名から役割が分かるようにする

例：
```text
logo_dog.png
home_view.swift
home_view_model.swift
weather_service.swift
schedule_response.swift
```

### 変数名・関数名

Swiftの標準的な命名規則に従い、`lowerCamelCase` を使用する。

例：
```swift
let currentWeather: Weather
var isLoading: Bool

func fetchWeather()
func saveSchedule()
```

### 型名

クラス・構造体・列挙型・プロトコル名は `UpperCamelCase` を使用する。

例：
```swift
struct HomeView { }
class HomeViewModel { }
enum ScheduleType { }
```