require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(:submitter_id => user,
                         :long_url => long_url,
                         :short_url => short_url)
  end

  def self.random_code
    short_url = SecureRandom.urlsafe_base64
    ShortenedUrl.random_code if ShortenedUrl.exists?(short_url)
    short_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where({ created_at: (10.minutes.ago)..Time.now }).count
  end

  def self.find_by_short_url(url)
    begin
      ShortenedUrl.find_by(short_url: url).long_url
    rescue
      raise "Invalid short URL"
    end
  end

end
