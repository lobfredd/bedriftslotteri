Given(/^I make a company without a name$/) do
  @company = Company.new(key: "randomString")
end

Then(/^company should not save$/) do
  assert_not @company.save
end

Given(/^I make a Company with a too short key$/) do
  @company = Company.new(company_name: "testComapny", key: "tooShort")
  @company.users << users(:CompanyUser)
end

Given(/^I make a company$/) do
  @company =  Company.new(company_name: "testCompany", key: "uqmfkbsearyvihgw")
end

When(/^I assigns a company\-user$/) do
  @company.users << users(:CompanyUser)
end

Then(/^company should save$/) do
  assert @company.save
end

Given(/^I have a company with an existing company\-user relation$/) do
  @company = companies(:testCamel)
end

When(/^I add another company\-user$/) do
  @company.users << users(:CompanyUser)
end

Given(/^I have a company$/) do
  @company = companies(:testCamel)
end

When(/^I fetch all regular users$/) do
  @regular_users = @company.all_regular_users
end

Then(/^that list should only contain regular users$/) do
  assert_not @regular_users.include? users(:testCamelCompanyUser)
end

When(/^I fetch top 5 winners$/) do
  @winners = @company.top_5_winners
end

And(/^I make a expected winners list$/) do
  @expected_winners = top_5_winners_names
end

Then(/^The winners match the expected list$/) do
  @winners.each_with_index do |winner, i|
    assert winner[0] == @expected_winners[i]
  end
end

When(/^I fetch upcoming lotteries$/) do
  @upcoming = @company.upcoming_lotteries
end

Then(/^each lottery should have a start date greater than now$/) do
  @upcoming.each {|lottery| assert lottery.start_date > Time.now}
end

And(/^it should be (\d+) upcoming lotteries$/) do |arg|
  assert @upcoming.count == arg.to_i
end

And(/^it should not include a finished lottery$/) do
  assert_not @upcoming.include? lotteries(:lottery1)
end

When(/^I fetch average winning chance$/) do
  @average_winning_chance = @company.average_winning_chance
end

Then(/^it should be equal to "([^"]*)"$/) do |arg|
  assert (@average_winning_chance == arg.to_f)
end

Given(/^I have a company without any sold tickets$/) do
  @company = companies(:testCamel2)
end

Then(/^it should be (\d+)$/) do |arg|
  assert (@average_winning_chance == arg.to_i)
end

When(/^I search for "([^"]*)"$/) do |arg|
  @user = (@company.regular_users_matching arg).first
end

Then(/^I should get "([^"]*)"$/) do |arg|
  @user.first_name == arg
end

When(/^I fetch past lotteries$/) do
  @past = @company.past_lotteries
end

Then(/^each lottery should have a start date before now$/) do
  @past.each {|lottery| assert lottery.start_date < Time.now}
end


Given(/^I have a company which have a lottery due today$/) do
  @company = companies(:testCamel3)
end

When(/^I fetch todays winning chance$/) do
  @todays_winning_chance = @company.todays_winning_chance
end

Then(/^It should be "(\d+)"$/) do |arg|
  @todays_winning_chance == arg.to_i
end

private
def top_5_winners_names
  winners = []
  5.times { |n| winners << "User#{(n+1).to_s}" }
  winners
end