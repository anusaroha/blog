class UserMailer < ApplicationMailer
  default from: "anuragemailer@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: 'Password Reset')
  end

end
