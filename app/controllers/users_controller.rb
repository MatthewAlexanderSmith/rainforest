class UsersController < ApplicationController
    before_action :load_user, only: [:show, :destroy]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to products_url notice: "Signed Up!"
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
