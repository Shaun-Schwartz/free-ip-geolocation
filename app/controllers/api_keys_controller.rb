class ApiKeysController < ApplicationController

  def index
    @api_keys = current_user.api_keys
    flash[:warning] = 'No api keys found.' if @api_keys.empty?
    render 'api_keys/show'
  end

  def new
  end

  def create
    if current_user
      if ApiKey.create_new(current_user)
        flash[:success] = 'Success! API key has been created.'
        redirect_to api_keys_path
      end
    end
  end
end
