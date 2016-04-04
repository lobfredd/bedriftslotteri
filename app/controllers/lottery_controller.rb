class LotteryController < ApplicationController
  before_filter except: [:statistics] {accept_role :user, :company}
  before_filter only: [:index] {accept_role :user}

  def index
    @ticket = Ticket.new
    @user = current_user
    @leader_board = current_user.company.top_5_winners
    @all_time_winning_chance = current_user.company.average_winning_chance
    @todays_winning_chance = current_user.company.todays_winning_chance
    @upcoming_lotteries = current_user.company.upcoming_lotteries
  end



  def current_lottery
    @lottery = current_user.company.lotteries.find(params[:id])
    @winners = @lottery.get_winners
  end

  def statistics
    @sold_tickets = Lottery.total_number_of_sold_tickets
    @sum_sold_tickets = Lottery.sum_of_all_sold_tickets
  end


end
