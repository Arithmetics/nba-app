class Bet < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :benchmark, presence: true
  
end
