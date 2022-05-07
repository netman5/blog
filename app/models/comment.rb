class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post


  def comment_counters
    counts = Comment.where(post_id: post_id).count
    post = Post.find(post_id)
    post.update(comments_counter: counts)
  end
end
