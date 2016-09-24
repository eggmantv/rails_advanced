class Friendship < ActiveRecord::Base

  validates :friend_id, uniqueness: { scope: [:user_id] }

  belongs_to :user
  belongs_to :friend, class_name: :User

end
