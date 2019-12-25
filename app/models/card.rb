class Card < ApplicationRecord
  belongs_to :user, inverse_of: :card
end
