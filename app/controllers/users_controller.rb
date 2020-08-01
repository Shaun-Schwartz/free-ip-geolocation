class UsersController < ApplicationController
  skip_before_action :authorized
  before_action :find_user_from_token, only: [:confirm, :reset_password_form, :reset_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params['email'])
    if passwords_dont_match?
      flash[:warning] = t('user.passwords_must_match')
      redirect_back fallback_location: new_user_path
    else
      @user.update(password: params['password'])
      flash[:success] = 'Success! Please confirm your email address.'
      redirect_to root_path
    end
  end

  def confirm
    if @user && !@user.confirmed?
      @user.confirm!
      flash[:success] = 'Email has been confirmed!'
      redirect_to new_session_path
    elsif !@user
      flash[:error] = "User can't be found. Please try signing up again."
      redirect_to root_path
    elsif @user.confirmed?
      flash[:error] = 'Email address has already been confirmed.'
      redirect_to root_path
    else
      flash[:error] = t('something_went_wrong')
      redirect_to root_path
    end
  end

  def reset_password_request_form
    render 'users/auth/reset_password_request_form'
  end

  def reset_password_request
    @user = User.find_by(email: params['email'])
    if @user
      @user.create_confirmation_token_and_send_email
      flash[:success] = 'Please check your email.'
      redirect_to root_path
    else
      flash[:error] = t('something_went_wrong')
      redirect_to root_path
    end
  end

  def reset_password_form
    if @user
      render 'users/auth/reset_password'
    end
  end

  def reset_password
    if @user
      if passwords_dont_match?
        flash[:warning] = t('user.passwords_must_match')
        redirect_back fallback_location: login_path
      end
      if @user.reset_password(params['password'])
        flash[:success] = 'Success! Your password has been updated.'
        redirect_to root_path
      else
        flash[:error] = t('something_went_wrong')
        redirect_back fallback_location: login_path
      end
    end
  end

  private
  def passwords_dont_match?
    params['password'] != params['confirm_password']
  end

  def find_user_from_token
    begin
      confirmation_token = params[:token]
      email = Utils::Jwt.email_from_token(confirmation_token)
      @user = User.find_by(email: email)
    rescue JWT::ExpiredSignature
      flash[:error] = 'Token has expired.'
      redirect_to root_path
    end
  end
end
