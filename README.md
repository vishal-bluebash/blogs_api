
Blogs API is a rails based api application to create posts, create comments into posts, like to posts & comments

1. Clone the Repo
2. bundle install
3. Update config/database.yml (currently its sqlite3)
4. Request master key from repo owner
    - Create a file master.key in config folder
    - Copy the received key in config/master.key
5. bundle exec rake db:create
6. bundle exec rake db:migrate
7. bundle exec rake db:seed
    - Use dump if it is available
8. Start Rails server

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
3. Swagger Style API documentation (Postman collection can be found here https://documenter.getpostman.com/view/7302433/UVRBnRfM)


### Rake tasks
  - ` bundle exec rake analytics:users`

<img width="1437" alt="Screenshot 2021-12-21 at 7 31 27 PM" src="https://user-images.githubusercontent.com/43650278/146942550-f786c57f-7064-4d5f-bec9-b165e4d6974e.png">
