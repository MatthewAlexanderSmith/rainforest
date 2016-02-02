class UsersController < ApplicationController
    before_action :load_user, only: [:show, :destroy]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_session_path, notice: "Signed Up! Please Log In."
    else
      render :new
    end

  end

  def show

  end



  def destroy
    @user.destroy!
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def load_user
    @user = User.find(params[:id])
  end


end
