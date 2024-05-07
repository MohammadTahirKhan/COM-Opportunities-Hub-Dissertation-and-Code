# COM Opportunities Hub: An efficiency based approach for managing student/staff opportunities
A Web Application to post, manage, browse and track opportunities for students and staff in the department of Computer Science at the University of Sheffield.

## Getting Started
### Dependencies
* Ruby 3.1.2
* Rails 7.0.8
* PostgreSQL 14

### Installing
* Clone the repository
* Ensure the postgresql server is running with `sudo service postgresql start`
* Run `bundle install` to install Ruby dependencies 
* Run `yarn install` to install JavaScript dependencies
* Run `rails db:setup` to create the database and seed it with default data
* Run `bin/shakapacker -w` to start the shakapacker server
* Run `bundle exec rails s` in another terminal to start the server

### URLs
* The server will be running on `https://localhost:3000`

### Testing
To run the automated tests, run
`rspec`

** Please look at the `db/seeds.rb` file to see the default users that are added **