class ListCard < ApplicationRecord
  belongs_to :list
  belongs_to :card
end
