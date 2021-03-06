# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  belongs_to :sub
  belongs_to(
    :author,
    class_name: 'User'
  )
  has_many :post_subs
  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )
  has_many :comments
end
