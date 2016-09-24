class BlogsController < ApplicationController

  before_filter :auth_user, except: [:index, :show]

  def index
    @blogs = Blog.page(params[:page] || 1).per_page(params[:per_page] || 10).
      order("id desc").where(is_public: true)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.new(blog_attrs)
    if @blog.save
      update_tags

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

  def edit
    @blog = Blog.find params[:id]
    render action: :new
  end

  def update
    @blog = Blog.find params[:id]
    @blog.attributes = blog_attrs
    if @blog.save
      @blog.tags.destroy_all
      update_tags

      flash[:notice] = "博客更新成功"
      redirect_to blogs_path
    else
      flash[:notice] = "博客更新失败"
      render action: :new
    end
  end

  private
  def blog_attrs
    params.require(:blog).permit(:title, :content, :is_public)
  end

  def update_tags
    params[:tags].split(',').each do |tag|
      one_tag = Tag.find_by(title: tag)
      one_tag = Tag.new(title: tag) unless one_tag

      @blog.tags << one_tag
    end
  end

end
