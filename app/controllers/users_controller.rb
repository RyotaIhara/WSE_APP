class UsersController < ApplicationController
    #一覧表示
    def index
        @users = User.where(delete_flg: false)
    end

    #詳細
    def show
        @user = User.find(params[:id])
    end

    #新規作成フォーム
    def new
        @user = User.new
    end

    #編集フォーム
    def edit
        @user = User.find(params[:id])
    end

    #新規作成
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to :users, notice: "ユーザーを登録しました。"
        else
            render "new"
        end
    end

    #更新
    def update
        @user = User.find(params[:id])
        @user.assign_attributes(user_params)
        if @user.save
            redirect_to @user, notice: "ユーザーを更新しました"
        else
            render "edit"
        end
    end

    #削除
    def destroy
        @user = User.find(params[:id])
        @user.delete_flg = true
        if @user.save
            redirect_to @user, notice: "ユーザーを更新しました"
        else
            render "edit"
        end
    end

    #ストロングパラメーター
    private
    def user_params
      params.require(:user).permit(
          :name,
          :full_name,
          :email,
          :sex,
          :password,
          :password_confirmation,
          :administrator,
          :delete_flg,
        )
    end
end
