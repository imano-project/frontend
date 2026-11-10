# ARCHITECTURE.md

このアプリを「どう作るか、なぜそうするか」をまとめた設計のルールです。
AI エージェントは、新しいコードを書く前にこのファイルを読み、ここにあるルールに従ってください。

> **担当範囲**: ここには層の分け方、依存の向き、データの流れなどの**ルール**だけを書く。
> 具体的なファイル名や「何がどこにあるか」は [STRUCTURE.md](STRUCTURE.md) に書く。
> 方針を変えたときは、[decisions/](decisions/) に理由を1件書いてから、このファイルを直す。

最終更新: 2026-11-10

> チームの開発ルールは [README.md](../README.md) にある。ここではそれを AI が守りやすい形にまとめ、README に書いていない現状を「現状」として書き足す。
> README と食い違ったら README を正とし、このファイルを直す。

## 採用するアーキテクチャ

- SwiftUI で画面を作り、View と ViewModel を分ける MVVM にする（README の「基本方針」）
- 理由: 初期段階の小規模アプリなので、開発の速さを保ちつつ保守しやすくするため（README の冒頭）
- 画面が少ないうちは、抽象化しすぎない
- TODO: この決定を decisions/ に ADR として記録する

## 層の分け方と依存の向き

| 層 | 役割 |
|---|---|
| View | 画面の描画と、ユーザーの入力の受け取り。ビジネスロジックやデータの取得は持たない |
| ViewModel | 画面の状態、読み込み中・エラーの状態、表示用のデータを持つ。Service などを呼ぶ |
| Model | アプリ内で扱うデータの型 |
| Service | OS のフレームワーク（位置情報、モーション、天気など）との連携 |
| Persistence | SwiftData などのローカル保存 |

- 依存は View → ViewModel → Service の向きにする。View から Service を直接呼ばない
- Model はどの層からも使ってよい
- README には API、Repositories、Components、Widgets、LiveActivities の層も予定として書かれているが、まだない。作るときは README の役割に従う
- 現状: 1つの画面が複数の機能を使うとき、画面の ViewModel が機能ごとの ViewModel を持ち、その値を Combine で受け取ってまとめている
- TODO: ViewModel が別の ViewModel を持つ形をルールにするか決める

## データの流れ

- 現状: Service が OS から値を受け取る → ViewModel の `@Published` の値を変える → View が描き直す
- 現状: Service から ViewModel へは、クロージャ（位置情報、モーション）か async/await（天気）で値を渡している
- TODO: backend との通信をどの層が担当するか（README では ViewModel が API の処理を呼ぶ。API の中身は [API.md](API.md)）

## 状態管理

- 一時的な表示の状態（入力中、アニメーション、メニューの開閉など）は View の `@State` に持つ
- 画面に表示するデータ、読み込み中、エラー、選択中のデータは ViewModel の `@Published` に持つ
- View が持つ ViewModel は `@StateObject`、親から渡された ViewModel は `@ObservedObject` で受ける
- 親の状態を子 View から変えるときは `@Binding` を使う
- 同じ情報を複数の場所で持たない
- 現状: ViewModel の `@Published` は `private(set)` にして、View からは読むだけにしている
- TODO: 画面をまたいで共有する状態の扱い

## 非同期処理

- 現状: クロージャで値を受け取る ViewModel は、`DispatchQueue.main.async` でメインスレッドに戻してから状態を変えている
- 現状: async/await を使う ViewModel には `@MainActor` を付けている
- 現状: 天気の取得は、新しい取得を始めたら古い取得を取り消し、古い結果で新しい結果を上書きしないようにしている
- TODO: `@MainActor` を付ける範囲と、クロージャと async/await のどちらにそろえるか

## エラー処理

- 非同期処理では、必要に応じて読み込み中・成功・失敗の状態を持つ（README の「状態管理の注意点」）
- 現状: エラーは ViewModel が `errorMessage`（文字列）として持ち、View がそのまま表示している
- TODO: エラーの型、ユーザーへの見せ方

## テスト

- 現状: テストのターゲットはまだない
- TODO: どの層をどうテストするか、テストの置き場所のルール

## 書き方のルール

- 1つの見出しには1つのテーマだけを書く
- ルールは「〜する」「〜しない」の形で書き、理由を1文添える
- 具体的なファイル名は書かない（STRUCTURE.md の担当）
- 決まっていないことは TODO のまま残し、推測で埋めない
- 更新したら「最終更新」の日付も変える
