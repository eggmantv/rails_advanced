require 'rails_helper'

RSpec.describe Message, type: :model do

  it '#save' do
    user = create_user
    message = user.inboxes.new(
      sender: user, 
      receiver: user, 
      content: "test message"
    )
    expect(message.valid?).to be true
  end
  
end
