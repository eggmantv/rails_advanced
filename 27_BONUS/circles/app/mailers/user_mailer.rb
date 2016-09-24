class UserMailer < ApplicationMailer

  def signup user
    @user = user
    mail to: @user.email, subject: "Welcome #{@user.username}"
  end

end
