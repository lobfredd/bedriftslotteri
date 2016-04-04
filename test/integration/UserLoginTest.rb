require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "login" do
    get new_user_session_path
    assert_response :success

    @user = User.new(:email => 'test@example.com', :password => '12345678', :password_confirmation => '12345678', company: companies(:testCamel))
    assert @user.save
    assert sign_in(@user)
    # get lottery_index_path
    # assert_response :success
  end
end