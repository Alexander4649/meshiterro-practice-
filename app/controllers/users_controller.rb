class UsersController < ApplicationController
  def show#ユーザーの詳細ページ(マイページ)アクション
    @user = User.find(params[:id])# URLに記載されたIDを参考に、必要なUserモデルを取得する
    @post_images = @user.post_images# 特定のユーザ(@user)に関連付けされた投稿全て(.post_images)を取得し、@post_imagesに渡す　という処理、個人が投稿したもの全てを表示できるようになる
  end

  def edit #マイページの中の編集機能アクション
    @user = User.find(params[:id]) #特定のidを持ったレコードを取得する
  end
  
  def update
    @user = User.find(params[:id]) #ユーザーの取得
    @user.update(user_params) #ユーザーのアップデート
    redirect_to user_path #ユーザーの詳細ページへのパス  
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
