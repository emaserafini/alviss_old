class Thermostat < ActiveRecord::Base
  enum mode:   [:inactive, :active, :auto, :manual]
  enum status: [:off, :on, :unknown]
end
