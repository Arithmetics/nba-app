class Pick < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :bet_id, presence: true
end
