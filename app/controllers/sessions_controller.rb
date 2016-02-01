class SessionsController < ApplicationController
  skip_before_action :ensure_logged_in, except: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to products_url, notice: "Logged In!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to products_url, notice: "Logged Out!"
  end
end
