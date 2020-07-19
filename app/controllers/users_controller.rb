class UsersController < ApplicationController
  skip_before_action :authorized

  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params['email'])
    if passwords_dont_match?
      flash[:warning] = 'Password and password confirmation must match'
      redirect_back fallback_location: new_user_path
    else
      @user.update(password: params['password'])
      flash[:success] = 'Success! Please confirm your email address'
      redirect_to root_path
    end
  end

  def confirm
    confirmation_token = params[:token]
    email = Utils::Jwt.email_from_token(confirmation_token)
    user = User.find_by(email: email)
    if user && !user.confrimed?
      user.confirm!
      flash[:success] = 'Email has been confirmed!'
      redirect_to new_session_path
    elsif !user
      flash[:error] = "User can't be found. Please try signing up again."
      redirect_to root_path
    elsif user.confirmed?
      flash[:error] = 'Email address has already been confirmed.'
      redirect_to root_path
    else
      flash[:error] = 'Some has gone wrong. Please try again or feel free to contact us.'
      redirect_to root_path
    end
  end

  private
  def passwords_dont_match?
    params['password'] != params['confirm_password']
  end
end
