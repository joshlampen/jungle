require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'saves when first name, last name, email, password, and password confirmation fields are set correctly' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save!

      expect(@user.id).to be_present
    end
    
    it 'does not save if the first name field is nil' do
      @user = User.new(
        first_name: nil,
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'does not save if the last name field is nil' do
      @user = User.new(
        first_name: 'Josh',
        last_name: nil,
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'does not save if the email field is nil' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: nil,
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'does not save if the password field is nil' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: nil,
        password_confirmation: '12345678'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'does not save if the password confirmation field is nil' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: nil
      )
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'does not save if password and password confirmation are not the same' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '123456789'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'does not save if email is already in the database (case insensitive)' do
      @user_1 = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user_1.save!

      @user_2 = User.new(
        first_name: 'J',
        last_name: 'L',
        email: 'jOsHlAmPeN@gMaIl.CoM',
        password: '87654321',
        password_confirmation: '87654321'
      )
      @user_2.save

      expect(@user_2.errors.full_messages).to include("Email already exists in database")
    end

    it 'does not save if email is already in the database (accounts for leading and trailing whitespace)' do
      @user_1 = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user_1.save!

      @user_2 = User.new(
        first_name: 'J',
        last_name: 'L',
        email: ' joshlampen@gmail.com ',
        password: '87654321',
        password_confirmation: '87654321'
      )
      @user_2.save

      expect(@user_2.errors.full_messages).to include("Email already exists in database")
    end

    it 'does not save if password is less than 8 characters long' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '1234567',
        password_confirmation: '1234567'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate-with-credentials' do
    it 'authenticates when email and password match' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save!

      expect(User.authenticate_with_credentials('joshlampen@gmail.com', '12345678')).to be_truthy
    end

    it 'does not authenticate if email does not match' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save!

      expect(User.authenticate_with_credentials('jl@gmail.com', '12345678')).to be_falsey
    end

    it 'does not authenticate if password does not match' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save!

      expect(User.authenticate_with_credentials('joshlampen@gmail.com', '87654321')).to be_falsey
    end

    it 'authenticates with correct email despite leading and trailing whitespace' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save!

      expect(User.authenticate_with_credentials(' joshlampen@gmail.com ', '12345678')).to be_truthy
    end

    it 'authenticates with correct email despite different case (case insensitive)' do
      @user = User.new(
        first_name: 'Josh',
        last_name: 'Lampen',
        email: 'joshlampen@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save!

      expect(User.authenticate_with_credentials('jOsHlAmPeN@gMaIl.CoM', '12345678')).to be_truthy
    end
  end
end