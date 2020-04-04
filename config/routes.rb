Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #ルート
  root to: 'events#main'
  get '/my_event' => 'events#myEvent'           #自分主催のイベント
  get '/applying_event' => 'events#applyingEvent'           #申し込み中のイベント
  #ユーザー
  resources :users
  #イベント
  resources :events, :except => :index
  get 'search_event' => 'events#search'
  #ログイン機能
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  # 参加機能
  get '/participant' => 'participants#participantEvent'              #イベント参加
  get '/non_participant' => 'participants#nonParticipationEvent'     #イベント参加キャンセル
  #参加者取得機能
  get '/participant_member' => 'participants#participantIndex'
  post '/confirm_participant' => 'participants#confirmEvent'
end
