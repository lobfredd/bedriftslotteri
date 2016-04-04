class Lottery < ActiveRecord::Base
  has_many :awards
  has_many :users, through: :tickets
  has_many :tickets
  belongs_to :company
  after_find :auto_finish
  validates_presence_of :awards
  validates_presence_of :company

  def auto_finish
    finish unless self.start_date > Time.now || self.finished
  end

  def finish_now
    unless self.finished
      self.update(start_date: Time.now)
      finish
    end
  end

  def get_winners
    self.tickets.select {|ticket| ticket.won }
  end

  def tickets_bought_by(user)
    self.tickets.where(user: user)
  end

  def user_won?(user)
    self.tickets.where(user: user).where(won: true).count > 0
  end

  def total_price_tickets_bought_by(user)
    tickets_bought_by(user).count * self.price_per_ticket
  end

  def tickets_left
    self.number_of_tickets - sold_tickets
  end

  def enough_tickets_left(tickets)
    (tickets_left - tickets) >= 0
  end

  def sold_tickets
    self.tickets.count
  end

  def win_chance
    if sold_tickets != 0
      self.awards.count.to_f / sold_tickets * 100
    else
      100
    end
  end

  def self.total_number_of_sold_tickets
    Lottery.all.map { |lottery| lottery.tickets.count }.reduce(0, :+)
  end

  def self.sum_of_all_sold_tickets
    Lottery.all.map { |lottery| lottery.tickets.count * lottery.price_per_ticket }.reduce(0, :+)
  end

  private

  def finish
    self.update(finished: true)
    tickets = self.tickets.clone
    draw_winners_from tickets unless tickets.empty?
  end

  def draw_winners_from(tickets)
    self.awards.each_with_index do |award, i|
      break if self.tickets.count <= i
      ticket = tickets.shuffle.first
      tickets = tickets.select { |t| t.user != ticket.user }
      award.update(ticket: ticket)
      ticket.update(won: true)
      UserNotifier.send_award_email(ticket.user).deliver
    end
  end
end
