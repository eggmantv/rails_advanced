class UsersController < ApplicationController

  before_filter :auth_user, only: [:index]

  def index
    @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order("id desc")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_attrs)
    if @user.save
      flash[:notice] = "注册成功，请登录"
      redirect_to new_session_path
    else
      render action: :new
    end
  end

  def blogs
    @blogs = current_user.blogs.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order("id desc")
  end

  def add_friend
    current_user.add_friend(User.find(params[:friend_id]))
    flash[:notice] = "添加好成功"
    redirect_to :back
  end

  def friends
    @friends = current_user.friends.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order("id desc")
  end

  private
  def user_attrs
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end