require 'test_helper'

class LotteryTest < ActiveSupport::TestCase

  test "Lottery wont save without a company association" do
    lottery = Lottery.new(start_date: Time.now, lottery_name: "test", number_of_tickets: 22, price_per_ticket: 22)
    lottery.awards << awards(:award1)
    assert_not lottery.save
  end

  test "Lottery wont save without any awards" do
    lottery = Lottery.new(start_date: Time.now, lottery_name: "test", number_of_tickets: 22, price_per_ticket: 22, company: companies(:testCamel))
    assert_not lottery.save
  end

  test "Lottery will auto finish on time" do
    lottery = lotteries(:lottery12)
    Timecop.travel(Time.now + 2.day)
    lottery = Lottery.find(lottery.id) #triggers on_find callback
    assert lottery.finished
  end

  test "Request manually lottery finish" do
    lottery = lotteries(:lottery12)
    lottery.finish_now
    assert lottery.finished
  end

  test "Get winners of lottery" do
    lottery = lotteries(:lottery1)
    winners = lottery.get_winners
    expected_winners = top_5_winners_names
    assert winners.count == 4
    winners.each_with_index do |winner, i|
      assert winner.user.first_name == expected_winners[i]
    end
  end

  test "Get tickets bought by a user" do
    lottery = lotteries(:lottery1)
    user = users(:User1)
    tickets = lottery.tickets_bought_by user
    tickets.each {|ticket| assert user.tickets.include? ticket}
  end

  test "Assert that a user has won the lottery" do
    lottery = lotteries(:lottery1)
    user = users(:User1)
    user_won = lottery.user_won? user
    assert user_won
  end

  test "Assert that a user has not won the lottery" do
    lottery = lotteries(:lottery1)
    user = users(:User6)
    user_won = lottery.user_won? user
    assert_not user_won
  end

  test "Assert correct total price user have spent on lottery" do
    lottery = lotteries(:lottery1)
    user = users(:User1)
    total_spent_by_user = lottery.total_price_tickets_bought_by user
    assert total_spent_by_user == 22
  end

  test "Assert the total number of tickets sold by a lottery" do
    lottery = lotteries(:lottery1)
    total_tickets_sold = lottery.sold_tickets
    assert total_tickets_sold = 6
  end

  test "Assert correct win_chance of a lottery" do
    lottery = lotteries(:lottery1)
    win_chance = lottery.win_chance
    assert win_chance == 20.0
  end

  test "Assert correct win_chance of a lottery with no sold tickets" do
    lottery = lotteries(:lottery10)
    win_chance = lottery.win_chance
    assert win_chance == 100.0
  end

  test "Assert correct tickets left in lottery" do
    lottery = lotteries(:lottery1)
    tickets_left = lottery.tickets_left
    assert tickets_left == 17
  end

  test "Assert that the correct tickets left check works, not enough left" do
    lottery = lotteries(:lottery1)
    is_enough_tickets = lottery.enough_tickets_left 18
    assert_not is_enough_tickets
  end

  test "Assert that the correct tickets left check works" do
    lottery = lotteries(:lottery1)
    is_enough_tickets = lottery.enough_tickets_left 16
    assert is_enough_tickets
  end

  private
  def top_5_winners_names
    winners = []
    5.times { |n| winners << "User#{(n+1).to_s}" }
    winners
  end

end
