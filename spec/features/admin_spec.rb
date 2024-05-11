require "rails_helper"
RSpec.describe "Admin features:", type: :feature do
    describe "Users page" do
        it "should not show users to non-admin" do
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            visit admin_index_path(view: "users")
            expect(page).to have_content("COM Opportunities Hub")
        end
        it "should show all users to admin" do
            admin = FactoryBot.create(:admin)
            user1 = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: admin.email
            fill_in "Password", with: admin.password
            click_button "Log in"
            click_link "Users"
            expect(page).to have_content(user1.email)
            expect(page).to have_content(admin.email)
            expect(page).to have_content("Admin")
            expect(page).to have_content("User")
            expect(page).to have_content("Edit")
        end

        it "should edit user role to admin" do
            admin = FactoryBot.create(:admin)
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: admin.email
            fill_in "Password", with: admin.password
            click_button "Log in"
            click_link "Users"
            click_link "Edit"
            select "Admin", from: "user_user_role"
            click_button "Update"
            click_link "Users"
            expect(page).to have_content("Admin")
        end

        it "should edit user role to user (browser)" do
            admin = FactoryBot.create(:admin)
            user = FactoryBot.create(:poster)
            visit new_user_session_path
            fill_in "Email", with: admin.email
            fill_in "Password", with: admin.password
            click_button "Log in"
            click_link "Users"
            click_link "Edit"
            select "User", from: "user_user_role"
            click_button "Update"
            click_link "Users"
            expect(page).to have_content("User")
        end

        it "should edit user role to poster" do
            admin = FactoryBot.create(:admin)
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: admin.email
            fill_in "Password", with: admin.password
            click_button "Log in"
            click_link "Users"
            click_link "Edit"
            select "Poster", from: "user_user_role"
            click_button "Update"
            click_link "Users"
            expect(page).to have_content("Poster")
        end
    end
end
