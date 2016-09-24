class Tag < ActiveRecord::Base

  validates :title, uniqueness: { message: "标签已存在" }

  has_many :blogs_tags, class_name: "BlogsTags"
  has_many :blogs, through: :blogs_tags

end
