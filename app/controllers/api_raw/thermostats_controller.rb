class ApiRaw::ThermostatsController < ActionController::Base

  def current_status
    render plain: thermostat.current_status
  end


  private

  def thermostat
    @thermostat ||= Thermostat.find_by_id(params[:thermostat_id])
  end
end
