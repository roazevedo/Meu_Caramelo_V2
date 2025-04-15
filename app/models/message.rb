class Message < ApplicationRecord
  belongs_to :chatroom
  # belongs_to :user
  # belongs_to :animal

  validates :content, presence: true
  
  def date_of_send
    created_at.strftime("%d/%m/%Y %H:%M")
  end
end
