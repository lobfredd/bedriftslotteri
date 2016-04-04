require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  test "Company name can't be blank" do
    company = Company.new(key: "randomString")
    assert_not company.save
  end

  test "Company need a key, min length 16" do
    company = Company.new(company_name: "testComapny", key: "tooShort")
    company.users << users(:CompanyUser)
    assert_not company.save
  end

  test "Company should not save without company-user" do
    company = Company.new(company_name: "testCompany", key: "uqmfkbsearyvihgw")
    assert_not company.save, "Company saved without company-user!"
  end

  test "Company should save with company-user" do
    company = Company.new(company_name: "testCompany", key: "uqmfkbsearyvihgw")
    company.users << users(:CompanyUser)
    assert company.save, company.errors.full_messages.map { |msg| msg }.join.to_s
  end

  test "Company can only have one company-user" do
    company = companies(:testCamel)
    company.users << users(:CompanyUser)
    assert_not company.save
  end

  test "Get all regular users" do
    company = companies(:testCamel)
    regular_users = company.all_regular_users
    assert_not regular_users.include? users(:testCamelCompanyUser)
  end

  test "Get top 5 winners" do
    winners = companies(:testCamel).top_5_winners
    expected_winners = top_5_winners_names
    winners.each_with_index do |winner, i|
      assert winner[0] == expected_winners[i]
    end
  end

  test "Get upcoming lotteries" do
    company = companies(:testCamel)
    upcoming = company.upcoming_lotteries
    upcoming.each {|lottery| assert lottery.start_date > Time.now}
    assert upcoming.count == 8
    assert_not upcoming.include? lotteries(:lottery1)
  end

  test "Get average winning chance" do
    average_winning_chance = companies(:testCamel).average_winning_chance
    assert (average_winning_chance == 87.5)
  end

  test "Get 0 average winning chance if no tickets sold" do
    average_winning_chance = companies(:testCamel2).average_winning_chance
    assert (average_winning_chance == 0)

  end

  private
  def top_5_winners_names
    winners = []
    5.times { |n| winners << "User#{(n+1).to_s}" }
    winners
  end

end
