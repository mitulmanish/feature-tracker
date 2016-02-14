class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :archive, :unarchive]
  def index
    #@users = User.all.each.reject(&:archived_at)
    @users = User.all
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
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update(users_params)
      flash[:notice] = "User has been updated"
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User could not be updated"
      render "edit"
    end
  end

  def destroy

  end

  def show

  end

  def set_user
    @user = User.find(params[:id])
  end

  def archive
    if @user == current_user
      flash[:alert] = "You can't archive yourself"
    else
      @user.archive
      flash[:notice] = "User has been archived"
    end
    redirect_to admin_users_path
  end

  def unarchive
    @user.unarchive
    flash[:notice] = "User has been un-archived"
    redirect_to admin_users_path
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :admin)
  end

end
