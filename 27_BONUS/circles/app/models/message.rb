class Message < ActiveRecord::Base

  validates :receiver_id, presence: { message: "收件人不能为空" }
  validates :sender_id, presence: { message: "发件人不能为空" }
  validates :content, presence: { message: "内容不能为空" }

  belongs_to :sender, class_name: :User
  belongs_to :receiver, class_name: :User

  attr_accessor :receiver_username

  validate :validate_username

  def is_read_to_s
    self.is_read ? "已读" : "未读"  
  end

  def receiver_username= username
    if user = User.find_by(username: username)
      self.receiver = user
    end
  end

  private
  def validate_username
    unless self.receiver
      self.errors.add(:receiver_username, "收件人不存在")
      false
    else
      true
    end
  end

end
