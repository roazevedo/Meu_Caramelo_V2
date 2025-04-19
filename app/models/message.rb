class Message < ApplicationRecord
  belongs_to :chatroom
  # belongs_to :user
  # belongs_to :animal

  validates :content, presence: true

  # Use broadcast_to em vez de broadcast_append_to
  after_create_commit -> {
    broadcast_update_to(
      chatroom,
      target: "messages_#{chatroom.id}",
      partial: "messages/messages",
      locals: { messages: chatroom.messages, current_user: chatroom.user }
    )
  }

  def date_of_send
    created_at&.strftime("%H:%M") || ""
  end
end
