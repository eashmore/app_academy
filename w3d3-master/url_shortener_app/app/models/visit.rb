class Visit < ActiveRecord::Base
  def self.record_visit!(user_id, shortened_url)
    Visit.create!(user_id: user_id, url_id: shortened_url)
  end

  belongs_to(
    :visited_url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )

  belongs_to(
    :visitor,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )


end
