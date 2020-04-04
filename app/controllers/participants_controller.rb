class ParticipantsController < ApplicationController
  before_action :require_login, only: [:participantEvent, :nonParticipationEvent, :confirmEvent]

  #参加登録
  def participantEvent
    @participants = Participant.new
    @participants.event_id = params[:event_id]
    @participants.user_id = current_user.id
    if @participants.save
      redirect_to :applying_event_path, notice: "企画に参加登録しました。"
    else
      redirect_to :applying_event_path, notice: "予期せぬエラーが発生しました。"
    end
  end

  #不参加
  def nonParticipationEvent
    @participants = Participant.find_by(event_id: params[:event_id], user_id: current_user.id)
    @participantsForEdit = Participant.find(@participants.id)
    @participantsForEdit.update(non_participation_flg: true)
    redirect_to :applying_event_path, notice: "企画への参加をキャンセルしました。"
  end

  #参加者一覧取得
  def participantIndex
    @participants = Participant.where(event_id: params[:event_id])
  end

  #イベント参加確定
  #def confirmEvent
  #  logger.debug("メソッドが動きました。")
  #  logger.debug(params[:participated_flg])
  #  redirect_to :my_event, notice: "企画への参加をキャンセルしました。"
  #end

  private
  def require_login
      unless logged_in?
      flash[:error] = "ログインしてください"
      redirect_to login_path
      end
  end
end
