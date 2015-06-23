# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  author_id         :integer
#  post_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true

  belongs_to(
    :author,
    class_name: "User"
  )

  belongs_to :post

  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

  has_one(
    :parent_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

end
