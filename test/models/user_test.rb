require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: 'user@example.com', password: '123456', password_confirmation: '123456',
                        first_name: 'First', last_name: 'User')
  end

  test "01. should be valid" do
    assert @user.valid?
  end

  test "02. first name should be present" do
    @user.first_name = ''
    assert_not @user.valid?
  end

  test "03. last name should be present" do
    @user.last_name = ''
    assert_not @user.valid?
  end

  test "04. should reject empty email" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "05. should reject email address already used while ignoring case sensitivity" do
    @user_two = User.create(email: 'USER@EXAMPLE.COM', password: '123456a', password_confirmation: '123456a',
                            first_name: 'User', last_name: 'Second')
    assert_not @user_two.valid?
  end

  test "06. should reject empty password" do
    @user.password = ''
    assert_not @user.valid?
  end

  test "07. should reject empty password_confirmation" do
    @user.password_confirmation = ''
    assert_not @user.valid?
  end

  test "08. user should reject passwords that is less than 6 chars in length" do
    @user.password = '12345'
    @user.password_confirmation = '12345'
    assert_not @user.valid?
  end

  test "09. should reject unmatched password and confirmation password" do
    @user.password_confirmation = 'abcdefgh'
    assert_not @user.valid?
  end

  test "10. check if password is correct" do
    assert @user.valid_password?('123456')
  end

  test "11. should reject incorrect password" do
    assert_not @user.valid_password?('abcdef')
  end
end
