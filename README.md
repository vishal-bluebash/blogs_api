
Blogs API is a rails based api application to create posts, create comments into posts, like to posts & comments

1. Clone the Repo
2. bundle install
3. Update config/database.yml (currently its sqlite3)
4. Request master key from repo owner
    - Create a file master.key in config folder
    - Copy the received key in config/master.key
5. Request environment specific credentials keys from repo owner
    - Create files master.key in config folder
6. bundle exec rake db:create
7. bundle exec rake db:migrate
8. bundle exec rake db:seed
    - Use dump if it is available
10. Start Rails server

Ruby - 2.6.5
Rails - 6.1.3


### Testing with Rspec & Documention with swagger

  - `RAILS_ENV=test bundle exec rails db:create`
  - `rails db:test:prepare`
  - `bundle exec rspec spec`
  - `rake rswag:specs:swaggerize (Generate api documentation)`


### Development notes ###
1. Used rspec for testing (Done Request test cases to demonstrate )
2. Active record serializer with on demand data
3. Swagger Stylye API documentation (Postman collection can be found here https://documenter.getpostman.com/view/7302433/UVRBnRfM)

