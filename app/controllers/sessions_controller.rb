class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    render 'sessions/new'
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) && @user.confirmed?
       session[:user_id] = @user.id
       redirect_to root_path
    elsif @user && !@user.confirmed?
      flash[:warning] = 'Please confirm your email address before logging in.'
      redirect_to '/login'
    else
      flash[:warning] = 'Incorrect email or password.'
      redirect_to '/login'
    end
  end

  def destroy
    session.delete(:user_id) if session[:user_id]
    redirect_to root_path
  end
end
