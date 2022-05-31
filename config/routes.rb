  Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get "/homes/about" => "homes#about", as: "about"
  
  resources :post_images, only:[:new, :create, :index, :show,:destroy]do
  resources :post_comments, only: [:create, :destroy]# 親のresourcesで指定したコントローラ名に、子のresourcesで指定したコントローラ名が続くURLが生成されるのが確認できます。
                                           #このような親子関係を、「ネストする」と言います。
                                           #ネストしたURLを作成することでparams[:post_image_id]でPostImageのidが取得できるようになります。


  end
  
  
  resources :users, only:[:show, :edit, :update]
  
  
end