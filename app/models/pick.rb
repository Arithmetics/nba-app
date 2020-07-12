class Pick < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  #default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :bet_id, presence: true

  def toggle_lock
    if locked?
      update_attribute(:locked, false)
    else
      update_attribute(:locked, true)
    end
  end

  def projected_win?
    win = true
    standing = Standing.where(team_name: self.title).last
    standing_g = Standing.where(team_name: "#{self.title} Goal").last
    standing_status = standing && standing.win_loss_pct || 0
    standing_goal = standing_g && standing_g.win_loss_pct || 0

    if self.selection == "over"
      if standing_status > standing_goal && self.super
        win = true
      elsif standing_status > standing_goal
        win = true
      else
        win = false
      end
    elsif self.selection == "under"
      if standing_status < standing_goal && self.super
        win = true
      elsif standing_status < standing_goal
        win = true
      else
        win = false
      end
    end
    win
  end
end
