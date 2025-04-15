class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom

    if @message.save
      redirect_to chatroom_path(@chatroom), notice: 'Message was successfully created.'
    else
      render 'chatrooms/show', alert: 'Message was not created.'
    end
  end

    private

    def message_params
      params.require(:message).permit(:content)
    end
  end
