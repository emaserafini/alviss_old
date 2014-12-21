class DataTemperature < ActiveRecord::Base
  belongs_to :feed

  scope :from_feed, -> (id) { where(feed_id: id) }
end
