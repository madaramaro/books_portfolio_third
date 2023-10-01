class List < ApplicationRecord
  belongs_to :user
  has_many :list_cards, dependent: :destroy
  has_many :cards, through: :list_cards
end
