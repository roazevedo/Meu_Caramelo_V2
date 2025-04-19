class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  has_many :messages, dependent: :destroy

  validates :user_id, uniqueness: { scope: :animal_id }
end
