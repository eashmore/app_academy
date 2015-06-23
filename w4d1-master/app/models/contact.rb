class Contact < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { scope: :user_id }

  belongs_to(
    :owner,
    class_name: 'User',
  )

  has_many(
    :contact_shares
  )

  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )
end
