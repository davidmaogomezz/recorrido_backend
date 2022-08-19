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
      start_week = calculate_start_week(turn)
      end_week = start_week.end_of_week
      object_load = []
      users.each do |user|
        object_load << { user: user, load: user.turns.where(date_hour: start_week..end_week).size }
      end
      object_load
    rescue StandardError => _e
      []
    end

    def calculate_cweek(turn)
      turn.date_hour.strftime('%-V').to_i
    end

    def calculate_start_week(turn)
      Date.parse("#{turn.date_hour.year}W#{calculate_cweek(turn)}")
    end

    def extract_cweek(turn)
      turn.date_hour.strftime('%-V').to_i
    end
  end
end
