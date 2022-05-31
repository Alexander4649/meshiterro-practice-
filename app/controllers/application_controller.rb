class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]#権限の設定ーログイン認証が成功していないと、トップページ以外の画面（ログインと新規登録は除く）は表示できない仕様
  #ログインしていない状態でトップページ以外のアクセスされた場合は、ログイン画面へリダイレクトするように設定
  #authenticate_userメソッドは、devise側が用意しているメソッドです。 :authenticate_user!とすることによって、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装
  #exceptは指定したアクションをbefore_actionの対象から外します。 Meshiterroではトップページのみログイン状態に関わらず、アクセス可能とするためにtopアクションを指定
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_actionメソッドは、このコントローラが動作する前に実行されます。

  def after_sign_in_path_for(resource) 
    post_images_path #ログイン後の遷移先を投稿画像の一覧画面に設定
  end
  
  def after_sign_out_path_for(resource)
    about_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end