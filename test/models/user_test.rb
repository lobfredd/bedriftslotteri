require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User need a company" do
    user = User.new(first_name: "enKunde", last_name: "isForgotten", email: "y@l.o", password: "12341234", password_confirmation: "12341234")
    assert_not user.save
  end
end
