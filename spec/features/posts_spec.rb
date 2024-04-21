require "rails_helper"
RSpec.describe "Posts features:", type: :feature do

    describe "creating a post-" do
        scenario "Poster creates a post" do
            # Sign in as a user
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: 1
            select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("post was successfully created.")
            expect(page).to have_content("Test Post")
            expect(page).to have_content("Test Location")

        end

        scenario "Poster can't create a post without a title" do
            # Sign in as a user
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            
            select "No", from: "Recurring"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Title can't be blank")
        end

        scenario "Poster can't create a post without a location" do
            # Sign in as a user
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            
            select "No", from: "Recurring"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Location can't be blank")
        end

        scenario "Poster can't create post without a start date" do
            # Sign in as a user
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            # fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: 1
            select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Start date and End date can't be blank")
        end

        scenario "Poster can't create post without an end date" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            # fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: 1
            select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Start date and End date can't be blank")

        end

        scenario "Poster can't create post without an organiser" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            # fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: 1
            select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Organiser can't be blank")

        end

        scenario "Poster can't create post without a description" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            # fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: 1
            select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Description can't be blank")
        end

        scenario "Poster can't create post without a URL" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            # fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: 1
            select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Url can't be blank")
        end

        scenario "Poster can't create post without tags" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            # check "AI" # Assuming 'AI' is one of the tags
            # check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: 1
            select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Tags must have at least one tag")
        end

        scenario "Poster can't create post without selecting recurring" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            # select "Yes", from: "Recurring"
            # fill_in "If recurring, then Recurring Interval", with: 1
            # select "weeks", from: "If recurring, then Interval Unit"
            # fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Recurring is not included in the list")
        end

        scenario "Poster can't create post with recurring but without recurring interval and interval unit" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            # fill_in "If recurring, then Recurring Interval", with: 1
            # select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Recurring interval num can't be blank if recurring")
            expect(page).to have_content("Recurring interval unit can't be blank if recurring")
        end

        scenario "Poster can't create post with recurring but with recurring interval num as negative or zero and interval unit as blank" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "Yes", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: -1
            # select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Failed to create post, please fill in all required(*) fields or check for errors")
            expect(page).to have_content("Recurring interval num can't be zero or negative and Recurring interval num can't be blank if recurring")
            expect(page).to have_content("Recurring interval unit can't be blank if recurring interval number is present and Recurring interval unit can't be blank if recurring")
        end

        scenario "Post must be created if user creates a post without recurring and fills recurring interval num as zero or negative and interval unit as blank" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "No", from: "Recurring"
            fill_in "If recurring, then Recurring Interval", with: -1
            # select "weeks", from: "If recurring, then Interval Unit"
            fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("post was successfully created.")
        end

        scenario "Poster can't create post with start date in the past" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.yesterday
            fill_in "post_end_date", with: Date.tomorrow
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "No", from: "Recurring"
            # fill_in "If recurring, then Recurring Interval", with: -1
            # select "weeks", from: "If recurring, then Interval Unit"
            # fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Start date and End date can't be before today")
        end

        scenario "Poster can't create post with end date before start date" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.tomorrow
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "No", from: "Recurring"
            # fill_in "If recurring, then Recurring Interval", with: -1
            # select "weeks", from: "If recurring, then Interval Unit"
            # fill_in "If recurring, then any custom recurring info?", with: "custom_recurring_info"

            # Submit the form
            click_button "Save"

            # Expectations
            expect(page).to have_content("Start date can't be after end date")
        end

        scenario "Poster can't create post with deadline before today" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '1')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today - 1.day
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag

            select "No", from: "Recurring"

            # Submit the form
            click_button "Save"
            # Expectations
            expect(page).to have_content("Deadline can't be before today")
        end

        it "normal user can't create a post" do
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            visit new_post_path
            expect(page).to have_content("COM Opportunities Hub")
        end
        
    end

    describe "editing a post-" do
        scenario "Poster/admin edits a post" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"

            # Visit the new post page
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"

            visit posts_path(visibility: "pending")
            expect(page).to have_content("Test Post")
            expect(page).to have_content("Approve")
            click_link "Approve"

            visit posts_path(visibility: "upcoming")
            visit posts_path(visibility: "search", search: "Test Post")
            expect(page).to have_content("Test Post")

            click_link "Edit"
            fill_in "Title", with: "Test Post edited"
            click_button "Save"

            expect(page).to have_content("post was successfully updated, an admin needs to publish it for it to be visible to others.")
            visit posts_path(visibility: "pending")
            expect(page).to have_content("Test Post edited")

        end

        scenario "Poster/admin can't edit a post by leaving a required field blank" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            visit posts_path(visibility: "pending")
            click_link "Approve"
            visit posts_path(visibility: "upcoming")
            visit posts_path(visibility: "search", search: "Test Post")
            click_link "Edit"
            fill_in "Title", with: ""
            click_button "Save"
            expect(page).to have_content("Title can't be blank")
        end

        scenario "only admin and post creator can edit a post" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            visit posts_path(visibility: "pending")
            click_link "Approve"
            visit destroy_user_session_path
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            visit edit_post_path(1)
            expect(page).to have_content("COM Opportunities Hub")
        end

    end

    describe "deleting a post-" do
        scenario "admin deletes a post" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            visit posts_path(visibility: "pending")
            click_link "Approve"
            visit posts_path(visibility: "upcoming")
            visit posts_path(visibility: "search", search: "Test Post")
            click_link "Destroy"
            expect(page).to have_content("post was successfully destroyed.")
        end

    end

    describe "viewing a post-" do
        scenario "User views a post" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            visit posts_path(visibility: "pending")
            click_link "Approve"
            visit posts_path(visibility: "upcoming")
            visit posts_path(visibility: "search", search: "Test Post")
            click_link "Show"
            expect(page).to have_content("Test Post")
            expect(page).to have_content("Test Location")
        end
            
    end

    describe "searching for a post-" do
        scenario "User searches for a post" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path

            # Fill in the form fields
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            visit posts_path(visibility: "pending")
            click_link "Approve"
            fill_in "search", with: "Test Post"
            click_button "Search"
            expect(page).to have_content("Test Post")
        end

        it "poster can't search for a post" do
            poster = FactoryBot.create(:poster)
            visit new_user_session_path
            fill_in "Email", with: poster.email
            fill_in "Password", with: poster.password
            click_button "Log in"
            visit posts_path(visibility: "search", search: "Test Post")
            expect(page).to have_content("COM Opportunities Hub")
        end
    end

    describe "Upcoming posts:" do
        it "should show all upcoming posts" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            visit posts_path(visibility: "pending")
            click_link "Approve"
            click_link "Upcoming"
            expect(page).to have_content("Listing Upcoming Posts")
            expect(page).to have_content("Test Post")
        end

        it "should not show upcoming posts to posters" do
            poster = FactoryBot.create(:poster)
            visit new_user_session_path
            fill_in "Email", with: poster.email
            fill_in "Password", with: poster.password
            click_button "Log in"
            visit posts_path(visibility: "upcoming")
            expect(page).to have_content("COM Opportunities Hub")
        end

    end

    describe "Recent posts:" do
        it "should show all recent posts" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            Post.create(title: "Test Post1", location: "Test Location", start_date: '2024-01-01', end_date: '2024-01-01', organiser: "Test Organiser", description: "Test Description", deadline: Date.yesterday, start_time: Time.now, end_time: Time.now + 1.hour, url: "http://example.com", recurring: false, email: user.email, tags: ["AI", "ML"], published: true)
            click_link "Recent"
            expect(page).to have_content("Listing Recent Posts")
        end
    end

    describe "Archived posts:" do
        it "should show all archived posts" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            Post.create(title: "Test Post2", location: "Test Location", start_date: '2021-01-01', end_date: '2021-01-01', organiser: "Test Organiser", description: "Test Description", deadline: Date.yesterday, start_time: Time.now, end_time: Time.now + 1.hour, url: "http://example.com", recurring: false, email: user.email, tags: ["AI", "ML"], published: true)
            click_link "Archives"
            expect(page).to have_content("Listing Archived Posts")
        end

    end

    describe "Approve posts:" do
        it "admin should approve a post" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Admin"
            click_link "Pending"
            expect(page).to have_content("Test Post")
            expect(page).to have_content("Awaiting Approval")
            click_link "Approve"
            click_link "Upcoming"
            expect(page).to have_content("Test Post")
        end

        it "posters or normal users should not be able to approve a post" do
            poster = FactoryBot.create(:poster)
            visit new_user_session_path
            fill_in "Email", with: poster.email
            fill_in "Password", with: poster.password
            click_button "Log in"
            visit posts_path(visibility: "pending")
            expect(page).to have_content("COM Opportunities Hub")
        end

    end


    describe "Email posts:" do
        it "admin should email a post" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Admin"
            click_link "Pending"
            expect(page).to have_content("Test Post")
            click_link "Approve"
            click_link "Admin"
            click_link "Email"
            expect(page).to have_content("Listing Posts Waiting to be Emailed")
            click_link "Select"
            click_link "Email Now"
            expect(page).to have_content("New Email Draft")
            expect(page).to have_content("Hello")
            expect(page).to have_content("Here are some new opportunities in the department of computer science:")
            expect(page).to have_content("Test Post")
            expect(page).to have_content("http://example.com")
            click_button "Copy Draft"
            click_link "Email"
            expect(page).to have_content("Listing Posts Waiting to be Emailed (There are 0 posts available.)")
        end

        it "admin should not be able to email a post info if clear selection is clicked" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Admin"
            click_link "Pending"
            expect(page).to have_content("Test Post")
            click_link "Approve"
            click_link "Admin"
            click_link "Email"
            expect(page).to have_content("Listing Posts Waiting to be Emailed")
            click_link "Select"
            click_link "Clear Selection"
            click_link "Email Now"
            expect(page).to have_content("You must select at least one post.")
            expect(page).to_not have_content("Test Post")
        end

        it "Poster or normal users should not be able to email a post" do
            poster = FactoryBot.create(:poster)
            visit new_user_session_path
            fill_in "Email", with: poster.email
            fill_in "Password", with: poster.password
            click_button "Log in"
            visit posts_path(visibility: "email")
            expect(page).to have_content("COM Opportunities Hub")
        end
        
    end
    
    describe "Save posts:" do
        it "user should be able to save a post to the saved" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            user1 = User.create(email: 'test1@example.com', password: 'password', full_name: 'Test User 1', user_role: '0')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Admin"
            click_link "Pending"
            click_link "Approve"
            click_link "Sign out"
            visit new_user_session_path
            fill_in "Email", with: user1.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            click_link "Upcoming"
            expect(page).to have_content("Test Post")
            click_link "Save"
            expect(page).to have_content("Post was successfully saved.")
            click_link "Saved"
            expect(page).to have_content("Listing Posts You've Saved")
            expect(page).to have_content("Test Post")
        end

        it "user should be able to unsave a post from the saved" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            user1 = User.create(email: 'test1@example.com', password: 'password', full_name: 'Test User 1', user_role: '0')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Admin"
            click_link "Pending"
            click_link "Approve"
            click_link "Sign out"
            visit new_user_session_path
            fill_in "Email", with: user1.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            click_link "Upcoming"
            expect(page).to have_content("Test Post")
            click_link "Save"
            expect(page).to have_content("Post was successfully saved.")
            click_link "Saved"
            expect(page).to have_content("Test Post")
            click_link "Unsave"
            expect(page).to have_content("Post was successfully unsaved.")
            click_link "Saved"
            expect(page).to_not have_content("Test Post")
        end

        it "if it's saved, it should show that it is already saved and instead give an option to unsave" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            user1 = User.create(email: 'test1@example.com', password: 'password', full_name: 'Test User 1', user_role: '0')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Admin"
            click_link "Pending"
            click_link "Approve"
            click_link "Sign out"
            visit new_user_session_path
            fill_in "Email", with: user1.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            click_link "Upcoming"
            expect(page).to have_content("Test Post")
            click_link "Save"
            expect(page).to have_content("Post was successfully saved.")
            click_link "Upcoming"
            expect(page).to have_content("Test Post")
            expect(page).to have_content("Unsave")
            click_link "Unsave"
            expect(page).to have_content("Post was successfully unsaved.")
            click_link "Saved"
            expect(page).to_not have_content("Test Post")
        end

        it "posters and admin should not be able to see saved page" do
            poster = FactoryBot.create(:poster)
            visit new_user_session_path
            fill_in "Email", with: poster.email
            fill_in "Password", with: poster.password
            click_button "Log in"
            visit posts_path(visibility: "saved")
            expect(page).to have_content("COM Opportunities Hub")
        end
    end

    describe "my history page:" do
        it "should show the history of all the posts the user has posted" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "My History"
            expect(page).to have_content("Listing Posts You've Posted")
            expect(page).to have_content("Test Post")
            expect(page).to have_content("Awaiting Approval")
            click_link "Pending"
            click_link "Approve"
            click_link "My History"
            expect(page).to have_content("Test Post")
            expect(page).to have_content("Published")
        end

        it "normal users should not be able to view the my history page" do
            user = FactoryBot.create(:user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
            visit posts_path(visibility: "history")
            expect(page).to have_content("COM Opportunities Hub")
        end

    end

    describe "Notifications page:" do
        it "should show notifications for the user if a post's tags match the user's interests" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Pending"
            click_link "Approve"
            click_link "Sign out"
            user1 = User.create(email: 'test1@example.com', password: 'password', full_name: 'Test User1', user_role: '0', tags: ["AI"])
            visit new_user_session_path
            fill_in "Email", with: user1.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            click_link "Upcoming"
            expect(page).to have_content("1")
            click_link "Notifications"
            expect(page).to have_content("Listing notifications")
            expect(page).to have_content("Notifications were successfully marked as read.")
            expect(page).to have_content("Test Post")
            expect(page).to have_content("There is a new post available for you that you may be interested in. Please click Show to view the details.")
            expect(page).to have_content("Available")
        end

        it "should give Show and Save options for new notification of posts" do
            user = User.create(email: 'test@example.com', password: 'password', full_name: 'Test User', user_role: '2')
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            visit new_post_path
            fill_in "Title", with: "Test Post"
            fill_in "Location", with: "Test Location"
            fill_in "post_start_date", with: Date.today
            fill_in "post_end_date", with: Date.today
            fill_in "Organiser", with: "Test Organiser"
            fill_in "Description", with: "Test Description"
            fill_in "post_deadline", with: Date.today
            fill_in "start_time", with: Time.now
            fill_in "end_time", with: Time.now + 1.hour
            fill_in "URL", with: "http://example.com"
            check "AI" # Assuming 'AI' is one of the tags
            check "ML" # Assuming 'ML' is another tag
            select "No", from: "Recurring"
            click_button "Save"
            click_link "Pending"
            click_link "Approve"
            click_link "Sign out"
            user1 = User.create(email: 'test1@example.com', password: 'password', full_name: 'Test User1', user_role: '0', tags: ["AI"])
            visit new_user_session_path
            fill_in "Email", with: user1.email
            fill_in "Password", with: 'password'
            click_button "Log in"
            click_link "Upcoming"
            expect(page).to have_content("1")
            click_link "Notifications"
            expect(page).to have_content("Test Post")
            click_link "Show"
            expect(page).to have_content("Test Post")
            click_link "Back"
            click_link "Notifications"
            click_link "Save"
            expect(page).to have_content("Post was successfully saved.")
        end
            
        it "Admins or posters should not be able to view the notifications page" do
            poster = FactoryBot.create(:poster)
            visit new_user_session_path
            fill_in "Email", with: poster.email
            fill_in "Password", with: poster.password
            click_button "Log in"
            visit posts_path(visibility: "notifications")
            expect(page).to have_content("COM Opportunities Hub")
        end
    end

end