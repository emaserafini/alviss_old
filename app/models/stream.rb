class Stream < ActiveRecord::Base
  enum kind: [ :temperature ]

  validates :name, presence: true
  validates :kind, presence: true

  before_destroy :delete_datapoints!

  def delete_datapoints!
    datapoint_class.destroy_all stream_id: id
  end

  def datapoints
    datapoint_class.of_stream(id)
  end

  def datapoint_class
    "datapoint/#{kind}".camelize.constantize
  end
end
