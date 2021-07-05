# Catter

Flutter & Firebase 製の猫の写真が投稿できるアプリ

* [iOS 版 App Store リンク](https://apps.apple.com/jp/app/catter/id1560456396) ※

※ Apple 側の問題で環境によって iOS 版 App Store リンクが 403 エラーを返すことが度々あります。その際は、iOS の App Store で「Catter」と検索するか、[Market with the App Store リンク](https://tools.applemediaservices.com/app/1560456396?country=jp) もご確認下さい。

| みんなの猫画面 | みんなの猫画面（コメント欄） | ランキング画面 | マイプロフィール画面 |
| --- | --- | --- | --- |
|![Simulator Screen Shot - iPhone 11 Pro Max - 2021-06-26 at 22 40 43](https://user-images.githubusercontent.com/69462712/124399914-bdbc6380-dd59-11eb-9db7-75c5c35be8d9.png)|![Simulator Screen Shot - iPhone 11 Pro Max - 2021-06-26 at 22 41 46](https://user-images.githubusercontent.com/69462712/124399924-c6149e80-dd59-11eb-96a6-98ef11e0e169.png)|![Simulator Screen Shot - iPhone 11 Pro Max - 2021-06-26 at 22 41 57](https://user-images.githubusercontent.com/69462712/124399926-c876f880-dd59-11eb-8c5c-95b6815feaeb.png)|![Simulator Screen Shot - iPhone 11 Pro Max - 2021-06-26 at 22 42 03](https://user-images.githubusercontent.com/69462712/124399928-cad95280-dd59-11eb-8cf2-335df34345d0.png)|

## Catterについて

「Catter」は、主たる開発者である [@EigoAkita](https://github.com/EigoAkita) が猫が大好きで、いろんな人が飼っている猫がタイムラインとして、見れたら良いなという思いから作成されたアプリです。

## 機能や実装内容の一覧

Flutter, Firebase, Firebase Authentication, Cloud Storage などを使用して、下記のようなアプリの各機能等の実装を行いました。

* アプリの UI の実装に必要な様々な Flutter ウィジェットの実装
* `Provider`, `ChangeNotifier` を用いた `Stateless` ウィジェットによる状態管理
* `development`, `production` の 2 つの Flavor と `debug`, `release` の 2 つのビルドモードに応じた各環境および Firebase プロジェクトで、 iOS, Android の両方のビルドを行うための環境構築
* 認証機能 (Firebase Authentication)
* 画像を含む猫の投稿, 更新, 削除機能
* 猫の写真のいいね機能
* 投稿する画像のトリミング・圧縮機能
* 猫の写真の無限スクロール機能
* コメント機能
* ユーザーの投稿切り替え機能
* 猫の写真の更新時などのバッチ処理の機能
* ログインしているユーザーの写真・名前変更機能