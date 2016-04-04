Then(/^lottery should not save$/) do
  assert_not @lottery.save
end

Given(/^I have a Lottery without company association$/) do
  @lottery = Lottery.new(start_date: Time.now, lottery_name: "test", number_of_tickets: 22, price_per_ticket: 22)
  @lottery.awards << awards(:award1)
end

Given(/^I have a Lottery without any awards$/) do
  @lottery = Lottery.new(start_date: Time.now, lottery_name: "test", number_of_tickets: 22, price_per_ticket: 22, company: companies(:testCamel))
end

Given(/^I have a lottery which starts in one day$/) do
  @lottery = lotteries(:lottery12)
end

When(/^2 days have passed$/) do
  Timecop.travel(Time.now + 2.day)
  @lottery = Lottery.find(@lottery.id) #triggers on_find callback
end

Then(/^lottery should be finished$/) do
  assert @lottery.finished
end

When(/^I manually finish lottery$/) do
  @lottery.finish_now
end

Given(/^I have a lottery$/) do
  @lottery = lotteries(:lottery1)
end

When(/^I fetch the winners$/) do
  @winners = @lottery.get_winners
end

Then(/^I would get (\d+) winners$/) do |arg|
  assert @winners.count == arg.to_i, @winners.count.to_s
end

And(/^The winners of the lottery match the expected list$/) do
  @winners.each_with_index do |winner, i|
    assert winner.user.first_name == @expected_winners[i]
  end
end

And(/^I have a user named "([^"]*)"$/) do |arg|
  @user = users(arg.to_sym)
end

When(/^I fetch tickets associated with that lottery and user$/) do
  @tickets = @lottery.tickets_bought_by @user
end

Then(/^I should get the corresponding tickets$/) do
  @tickets.each {|ticket| assert @user.tickets.include? ticket}
end


When(/^I check if the user has won$/) do
  @user_won = @lottery.user_won? @user
end

Then(/^it should be true$/) do
  assert @user_won
end

Then(/^it should not be true$/) do
  assert_not @user_won
end

When(/^I get the total price spent on lottery$/) do
  @total_spent_by_user = @lottery.total_price_tickets_bought_by @user
end

Then(/^the total should be "([^"]*)"$/) do |arg|
  assert @total_spent_by_user == arg.to_f
end

When(/^I fetch total sold tickets$/) do
  @total_tickets_sold = @lottery.sold_tickets
end

Then(/^it should be "([^"]*)"$/) do |arg|
  assert @total_tickets_sold = arg.to_i
end

When(/^I fetch the win chance$/) do
  @win_chance = @lottery.win_chance
end

Then(/^the win chance should be "([^"]*)"$/) do |arg|
  assert @win_chance == arg.to_f
end

Given(/^I have a lottery with no sold tickets$/) do
  @lottery = lotteries(:lottery10)
end

When(/^I fetch tickets left in that lottery$/) do
  @tickets_left = @lottery.tickets_left
end

Then(/^it should be "([^"]*)" tickets left$/) do |arg|
  assert @tickets_left == arg.to_i
end

When(/^I ask if there is "([^"]*)" tickets left$/) do |arg|
  @is_enough_tickets = @lottery.enough_tickets_left arg.to_i
end

Then(/^it should not be that many tickets left$/) do
  assert_not @is_enough_tickets
end

Then(/^it should be that many tickets left$/) do
  assert @is_enough_tickets
end