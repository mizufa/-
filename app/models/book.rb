class Book < ApplicationRecord
  belongs_to :user #userに属する。

  #バリデーション設定
  validates :title, presence: true#, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 200 }
end
