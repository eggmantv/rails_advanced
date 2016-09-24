class Blog < ActiveRecord::Base

  validates :title, presence: { message: "标题不能为空" }
  validates :content, presence: { message: "内容不能为空" }
  validates :user_id, presence: { message: "用户不能为空" }

  belongs_to :user
  has_many :blogs_tags, class_name: "BlogsTags"
  has_many :tags, through: :blogs_tags

end
