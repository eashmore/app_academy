# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :string           not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  belongs_to(:moderator, class_name: 'User')
  has_many :posts
  has_many :post_subs
  has_many(
    :post_post,
    through: :post_subs,
    source: :post
)
end
