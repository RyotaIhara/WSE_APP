Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #ルート
  root to: 'events#main'
  #ユーザー
  resources :users
  #イベント
  resources :events
  #ログイン機能
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
