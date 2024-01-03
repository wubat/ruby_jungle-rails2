require 'rails_helper'

RSpec.describe User, type: :model do
  # Must be created with password and password_confirmation field
  describe 'Validations' do
    it 'must have a password' do
      @user = User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'example@email.com'
      )
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    # Password must have a minimum length of 6 characters
    it 'must have a password with a minimum length of 6 characters' do
      @user = User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'example.email.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    # Password and password_confirmation must match
    it 'fails if password and password_confirmation do not match' do
      @user = User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'example@email.com',
        password: 'password',
        password_confirmation: 'password1'
      )
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    # Happy path for password and confirmation matching
    it 'must have a matching password and password_confirmation' do
      @user = User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'example@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(@user).to be_valid
    end

    # Email must be unique
    it 'must have a unique email' do
      @user1 = User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'example@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user1.save
      @user2 = User.new(
        first_name: 'test',
        last_name: 'test',
        email: @user1.email,
        password: 'password',
        password_confirmation: 'password'
      )
      @user2.save
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'emails are NOT case-sensitive' do
      @user1 = User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'example@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user1.save
      @user2 = User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'EXAMPLE@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user2.save
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do

    before do
      @user = User.create(
        first_name: 'test',
        last_name: 'test',
        email: 'example@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end
  
    it 'should authenticate the user with the correct email and password' do
      authenticated_user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(authenticated_user).to eq(@user)
    end
  
    it 'should not authenticate the user with the incorrect email or password' do
      authenticated_user = User.authenticate_with_credentials(@user.email, 'wrong_password')
      expect(authenticated_user).to be_nil
    end
  end

  describe 'edge cases' do
    before do
      @user = User.create(
        first_name: 'test',
        last_name: 'test',
        email: 'example@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'should authenticate the user with the correct email and password with spaces' do
      authenticated_user = User.authenticate_with_credentials('   example@example.com', @user.password)
      expect(authenticated_user).to eq(@user)
    end

    it 'should authenticate the user with the correct email with uppercases' do
      authenticated_user = User.authenticate_with_credentials('ExAmPle@EXAMPLE.com', @user.password)
      expect(authenticated_user).to eq(@user)
    end
  end

end
