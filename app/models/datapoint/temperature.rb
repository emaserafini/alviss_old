class Datapoint::Temperature < ActiveRecord::Base
  enum scale: [ :celsius, :fahrenheit ]

  validates :stream, presence: true
  validates :value, numericality: true
  validates :scale, presence: true

  belongs_to :stream

  scope :of_stream, -> (id) { where(stream_id: id) }
end
