class PostImage < ApplicationRecord
   has_one_attached :image
   belongs_to :user #アソシエーション
   
   def get_image #特定の処理を名前で呼び出すメソッド、PostImageモデルの中に記述することでカラムを呼び出すようにこのメソッドを呼び出すことができる
      if image.attached?　　　　　　　　　　　　　　 # post_imageテーブルでIDが1のデータを持っていて、データから画像を表示させる場合の記述 
        image　　　　　　　　　　　　　　　　　　　　# @post_image = PostImage.find(1) : ID:1のレコードを取得し、@post_imageに格納する
      else                                           # @post_image.get_image :@post_imageに含まれるイメージを表示させるメソッドを実行する、インスタンス変数の後に"."をつけてその後にメソッドを繋げる
        'no_image.jpg'
      end
   end
   
   def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
   end
  
end
