class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:show]
  before_action :move_to_index, only:[:edit, :update]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を変更しました"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :image, :introduction)
  end

  def move_to_index
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path, notice: "アクセス権限がありません"
    end
  end
end
