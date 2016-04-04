require 'test_helper'

class LotteryUserTest < ActiveSupport::TestCase

  test "Lottery association required" do
    ticket = Ticket.new
    ticket.user = users(:User1)
    assert_not ticket.save
  end

  test "User association required" do
    ticket = Ticket.new
    ticket.lottery = lotteries(:lottery1)
    assert_not ticket.save
  end

  test "Should save with required associations" do
    ticket = Ticket.new
    ticket.lottery = lotteries(:lottery1)
    ticket.user = users(:User1)
    assert ticket.save
  end
end
