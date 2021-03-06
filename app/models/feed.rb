class Feed < ActiveRecord::Base

  def data_kind_class
    data_kind.camelize.constantize
  end

  def data
    data_kind_class.from_feed(id)
  end

  def latest_data(num = 1)
    data.latest num
  end
end
