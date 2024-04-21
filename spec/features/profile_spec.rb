require 'rails_helper'
RSpec.describe "Profile features:", type: :feature do
    describe "Profile page" do
        it "should show profile" do
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            click_link "Profile"
            expect(page).to have_content(user.email)
            expect(page).to have_content(user.full_name)
            expect(page).to have_content("Edit")
            expect(page).to have_content("Destroy")
            expect(page).to have_content("Back")
        end
        it "should edit profile" do
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            click_link "Profile"
            click_link "Edit"
            fill_in "Full name", with: "new name"
            fill_in "Email", with: "abc@gmail.com"
            fill_in "Password", with: "123456"
            fill_in "Password confirmation", with: "123456"
            check "ML"
            click_button "Update"
            expect(page).to have_content("You need to sign in or sign up before continuing.")
            fill_in "Email", with: "abc@gmail.com"
            fill_in "Password", with: "123456"
            click_button "Log in"
            expect(page).to have_content("User Profile")
            expect(page).to have_content("abc@gmail.com")
            click_link "Profile"
            expect(page).to have_content("new name")
        end
        it "should not edit profile with invalid or taken email" do
            user = FactoryBot.create(:user)
            user2 = FactoryBot.create(:admin)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            click_link "Profile"
            click_link "Edit"
            fill_in "Email", with: user2.email
            fill_in "Password", with: "123456"
            fill_in "Password confirmation", with: "123456"
            check "ML"
            click_button "Update"
            expect(page).to have_content("Email has already been taken")
            expect(page).to have_content("Editing Profile")
        end
            
        it "should destroy profile" do
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            click_link "Profile"
            click_link "Destroy"
            expect(User.find_by(email: user.email)).to be_nil
        end
    end
end