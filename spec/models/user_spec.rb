require 'rails_helper'

describe 'User model should work', type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(
        email: 'newuser@gmail.com',
        first_name: 'Bob',
        last_name: 'Smith',
        password: '123456',
        password_confirmation: '123456',
      )
    end

    it 'saves successfully with all five fields set' do
      expect(@user.save).to be true
    end

    it 'requires email to be unique' do
      new_user = User.new(
        email: 'test@test.com',
        first_name: 'Barb',
        last_name: 'White',
        password: '123456',
        password_confirmation: '123456',)

        expect(new_user).to be_valid
        expect { new_user.save }.to change { User.count }.by(1)

        new_user2 = User.new(
        email: 'test@test.com',
        first_name: 'Barb',
        last_name: 'White',
        password: '123456',
        password_confirmation: '123456',)

      expect(new_user2).to_not be_valid
      expect { new_user2.save }.to_not change { User.count }
    end

    it 'requires the presence of password' do
      @user.password = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'requires the presence of password_confirmation' do
      @user.password_confirmation = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'requires the presence of email' do
      @user.email = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'requires the presence of first_name' do
      @user.first_name = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'requires the presence of last_name' do
      @user.last_name = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'requires password and password_confirmation to match' do
      @user.password = '456789'
      @user.password_confirmation = '67'
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires the minimum password length to be 6 characters' do
      @user.password = '12'
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    let!(:user) do
      User.create(
        first_name: 'Mary',
        last_name: 'Simpson',
        email: 'mary@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'should authenticate with valid credentials' do
      authenticated_user = User.authenticate_with_credentials('mary@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should not authenticate with incorrect password' do
      authenticated_user = User.authenticate_with_credentials('mary@test.com', 'pass')
      expect(authenticated_user).to be_nil
    end

    it 'should not authenticate with incorrect email' do
      authenticated_user = User.authenticate_with_credentials('harry@test.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'should authenticate with email containing spaces' do
      authenticated_user = User.authenticate_with_credentials('   mary@test.com ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate with email(case-insensitivity)' do
      authenticated_user = User.authenticate_with_credentials('MARY@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end

end