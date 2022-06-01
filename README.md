* [Start]...開始
* [Finish]...終了
* [Add]...追加
* [Update]...更新
* [Remove]...削除
* [Fix]...不具合修正
ーーーーーーーーーーーーーー
views/post_image/index.html.erb  部分テンプレート前の記述

<% @post_images.each do |post_image| %> <%#コントローラから渡された@post_images変数内から1つずつ取り出して、post_image変数へ格納します。 #%>

<div> <%#image_tagを使いpost_imageにActiveStorageで設定したimageを表示。post_image.get_imageの部分はPostImageモデル内に記述したメソッドを呼び出しています。#%>
  <%= link_to post_image_path(post_image.id) do %><%#ユーザー登録画像を押すとリンク設定したページに飛ぶよとゆうリンクコード#%>
    <%= image_tag post_image.get_image %><%#ユーザー登録画像の表示#%>
  <% end %>
  
  <p>投稿ユーザー画像：<%= image_tag post_image.user.get_profile_image(100,100) %></p>
  <!--  1. post_image.userで、投稿画像に紐づいたユーザーの情報(投稿したユーザーの情報)を取得できる
        2. 「.user」の部分でUserモデルを使用しているため、Userモデルに記述しているget_profile_imageメソッドが使えるようになる
        3. 結果、post_image.user.get_profile_imageと記述することで、投稿画像に紐づいたユーザーのプロフィール画像を表示できる -->
  
  <p>投稿ユーザー画像：<%= image_tag 'sample-author1.jpg' %></p> 
  <p>ショップ名：<%= post_image.shop_name %></p> <%# post_image変数のshop_nameカラムを表示します。 このカラムも、post_imageモデルに定義されています。#%>
  <p>説明：<%= post_image.caption %></p> <%#post_image変数のcaptionカラムを表示します。 このカラムも、post_imageモデルに定義されています。#%>
  <p>ユーザーネーム：<%= post_image.user.name %></p> <%# post_image変数のuser_idに関連付けられているuserモデルのnameカラムを表示します。post_imageモデルに定義されています。 #%>
  <p><%= link_to "#{post_image.post_comments.count} コメント", post_image_path(post_image.id) %></p><%#　コメント件数の表示 #%>
</div>
<% end %>

ーーーーーーーーーーー
ーーーーーーーーーーー
views/uesrs/show.html.erb  部分テンプレート前の記述

<!-- ユーザーの投稿一覧 -->

<% @post_images.each do |post_image| %>
<div>
  <%= link_to post_image_path(post_image.id) do %>
    <%= image_tag post_image.get_image %>
  <% end %>
  <p>投稿ユーザー画像：<%= image_tag post_image.user.get_profile_image(100,100) %></p>
  <p>ショップ名：<%= post_image.shop_name %></p>
  <p>説明：<%= post_image.caption %></p>
  <p>ユーザーネーム：<%= post_image.user.name %></p>
  <p><%= link_to "#{post_image.post_comments.count} コメント", post_image_path(post_image.id) %></p>
</div>

<% end %>
ーーーーーーーーーーー
ーーーーーーーーーーー
24章Bootstrapを導入ーヘッダーフッターを整えるーapp/views/layouts/のapplication.html.erbの元データ掲載

<!DOCTYPE html>
<html>
  <head>
    <title>Meshiterro</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
    <!--stylesheet_link_tagの場合cssファイルは、app/assets 配下のファイルを参照します。
        stylesheet_pack_tagの場合は、app/javascript 配下のファイルを参照するようになります。-->
  </head>

  <body>
    <header>
     <% if user_signed_in? %>
       <li>
        <%= link_to '投稿フォーム', new_post_image_path %>
       </li>
       <li>
         <%= link_to 'マイページ',user_path(current_user.id) %>
       </li>
      <li>
        <%= link_to "ログアウト", destroy_user_session_path, method: :delete %>
      </li>
     <% else %>
      <li>
        <%= link_to "新規登録", new_user_registration_path %>
      </li>
      <li>
        <%= link_to "ログイン", new_user_session_path %>
      </li>
     <% end %>
    </header>
   <%= yield %>
  </body>
</html>
ーーーーーーーーー
ーーーーーーーーー
投稿一覧は部分テンプレート化しているため_list.html.erbを編集前状態
Bootstrap適用前状態

<% post_images.each do |post_image| %>
<div>
  <%= link_to post_image_path(post_image.id) do %>
    <%= image_tag post_image.get_image %>
  <% end %>
  <p>投稿ユーザー画像：<%= image_tag post_image.user.get_profile_image(100,100) %></p>
  <p>ショップ名：<%= post_image.shop_name %></p>
  <p>説明：<%= post_image.caption %></p>
  <p>ユーザーネーム：<%= post_image.user.name %></p>
  <p><%= link_to "#{post_image.post_comments.count} コメント", post_image_path(post_image.id) %></p>
</div>
<% end %>

<%= paginate post_images %> <%#この部分テンプレートはユーザーの詳細画面と投稿画像の一覧画面で使われています#%>

ーーーーーーーーーー
ーーーーーーーーーー
投稿フォームを整える前の状態
app/views/post_images/のnew.html.erb

<h1>画像投稿フォーム</h1>

<!--バリデーション設定-->
 <% if @post_image.errors.any? %>
   <%= @post_image.errors.count %>件のエラーが発生しました
   <ul>
     <% @post_image.errors.full_messages.each do |message| %>
       <li><%= message %></li>
     <% end %>
   </ul>
 <% end %>

<!--投稿フォーム-->

  <%= form_with model: @post_image do |f| %>
    <h4>画像</h4>
      <%= f.file_field :image, accept: "image/*" %>
    <h4>ショップ名</h4>
      <%= f.text_field :shop_name %>
    <h4>説明</h4>
      <%= f.text_area :caption %>
    <%= f.submit '投稿' %>
  <% end %>
  
  ーーーーーーーーーーーーーーーー
  ーーーーーーーーーーーーーーーー