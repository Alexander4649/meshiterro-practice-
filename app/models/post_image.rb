class PostImage < ApplicationRecord
   has_one_attached :image
   belongs_to :user #アソシエーション
   has_many :post_comments, dependent: :destroy# 投稿された画像に対して複数のコメントを持つことができる為、1:Nの関係になりhas_manyを使用する。
   has_many :favorites, dependent: :destroy# 投稿された画像に対して複数のイイね！を持つことができる為、1:Nの関係になりhas_manyを使用する。
   
   def get_image #特定の処理を名前で呼び出すメソッド、PostImageモデルの中に記述することでカラムを呼び出すようにこのメソッドを呼び出すことができる
      if image.attached?　　　　　　　　　　　　　　 # post_imageテーブルでIDが1のデータを持っていて、データから画像を表示させる場合の記述 
        image　　　　　　　　　　　　　　　　　　　　# @post_image = PostImage.find(1) : ID:1のレコードを取得し、@post_imageに格納する
      else                                           # @post_image.get_image :@post_imageに含まれるイメージを表示させるメソッドを実行する、インスタンス変数の後に"."をつけてその後にメソッドを繋げる
        'no_image.jpg'
      end
   end
   
   def get_image # 画像が存在しない場合に表示する画像をActiveStorageに格納する
    unless image.attached? # ❶画像がない時は
      file_path = Rails.root.join('app/assets/images/no_image.jpg') # ❷ app/assets/imagesに格納されている no_images.jpgという画像を
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg') # ❸デフォルト画像としてActiveStorageに格納し、格納した画像を表示する
    end
    image
   end
   
   def favorited_by?(user) #引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。 存在していればtrue、存在していなければfalseを返すようにしています。
    favorites.exists?(user_id: user.id)
   end
  
end
