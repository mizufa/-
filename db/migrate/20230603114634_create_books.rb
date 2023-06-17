class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.integer :user_id #投稿したユーザを識別するID（users テーブルの id を保存する）。

      t.timestamps
    end
  end
end
