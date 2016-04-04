class Ticket < ActiveRecord::Base
  belongs_to :lottery
  belongs_to :user
  has_one :award
  validates_presence_of :lottery
  validates_presence_of :user
  validate :winner_tickets_need_award

  def winner_tickets_need_award
    if self.won
      errors.add(:base, 'Winner ticket must have an award') unless self.award
    end
  end
end