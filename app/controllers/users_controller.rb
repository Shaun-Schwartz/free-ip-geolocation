class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params['email'])
    if passwords_dont_match?
      flash[:error] = 'Password and password confirmation must match'
      redirect_back fallback_location: new_user_path
    else
      @user.update(password: params['password'])
      session[:user_id] = @user.id
      flash[:success] = 'Success! Please confirm your email address'
      redirect_to root_path
    end
  end

  private
  def passwords_dont_match?
    params['password'] != params['confirm_password']
  end
end
