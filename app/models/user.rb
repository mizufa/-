class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy #たくさんのbooksを持っている。1:Nの1側が削除されたとき、N側を全て削除する。

  has_one_attached :profile_image #profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定する記述。

  validates :name, presence: true, length: { maximum: 20, minimum: 2 }, uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 50 }

   def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
   end
end
