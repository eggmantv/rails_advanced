class BlogsTags < ActiveRecord::Base

  self.table_name = 'blogs_tags'

  validates_uniqueness_of :blog_id, scope: [:tag_id]

  belongs_to :blog
  belongs_to :tag

end