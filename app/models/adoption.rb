class Adoption < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  has_one :testimony, dependent: :destroy
end
