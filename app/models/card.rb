class Card < ApplicationRecord
  belongs_to :book
  belongs_to :user

  has_many :favorites
  has_many :users, through: :favorites

  has_many :watchlists
  has_many :watchers, through: :watchlists, source: :user
end
