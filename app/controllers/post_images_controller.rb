class PostImagesController < ApplicationController

  def new #投稿データ新規作成
    @post_image = PostImage.new
  end

  
  def create # 投稿データの保存 =>@post_image(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーの ID)に指定することで投稿データに、今ログイン中のユーザーの ID を持たせることができる。
    @post_image = PostImage.new(post_image_params) # 投稿するデータをPostImageモデルに紐づくデータとして保存する準備をしており、フォームに入力されるデータが、@post_imageに格納される。
    @post_image.user_id = current_user.id # PostImageモデルに紐づくカラムの値を取得したり、逆に値を代入することができる、、、current_user はログインユーザーの情報を取得することが可能
    @post_image.save
    redirect_to post_images_path
  end


  def index # 投稿データの取得
    @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new #コメント投稿機能を実装する為のインスタンス変数を定義 
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to "/post_images"
  end

  
  private # 投稿データのストロングパラメータ

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

end