class UserMailer < ApplicationMailer
  def confirm_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to #{ENV['SITE_NAME']}")
  end
end
