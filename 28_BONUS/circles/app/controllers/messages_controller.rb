class MessagesController < ApplicationController
  
  before_filter :auth_user

  def index
    params[:type] ||= 'inbox'
    @messages = if params[:type] == 'inbox'
      current_user.inboxes
    else
      current_user.outboxes
    end
    
    @messages = @messages.page(params[:page] || 1)
      .per_page(params[:per_page] || 10)
      .order("id desc")
  end

  def new
    @message = current_user.outboxes.new
  end

  def create
    @message = current_user.outboxes.new(params.require(:message).permit!)
    if @message.save
      flash[:notice] = "发送成功"
      redirect_to messages_path
    else
      render action: :new
    end
  end

  def show
    @message = Message.find(params[:id])
    unless @message.sender == current_user or 
      @message.receiver == current_user
      render text: "403 Forbidden"
      return
    else
      if @message.receiver == current_user
        @message.update_attribute :is_read, true
      end
    end
  end

end
