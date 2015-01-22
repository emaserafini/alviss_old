class Thermostat < ActiveRecord::Base
  enum mode:   [:inactive, :active, :auto, :manual]
  enum status: [:off, :on, :unknown]

  def current_status
    status
  end
end
