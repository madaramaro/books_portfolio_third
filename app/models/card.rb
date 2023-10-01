class Card < ApplicationRecord
  belongs_to :book
  accepts_nested_attributes_for :book
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  has_many :watchlists, dependent: :destroy
  has_many :watchers, through: :watchlists, source: :user

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :list_cards
  has_many :lists, through: :list_cards
end
