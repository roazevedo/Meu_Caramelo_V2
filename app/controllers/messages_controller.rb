class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.sender = current_user.first_name # Garantir que o sender é o primeiro nome do usuário logado

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chatroom_path(@chatroom) }
      end
    else
      render 'chatrooms/show', alert: 'Message was not created.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :sender)
  end
end
