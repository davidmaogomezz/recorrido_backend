module Experts
  class AvailablesService
    attr_reader :users

    def initialize
      @users = User.experts
    end

    def count
      users.size
    rescue StandardError => _e
      0
    end

    def show_ids
      users.pluck(:id).sort
    rescue StandardError => _e
      0
    end

    def calculate_load(turn)
      cweek = turn.date_hour.strftime('%-V').to_i
      start_week = calculate_start_week(turn.date_hour.year, cweek)
      end_week = start_week + 6.days
      end_week = start_week.end_of_week
      object_load = []
      users.each { |user| object_load << { user: user, load: user.turns.where(date_hour: start_week..end_week).size } }
      object_load
    rescue StandardError => _e
      []
    end

    def calculate_start_week(year, cweek)
      Date.parse("#{year}W#{cweek}")
    end

    def extract_cweek(turn)
      turn.date_hour.strftime('%-V').to_i
    end
  end
end
