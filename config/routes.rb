Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #ルート
  root to: 'events#main'
  get '/my_event' => 'events#myEvent'           #自分主催のイベント
  #ユーザー
  resources :users
  #イベント
  resources :events
  get 'search_event' => 'events#search'
  #ログイン機能
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
