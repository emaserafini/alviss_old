class ManualMode < ActiveRecord::Base
  belongs_to :thermostat
  belongs_to :feed_temperature, class_name: 'Feed', foreign_key: 'feed_temperature_id'
  belongs_to :feed_status, class_name: 'Feed', foreign_key: 'feed_status_id'
end
