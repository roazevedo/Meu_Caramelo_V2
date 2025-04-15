class ChatroomsController < ApplicationController
  def create
    @animal = Animal.find(params[:animal_id])
    @chatroom = Chatroom.find_or_create_by(animal: @animal, user: current_user, user_owner: @animal.user_id)

    redirect_to chatroom_path(@chatroom)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
