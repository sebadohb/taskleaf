class Admin::UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :require_admin
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_url(@user), notice: "ユーザー「#{user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def show
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end



  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :admin,
      :password,
      :password_confirmation
    )
  end
  def set_params
    @user = User.find(params[:id])
  end
  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end
