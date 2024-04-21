# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  email                   :string(100)
#  encrypted_password      :string(100)
#  full_name               :string
#  last_sign_in_at         :datetime
#  provider                :string
#  read_notification_ids   :bigint           default([]), is an Array
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  saved_post_ids          :bigint           default([]), is an Array
#  tags                    :string           default([]), is an Array
#  uid                     :string
#  unread_notification_ids :bigint           default([]), is an Array
#  user_role               :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do
    it 'should validate presence of email' do
      visit "/users/sign_up"
      fill_in 'Password', with: '123456'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Email can't be blank")
    end

    it 'should validate presence of password' do
      visit "/users/sign_up"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Password can't be blank")
    end

    it 'should validate the uniqueness of email' do
      user1 = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0')
      visit "/users/sign_up"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '123123'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Email has already been taken")
      User.destroy(user1.id)
    end

    it 'should validate the length of password' do
      visit "/users/sign_up"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '12313'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end

    it 'should validate the format of email' do
      visit "/users/sign_up"
      fill_in 'Email', with: 'abc'
      fill_in 'Password', with: '12313'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Email is invalid")
    end

    it 'should not be valid when email is nil' do
      user = User.create(email: 'nil', password: '123456', full_name: 'abc', user_role: '0')
      expect(user).to_not be_valid

    end

    it 'should not be valid when password is nil' do
      user = User.create(email: 'abc@gmail.com', password: nil, full_name: 'abc', user_role: '0')
      expect(user).to_not be_valid
    end
  end

  describe 'authenticate' do
    it 'should return the user when email and password are correct' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0')
      visit "/users/sign_in"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content("Signed in successfully.")
      User.destroy(user.id)
    end

    it 'should return error when email is incorrect' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0')
      visit "/users/sign_in"
      fill_in 'Email', with: 'abc2321211232132232131abcabcbac12@gmail.com'
      fill_in 'Password', with: '123123'
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      User.destroy(user.id)
    end

    it 'should return error when password is incorrect' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0')
      visit "/users/sign_in"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '123123'
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      User.destroy(user.id)
    end

  end

  describe 'Database' do
    it 'should have a table' do
      expect(User.table_exists?).to be(true)
    end

    it 'should have columns' do
      expect(User.column_names).to include('id')
      expect(User.column_names).to include('email')
      expect(User.column_names).to include('encrypted_password')
      expect(User.column_names).to include('full_name')
      expect(User.column_names).to include('last_sign_in_at')
      expect(User.column_names).to include('provider')
      expect(User.column_names).to include('read_notification_ids')
      expect(User.column_names).to include('remember_created_at')
      expect(User.column_names).to include('reset_password_sent_at')
      expect(User.column_names).to include('reset_password_token')
      expect(User.column_names).to include('saved_post_ids')
      expect(User.column_names).to include('tags')
      expect(User.column_names).to include('uid')
      expect(User.column_names).to include('unread_notification_ids')
      expect(User.column_names).to include('user_role')
      expect(User.column_names).to include('created_at')
      expect(User.column_names).to include('updated_at')
    end

    it 'should have a primary key' do
      expect(User.primary_key).to eq('id')
    end

    it 'should have indexes' do
      expect(ActiveRecord::Base.connection.indexes(:users).first.columns).to include('email')
      expect(ActiveRecord::Base.connection.indexes(:users).second.columns).to include('reset_password_token')
    end

    it 'should have a unique index' do
      expect(ActiveRecord::Base.connection.indexes(:users).first.unique).to be(true)
      expect(ActiveRecord::Base.connection.indexes(:users).second.unique).to be(true)
    end

    it 'should have default values' do
      expect(User.column_defaults['read_notification_ids']).to eq([])
      expect(User.column_defaults['saved_post_ids']).to eq([])
      expect(User.column_defaults['tags']).to eq([])
      expect(User.column_defaults['unread_notification_ids']).to eq([])
    end

    it 'should have not null constraints' do
      expect(User.columns_hash['id'].null).to be(false)
      expect(User.columns_hash['created_at'].null).to be(false)
      expect(User.columns_hash['updated_at'].null).to be(false)
    end

  end

  describe 'Factory' do
    it 'should create user' do
      user = create(:user)
      expect(user.id).to be_truthy
    end

    it 'should create poster' do
      user = create(:poster)
      expect(user.id).to be_truthy
    end

    it 'should create admin' do
      user = create(:admin)
      expect(user.id).to be_truthy
    end

  end

  describe 'Insertion' do
    it 'should insert user' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0')
      expect(user.id).to be_truthy
      expect(user).to be_valid
      User.destroy(user.id)
    end
  end

  describe 'Deletion' do
    it 'should delete user' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0')
      User.destroy(user.id)
      expect(User.exists?(user.id)).to be(false)
    end
  end

  describe 'Update' do
    it 'should update user' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      user.update(email: 'abc@gmail.com', password: '123456', full_name: 'abcd', user_role: '1')
      expect(user.full_name).to eq('abcd')
      expect(user.user_role).to eq('1')
      User.destroy(user.id)
    end

  end

  describe 'Registration' do
    it 'should register user' do
      visit "/users/sign_up"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '123123'
      fill_in 'Password confirmation', with: '123123'
      fill_in 'Full name', with: 'abc'
      check 'Are you here to post an opportunity?'

      click_button 'Sign up'
      expect(page).to have_content("Welcome! You have signed up successfully.")
      User.destroy(User.find_by(email: 'abc@gmail.com').id)
    end

    it 'should not register user with invalid email' do
      visit "/users/sign_up"
      fill_in 'Email', with: 'invalidemail'
      fill_in 'Password', with: '123456'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Email is invalid")
    end

    it 'should not register user with too short password' do
      visit "/users/sign_up"
      fill_in 'Email', with: 'validemail@gmail.com'
      fill_in 'Password', with: '123'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end

    it 'should not register user with already taken email' do
      user = User.create(email: 'takenemail@gmail.com', password: '123456', full_name: 'abc', user_role: '0')
      visit "/users/sign_up"
      fill_in 'Email', with: 'takenemail@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Full name', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content("Email has already been taken")
      User.destroy(user.id)
    end

    it 'should not register user with empty email or password' do
      visit "/users/sign_up"
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Sign up'
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end

  describe 'Sign in' do
    it 'should sign in user' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content("Signed in successfully.")
      User.destroy(user.id)
    end

    it 'should not sign in user with invalid email' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      fill_in 'Email', with: 'abc'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      User.destroy(user.id)
    end

    it 'should not sign in user with invalid password' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '13456'
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      User.destroy(user.id)
    end

    it 'should not sign in user with empty email or password' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      fill_in 'Email', with: ''
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")

      visit "/users/sign_in"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      User.destroy(user.id)
    end

  end

  describe 'Sign out' do
    it 'should sign out user' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      fill_in 'Email', with: 'abc@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'Sign out'
      expect(page).to have_content("Signed out successfully.")
      User.destroy(user.id)
    end
  end

  describe 'Forgot password' do
    it 'should send reset password email' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      click_link 'Forgot your password?'
      expect(page).to have_content("Forgot your password?")
      fill_in 'Email', with: 'abc@gmail.com'
      click_button 'Send me reset password instructions'
      expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
      User.destroy(user.id)
    end

    it 'should not send reset password email with invalid email' do
      user = User.create(email: 'abc@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      click_link 'Forgot your password?'
      expect(page).to have_content("Forgot your password?")
      fill_in 'Email', with: 'abc213214214212312312@gmail.com'
      click_button 'Send me reset password instructions'
      expect(page).to have_content("Email not found")
      User.destroy(user.id)
    end

    it 'should not send reset password email with empty email' do
      visit "/users/sign_in"
      click_link 'Forgot your password?'
      expect(page).to have_content("Forgot your password?")
      fill_in 'Email', with: ''
      click_button 'Send me reset password instructions'
      expect(page).to have_content("Email can't be blank")
    end

    it 'should send email with reset password link' do
      user = User.create(email: 'abctesttest@gmail.com', password: '123456', full_name: 'abc', user_role: '0') 
      visit "/users/sign_in"
      click_link 'Forgot your password?'
      expect(page).to have_content("Forgot your password?")
      fill_in 'Email', with: 'abctesttest@gmail.com'
      click_button 'Send me reset password instructions'
      expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
      user.send_reset_password_instructions
      expect(ActionMailer::Base.deliveries.count).to eq(2)
      User.destroy(user.id)
    end
  end

  describe 'Devise Configuration' do
    it 'uses database authenticatable' do
      expect(described_class.devise_modules).to include(:database_authenticatable)
    end

    it 'is registerable' do
      expect(described_class.devise_modules).to include(:registerable)
    end

    it 'is recoverable' do
      expect(described_class.devise_modules).to include(:recoverable)
    end

    it 'is rememberable' do
      expect(described_class.devise_modules).to include(:rememberable)
    end

    it 'is validatable' do
      expect(described_class.devise_modules).to include(:validatable)
    end
  end

  
  describe '.from_omniauth' do
    let(:auth) { double('auth', provider: 'provider', uid: 'uid', info: double('info', email: 'test@example.com', name: 'Test User')) }
    
    context 'when user does not exist' do
      it 'creates a new user from omniauth data' do
        expect do
          described_class.from_omniauth(auth)
        end.to change(described_class, :count).by(1)
        
        user = described_class.last
        expect(user.email).to eq('test@example.com')
        expect(user.full_name).to eq('Test User')
      end
    end
    
    context 'when user already exists' do
      before { create(:user, provider: 'provider', uid: 'uid', email: 'test@example.com') }
      
      it 'does not create a new user' do
        expect do
          described_class.from_omniauth(auth)
        end.not_to change(described_class, :count)
      end
      
      it 'returns the existing user' do
        user = described_class.from_omniauth(auth)
        expect(user.email).to eq('test@example.com')
      end
    end
  end


end