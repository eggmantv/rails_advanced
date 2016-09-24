require 'rails_helper'

describe User do

  context "#save" do
    it "should fail" do
      user = User.new(username: "test")
      expect(user.valid?).to be false
    end

    it "should fail with password invalid" do
      user = User.new(username: "test", password: "111111", password_confirmation: "222222")
      expect(user.valid?).to be false
      expect(user.errors.messages).to have_key(:password_confirmation)
    end

    it "should success" do
      user = User.new(username: "test", password: "111111", password_confirmation: "111111")
      expect(user.valid?).to be true
      expect(user.save).to be true
    end
  end

  it ".authenticate" do
    user = User.create(username: "test", password: "111111", password_confirmation: "111111")
    
    expect(User.authenticate('test', '111111')).not_to be nil
    expect(User.authenticate('test', '111111').id).to be user.id
  end

end