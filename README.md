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

ファイル名は、型名または機能名を表す `PascalCase` を採用する。

### ファイル名

- 先頭は大文字
- 単語の区切りは大文字で表現する
- `snake_case` は使用しない
- 1 つのファイルには 1 つの主要型を置く

例：
```text
HomeView.swift
HomeViewModel.swift
WeatherService.swift
ScheduleResponse.swift
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

### 定数
定数は `lowerCamelCase` を基本とし、アプリ全体の設定値のみ `static let` を使って管理する。
## SwiftUI Viewの分割方針

### 基本方針
Viewは、可読性・再利用性・責務の独立性を考慮して分割する。細かく分割しすぎず、必要な単位で管理する。

### 分割ルール
- **画面単位：** 各画面の構成を管理するViewを作成する。
- **セクション単位：** 天気情報や予定一覧など、独立した役割を持つUIは必要に応じて別Viewに分割する。
- **再利用するUI：** 複数の画面で使用するUIは、共通Viewとして分割する。
- **分割の判断：** コードの行数だけで判断せず、役割のまとまりや読みやすさを基準にする。
- **過度な分割の回避：** 単純で小さなUIは、無理に別Viewに分割しない。

### Viewの責務
- **親View：** 画面全体のレイアウトと子Viewの配置を担当する。
- **子View：** 特定のUIの表示を担当する。原則として、画面全体の状態管理や他のセクションの制御は担当しない。

### データ・状態の受け渡し
- 子Viewに必要なデータは、原則としてイニシャライザの引数から受け取る。
- 状態は、原則としてその状態を必要とする範囲で管理する。
- 親Viewが管理する状態を子Viewから変更する必要がある場合は、`@Binding` などを使用する。
- Viewの分割に伴い、不要な状態やデータを重複して保持しない。

### 命名
- Viewの名前は、画面やUIの役割がわかる名前にする。
- Viewの型名には `View` を付ける。
- 例：`HomeView`、`WeatherSectionView`、`ScheduleSectionView`
## 状態管理の基本方針

### 基本方針
MVVMを採用し、View・ViewModel・Modelの責務を分離する。状態管理にはSwiftUI標準の機能を使用し、チーム内で実装方法を統一する。

### 1. Viewの状態管理
- View内だけで使用する一時的な状態には `@State` を使用する。
- 親Viewが所有する状態を子Viewから読み書きする場合は `@Binding` を使用する。
- 画面のデータや処理に関する状態は、原則としてViewModelで管理する。

### 2. ViewModelの実装
- ViewModelは `ObservableObject` に準拠したクラスとして実装する。
- Viewに反映する必要があるプロパティには `@Published` を使用する。
- ViewModelの命名は `〇〇ViewModel` とする。
- ViewModelには画面に関係する状態や処理を記述し、Viewのレイアウトに関するコードは記述しない。

### 3. ViewとViewModelの連携
- ViewModelをViewが所有する場合は `@StateObject` を使用する。
- 親Viewなどから渡された既存のViewModelを参照する場合は `@ObservedObject` を使用する。
- ViewModelの状態をViewから変更する必要がある場合は、適切なプロパティやメソッドを通じて変更する。
- 同じViewModelを複数のViewで使用する場合は、所有者を明確にする。

### 4. 状態管理の注意点
- 同じ情報を複数の場所で重複して管理しない。
- 非同期処理では、必要に応じて読み込み中・成功・失敗の状態を管理する。
- ViewModelからAPI通信やデータ保存などを行う場合は、必要に応じてServiceなどに処理を分離する。
- 状態管理の方法を追加・変更する場合は、チーム内で方針を確認する。
