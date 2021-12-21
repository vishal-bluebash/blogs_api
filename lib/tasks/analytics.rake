# frozen_string_literal: true

namespace :analytics do
  desc "Generate analytics"
  task users: :environment do
    puts "a) Total number of likes and comments a user received for each of his/her post"
    puts "b) List of all users(having at least one post) and count of their posts"
    puts "Chooes a/b to continue"

    user_input = STDIN.gets.strip

    if user_input == "a"
      puts Post.left_joins(:likes, :comments)
               .select("posts.id AS post_id, COUNT(likes.id) AS likes_count ,COUNT(comments.id) AS comments_count")
               .group("posts.id").map { |x| { post_id: x.post_id, comment_count: x.comments_count, likes_count: x.likes_count } }
    elsif user_input == "b"
      puts User.joins(:posts)
               .select("users.id AS user_id, COUNT(posts.id) AS posts_count")
               .group("users.id").map { |x| { user_id: x.user_id, number_of_posts: x.posts_count } }
    else
      puts "try again!!"
    end
  end
end
