class UserMailer < ApplicationMailer
  def confirm_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to #{ENV['SITE_NAME']}")
  end

  def reset_password
    @user = params[:user]
    mail(to: @user.email, subject: "Reset your password for #{ENV['SITE_NAME']}")
  end
end
