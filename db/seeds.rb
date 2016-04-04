# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

company = Company.create(company_name: "camelCaseInc", key: "uqmfkbsearyvihgw")
user = User.new(first_name: "lotteryMaster", last_name: "isForgotten", email: "f@f.com", role: "company", password: "12341234", password_confirmation: "12341234")
user.company = company
company.users << user
user.save
company.save
user2 = User.new(first_name: "enKunde", last_name: "isForgotten", email: "y@l.o", password: "12341234", password_confirmation: "12341234")
user2.company = company
user2.save

lottery = Lottery.new(lottery_name: "test_lotteri", start_date: DateTime.yesterday, number_of_tickets: 5, price_per_ticket: 22, company: company)
ticket = Ticket.new(user: user2, lottery: lottery, won: true)
award = Award.create(name: "en vin", lottery: lottery, ticket: ticket)
lottery.awards << award
ticket.award = award
lottery.save
ticket.save
