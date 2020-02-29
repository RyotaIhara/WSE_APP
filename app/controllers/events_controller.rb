class EventsController < ApplicationController
    before_action :require_login, only: [:new, :myEvent, :edit, :create, :update, :destroy]

    #メイン画面
    def main
        @events = Event.all
        @homeEvents = Event.all
    end

    #一覧表示
    def index
        @events = Event.all
    end

    #検索
    def search
        @events = Event.where(['competition LIKE ? OR 
                                scheduled_date LIKE ? OR 
                                match_team LIKE ? OR 
                                place LIKE ? OR 
                                other_necessary LIKE ? OR
                                note LIKE ?', 
                                "%#{params[:search_key]}%", 
                                "%#{params[:search_key]}%",
                                "%#{params[:search_key]}%",
                                "%#{params[:search_key]}%",
                                "%#{params[:search_key]}%",
                                "%#{params[:search_key]}%"])
    end

    #自分主催のイベント
    def myEvent
        @events = Event.where(user_id: current_user.id)
    end

    #詳細
    def show
        @event = Event.find(params[:id])
    end

    #新規作成フォーム
    def new
        @event = Event.new
    end

    #編集フォーム
    def edit
        @event = Event.find(params[:id])
    end

    #新規作成
    def create
        @event = Event.new(event_params)
        @event.user_id = current_user.id
        if @event.save
            redirect_to @event, notice: "企画を登録しました。"
        else
            render "new"
        end
    end

    #更新
    def update
        @event = Event.find(params[:id])
        @event.assign_attributes(event_params)
        if @event.save
            redirect_to @event, notice: "企画を更新しました"
        else
            render "edit"
        end
    end

    #削除
    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to :my_event, notice: "企画を削除しました。"
    end

    #イベント中止
    def cancelEvent
        @event = Event.find(params[:id])
        @event.update(cancel_event_flg: true)
    end

    #イベント終了
    def endEvent
        @event = Event.find(params[:id])
        @event.update(end_event_flg: true)
    end

    #ストロングパラメーター
    private
    def event_params
        params.require(:event).permit(
        :competition,
        :scheduled_date, 
        :match_team, 
        :place, 
        :number_applicants, 
        :cost, 
        :other_necessary, 
        :note,
        :image
        )
    end

    private
    def require_login
        unless logged_in?
        flash[:error] = "ログインしてください"
        redirect_to login_path
        end
    end
end
