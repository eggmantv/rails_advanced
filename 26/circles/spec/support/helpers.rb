module Helpers

  def create_user attrs = {}
    User.create({username: "test", password: "111111", password_confirmation: "111111"}.merge(attrs))
  end

  def signin_user user
    session[:user_id] = user.id
  end

end