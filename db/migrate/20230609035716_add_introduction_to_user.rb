class AddIntroductionToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduction, :text
  end
  #一意性の実装「add_index :テーブル名 :カラム名, unique: true」
  #モデルに「uniqueness: { case_sensitive: false }」を記述する。
end
