class WeeklySchedule
  attr_reader :schedule

  def initialize raw_schedule = nil
    build_schedule raw_schedule if raw_schedule
  end

  Activity = Struct.new :time, :temp, :status

  def daily_schedule wday = DateTime.now.wday
    schedule[wday]
  end

  def activities_times wday
    daily_schedule(wday).map(&:time).sort
  end

  def activity_for wday, time_of_day
    return nil unless wdays_index.include? wday
    time = matching_time(weekdays[wday], TimeOfDay.parse(time_of_day))
    if time
      return daily_schedule(weekdays[wday]).find{ |s| s.time == time }
    else
      activity_for wday - 1, '23:59'
    end
  end

  def build_schedule raw
    @schedule = weekdays.map do |day|
      raw.fetch(day, []).map do |raw_activity|
        build_activity(raw_activity)
      end.compact
    end
  end

  def current_activity
    activity_for Time.now.wday, TimeOfDay(Time.now)
  end


  private

  def matching_time wday, tod
    activities_times(wday).delete_if{ |time| time > tod }.last
  end

  def weekdays
    (0..6).to_a
  end

  def wdays_index
    (-6..6).to_a
  end

  def build_activity raw
    if TimeOfDay.parsable? raw[:time]
      Activity.new TimeOfDay.parse(raw[:time]), raw[:temp], raw[:status]
    end
  end
end