class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    render 'sessions/new'
  end

  def login
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
       sessions[:user_id] = @user.id
       redirect_to root_path
    else
       redirect_to '/login'
    end
  end

  def destroy
    session.delete(:user_id) if session[:user_id]
    redirect_to root_path
  end

  def welcome
  end

  def page_requires_login
  end
end
