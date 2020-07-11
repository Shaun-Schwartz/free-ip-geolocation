class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    binding.pry
    @user = User.create(email: params['email'], password: params['password'])
    session[:user_id] = @user.id
    redirect_to root_path
  end
end
