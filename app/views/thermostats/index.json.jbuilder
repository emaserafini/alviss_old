json.array!(@thermostats) do |thermostat|
  json.extract! thermostat, :id, :mode, :status
  json.url thermostat_url(thermostat, format: :json)
end
