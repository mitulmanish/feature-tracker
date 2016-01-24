class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy

  end

  def show

  end

  def set_user
    @user = User.find(params[:id])
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :admin)
  end

end
