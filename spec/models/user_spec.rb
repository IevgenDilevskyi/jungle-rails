require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    it "should save new user successfully" do
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "test2222@test.com")
      @user.save!
      expect(@user).to be_present
    end

    it "should return error when creating user with password and password confirmation that do not match" do
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_password", :email => "test.test.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should return error when creating user without password" do
      @user = User.new( :name => "Test", :last_name => "Test", :password_confirmation => "test_pass", :email => "test.test.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should return error when creating user without password confirmation" do
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :email => "test.test.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "should return error when creating user without name" do
      @user = User.new( :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "test.test.com")
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "should return error when creating user without last_name" do
      @user = User.new( :name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "test.test.com")
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should return error when creating user without email" do
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass")
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should save new user successfully" do
      @user1 = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "test234@test.com")
      @user1.save!
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "TEST234@TEST.com")
      @user.save
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

  end
  
  describe '.authenticate_with_credentials' do
    it "should validate authenticated user" do
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "t@test.com")
      @user.save!
      authenticated_user = User.authenticate_with_credentials("t@test.com", "test_pass")
      expect(authenticated_user).to eq(@user)
    end

    it "should validate authenticated user if the email has extra spaces" do
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "t@test.com")
      @user.save!
      authenticated_user = User.authenticate_with_credentials("  t@test.com     ", "test_pass")
      expect(authenticated_user).to eq(@user)
    end

    it "should validate authenticated user if the email has uppercase characters" do
      @user = User.new( :name => "Test", :last_name => "Test", :password => "test_pass", :password_confirmation => "test_pass", :email => "t@test.com")
      @user.save!
      authenticated_user = User.authenticate_with_credentials("t@tEST.com", "test_pass")
      expect(authenticated_user).to eq(@user)
    end
  end

end
