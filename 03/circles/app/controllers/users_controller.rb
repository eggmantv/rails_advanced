class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:subscribe).permit(:username, :password))
    if @user.save
      redirect_to new_session_path
    else
      flash[:notice] = "创建失败"
      render action: :new
    end
  end
end