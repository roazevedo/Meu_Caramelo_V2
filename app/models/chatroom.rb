class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  has_many :messages, dependent: :destroy

  validates :user_id, uniqueness: { scope: :animal_id }

  def who_is_sender?
    @sender = current_user
    chatroom = Chatroom.find(params[:id])
    if @sender == chatroom.user
      return true
    else
      return false
    end
  end
end
