class User < ActiveRecord::Base

  validates :username, presence: { message: "用户名不能为空" }
  validates :username, uniqueness: { message: "用户名已存在" }
  validates :password, presence: { message: "密码不能为空" }
  validates :password, length: { minimum: 6, message: "密码长度最短为6位" }

  has_many :blogs
  has_many :public_blogs, -> { where(is_public: true) },
    class_name: "Blog"


  has_one :latest_blog,  -> { order("id desc") }, class_name: :Blog

end
