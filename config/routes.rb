Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #ルート
  root to: 'events#main'
  #ユーザー
  resources :users
  #イベント
  resources :events
end
