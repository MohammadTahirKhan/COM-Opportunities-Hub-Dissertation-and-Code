require 'rails_helper'

RSpec.describe Post, type: :model do

    describe 'validations:' do
        it "is valid with valid attributes" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date: Date.today, deadline: Date.today, start_time: "10:00", end_time: "11:00", organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: true, recurring_interval_num: 1, recurring_interval_unit: "week", custom_recurring_info: "custom_recurring_info")
            expect(post).to be_valid
            user.destroy
            post.destroy

        end

        it "is not valid without a title" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", location: "location", start_date: Date.today, end_date: Date.today, organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid without a location" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "", start_date: Date.today, end_date: Date.today, organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid without a start_date" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: '', end_date: Date.today, organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid without a end_date" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date: '', organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid without a organiser" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date: Date.today, organiser: "", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid without a description" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date: Date.today, organiser: "organiser", description: "", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid without a url" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date: Date.today, organiser: "organiser", description: "description", url: "", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid without recurring as true or false" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date: Date.today, organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"])
            expect(post).to_not be_valid
            user.destroy
            post.destroy

        end

        it "is not valid with start_date in the past" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: '2021-01-01', end_date: Date.today, organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid with end_date in the past" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date:'2021-01-01', organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid with end_date before start_date" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: '2025-04-04', end_date:'2025-01-01', organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid with recurring_interval_num as negative" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date:Date.today, organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: true, recurring_interval_num: -1, recurring_interval_unit: "week")
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid with recurring_interval_unit as blank if recurring_interval_num is present" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date:'2021-01-01', organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: true , recurring_interval_num: 1, recurring_interval_unit: "")
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid with recurring_interval_num and recurring_interval_unit as blank if recurring is true" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date:'2021-01-01', organiser: "organiser", description: "description", url: "url", tags: ["tag1", "tag2"], recurring: true , recurring_interval_num: "", recurring_interval_unit: "")
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end

        it "is not valid with custom_recurring_info as blank if recurring is true" do
        end

        it "is not valid without tags" do
            user = User.create(email: "abc@gmail.com", password: "123456", full_name: "abc", user_role: "1")
            post = Post.new(email: "abc@gmail.com", title: "title", location: "location", start_date: Date.today, end_date:'2021-01-01', organiser: "organiser", description: "description", url: "url", tags: [], recurring: false)
            expect(post).to_not be_valid
            user.destroy
            post.destroy
        end
    end
end