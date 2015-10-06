class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
    @messages = Message.where("receiver_id = ?", current_user.id)
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to products_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
