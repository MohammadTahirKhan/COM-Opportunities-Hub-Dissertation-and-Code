# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(full_name: 'admin', email: "admin@gmail.com", password: "admin1", password_confirmation: "admin1", user_role: '2', remember_created_at: Time.now)
User.create(full_name: 'user', email: "user@gmail.com", password: "usertest1", password_confirmation: "usertest1", user_role: '0', remember_created_at: Time.now)
User.create(full_name: 'poster', email: "poster@gmail.com", password: "poster1", password_confirmation: "poster1", user_role: '1', remember_created_at: Time.now)
User.create(full_name: 'poster2', email: "poster2@gmail.com", password: "poster2", password_confirmation: "poster2", user_role: '1', remember_created_at: Time.now)
User.create(full_name: 'user2', email: "user2@gmail.com", password: "usertest2", password_confirmation: "usertest2", user_role: '0', remember_created_at: Time.now, tags: ["tag1", "tag2"])
