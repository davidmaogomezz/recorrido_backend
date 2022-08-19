module Turns
  class SelectTurns
    def run
      time = Time.zone.now
      hour = (time + 1.hour).strftime('%H').to_i
      turns_day = Turn.where(user_id: nil, date_hour: time.beginning_of_day..time.end_of_day)
      turns_next_hour = turns_day.where("DATE_PART('hour', date_hour) = ?", hour)
      turns_next_hour.each { |turn| AssignService.new(turn).assign }
    rescue StandardError => _e
      []
    end
  end
end
