* [Start]...開始
* [Finish]...終了
* [Add]...追加
* [Update]...更新
* [Remove]...削除
* [Fix]...不具合修正

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