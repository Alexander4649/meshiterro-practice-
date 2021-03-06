class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_many :post_images, dependent: :destroy # アソシエーション(関連付け)1人のユーザーは複数の画像を投稿できる。1:Nの関係なので、has_manyを使用する。ユーザーが消えると画像も同時に消される。
         has_many :post_comments, dependent: :destroy# 同様に一人のユーザーは複数のコメントを行えるので1:Nの関係でアソシエーションをする。ユーザーが消えると、コメントも消される＝＞destroy
         has_many :favorites, dependent: :destroy
         
         has_one_attached :profile_image # profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定

  
 def get_profile_image(width,height)#  プロフィール画像が存在しない場合に表示する画像をActiveStorageに格納する (引数の)
    unless profile_image.attached?# ❶プロフィール画像がない時は
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg') # ❷ app/assets/imagesに格納されている nsample-author1.jpgという画像を
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg') # ❸デフォルト画像としてActiveStorageに格納し、格納した画像を表示する
    end
    profile_image.variant(resize_to_limit: [width, height]).processed #画像サイズの変更を指定。 画像を縦横共に引数で設定した値にサイズの変換するというコード
 end
end
