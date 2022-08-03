# Music Circle
<h3>様々な音楽に興味関心のあるユーザーが集まれる場所となるアプリケーション</h3>

# 概要
<h3>自分の興味のある音楽を共有できるプラットフォームの提供</h3>
<br>
<h5>レビューが様々なブログサイトで投稿されているが故に検索が非常に難しい</h5>
<h5>音楽レビューという点に特化させることで一つのプラットフォームで様々な視点やジャンルを探索できる</h5>

## App URL
<h3>https://music-circle.herokuapp.com/</h3>

## テスト用アカウント
- Email: test@test.mail
- Password: 1q1q1q

## 利用方法
- <h5>記事の閲覧は誰でも可能</h5>
- <h5>新規投稿とコメントを利用するにはトップページからのログイン・新規登録を行う</h5>
[![Image from Gyazo](https://i.gyazo.com/1ef7853fd1cf6be342f35e9186ee2808.gif)](https://gyazo.com/1ef7853fd1cf6be342f35e9186ee2808)
- <h5>新規投稿は一覧ページ右下の投稿ボタンからページに遷移する</h5>
[![Image from Gyazo](https://i.gyazo.com/1b524948c37cb01f86815ef2bd874393.gif)](https://gyazo.com/1b524948c37cb01f86815ef2bd874393)
- 記事投稿者であれば投稿した記事の編集・削除が可能
[![Image from Gyazo](https://i.gyazo.com/de5e2ff45c34b5f06655fef3e95e90f5.gif)](https://gyazo.com/de5e2ff45c34b5f06655fef3e95e90f5)
- <h5>コメントは記事詳細ページ下部のコメントフォームから行う</h5>
[![Image from Gyazo](https://i.gyazo.com/0f86b9b6550dbcda2a96456dd536b1a7.gif)](https://gyazo.com/0f86b9b6550dbcda2a96456dd536b1a7)
## 課題解決
| ユーザーストーリから考える課題    | 課題解決                                                 |
| ---------------------------- | ------------------------------------------------------- |
| 様々なサイトを行き来する必要がある | レビューサイトとして特化させる事で同じ目的で交流できる場所にする   |
| 場を乱す様なコメントに対応したい   | 記事作成者にもコメント削除権限を持たせる事で記事内の治安を保証する |

## 実装予定
- 外部APIを用いたバンド情報の紹介表示機能（著作権）
- 検索機能を実装予定

## ローカルでの動作方法
- git clone https://github.com/Cobo-chan/music_circle.git
- cd music_circle
- db:create
- db:migrate
- rails s  
👉 http://localhost:3000
# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| introduction       | text   |                           |

## Association
- has_many :articles
- has_many :comments


## articlesテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| title      | text       | null: false                    |
| genre_id   | integer    | null: false                    |
| country_id | integer    | null: false                    |
| text       | text       | null: false                    |
| user       | references | null: false, foreign_key: true |

## Association
- has_many :comments
- belongs_to :user

## commentsテーブル

| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| comment | text       | null: false |
| user    | references | null: false |
| article | references | null: false |

## Association
- belongs_to :user
- belongs_to :article