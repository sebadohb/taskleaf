
#📜 TASKLEAF









# テーブル設計

## users テーブル

| Column            | Type    | Options                      |
| ----------------- | ------  | -----------------------------|
| email             | string  | null: false                  |
| password_digest   | string  | null: false                  |
| name              | string  | null: false                  |
| admin             | boolean | null: false                  |
| task_id           | integer | null: false, unique: true    |

 ### Association
 - has_many : tasks


## tasks テーブル

| Column      | Type         | Options                         |
| ----------  | ------------ | ------------------------------- |
| name        | string       | null: false                     |
| description | string       |                                 |
| user_id     | integer      | null: false                     |

 ## Association
- belongs to :user
