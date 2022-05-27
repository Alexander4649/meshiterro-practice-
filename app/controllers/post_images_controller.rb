class PostImagesController < ApplicationController

  def new #投稿データ新規作成
    @post_image = PostImage.new
  end

  
  def create # 投稿データの保存
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
  end


  def index # 投稿データの取得
    @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
  end

  def destroy
  end

  
  
  private # 投稿データのストロングパラメータ

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

end