class BlogsController < ApplicationController

  before_filter :auth_user, except: [:index, :show]

  def index
    @blogs = Blog.page(params[:page] || 1).per_page(params[:per_page] || 10).
      order("id desc")
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.new(blog_attrs)
    if @blog.save
      flash[:notice] = "博客创建成功"
      redirect_to blogs_path
    else
      flash[:notice] = "博客创建失败"
      render action: :new
    end
  end

  def show
    @blog = Blog.find params[:id]
  end

  private
  def blog_attrs
    params.require(:blog).permit(:title, :content)
  end

end
