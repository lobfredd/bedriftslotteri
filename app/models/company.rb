class Company < ActiveRecord::Base
  has_many :lotteries
  has_many :users
  validates_presence_of :company_name, message: "can't be blank!"
  validates_presence_of :key, message: "can't be blank!"
  validates_length_of :key, is: 16
  validate :single_company_user_present

  def top_5_winners
   users.select(:first_name)
        .joins(:tickets)
        .where(tickets: {won: true})
        .group(:first_name)
        .order("count_all DESC")
        .limit(5)
        .count(:all)
  end

  def all_regular_users
    users.where("role != 'company'")
  end

  def regular_users_matching(search_input)
    all_regular_users.where("lower(first_name) LIKE ? ", "%" + search_input.downcase + "%")
  end

  def upcoming_lotteries
    lotteries.where("start_date > ?", Time.now).order("start_date DESC")
  end

  def past_lotteries
    lotteries.where("start_date <= ?", Time.now).order("start_date DESC")
  end

  def past_three_lotteries
    lotteries.where("start_date <= ?", Time.now).order("start_date DESC").limit(3)
  end

  def average_winning_chance
    if total_tickets_sold != 0
      (winning_ticket_count.to_f / total_tickets_sold) * 100
    else
      0
    end
  end

  def todays_winning_chance
    win_chances = lotteries.where('start_date BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).map {|lottery| lottery.win_chance}
    if win_chances.count != 0
      win_chances.reduce(0, :+).to_f / win_chances.count
    else
      0
    end
  end

  private
  def total_tickets_sold
    lotteries.map {|lottery| lottery.tickets.count}.reduce(0, :+)
  end

  def winning_ticket_count
    lotteries.map { |lottery| lottery.tickets.select { |ticket| ticket.won }.count }.reduce(0, :+)
  end

  def single_company_user_present
    errors.add(:base, 'Must have a company-user!') unless users.select {|user| user.role == 'company'}.count == 1
  end
end
