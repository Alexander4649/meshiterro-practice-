class PostComment < ApplicationRecord
  
  belongs_to :user# User、PostImageモデル共に関連付けられる(アソシエーション)のは1つの為、belongs_toを使用する。N:1の関係　逆はhas_manyを使用(1:Nの関係)
  belongs_to :post_image
  
end
