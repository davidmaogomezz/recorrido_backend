module Turns
  class GenerateTurnsService
    attr_reader :contract

    def initialize(contract)
      @contract = contract
    end

    def create
      range_years.each { |year| iterate_weeks(year) }
    end

    def iterate_weeks(year)
      range_weeks(year).each { |cweek| create_turns_to_cweek(year, cweek) }
    end

    def create_turns_to_cweek(year, cweek)
      begin_week = calculate_when_start_week(year, cweek)
      days_with_turns = extract_days_with_turns(begin_week)
      days_with_turns.each { |date| create_turn(date) }
    end

    def create_turn(date)
      extract_hours_turns.each do |hour|
        Turn.create!(contract_id: contract.id,
                     date_hour: date.to_datetime.change(hour: hour.split(':').first.to_i))
      end
    end

    def extract_days_with_turns(begin_week)
      (contract.start_wday..contract.end_wday).to_a.map do |day_with_turn|
        begin_week + day_with_turn.day
      end
    end

    def extract_hours_turns
      allowed_hours = Contract::ALLOWED_HOURS
      start_index = allowed_hours.find_index(contract.start_hour)
      end_index = allowed_hours.find_index(contract.end_hour)
      allowed_hours[start_index..end_index]
    end

    def range_years
      (contract.start_date.year..contract.end_date.year).to_a
    end

    def range_weeks(year)
      (from_week(year)..until_week(year)).to_a
    end

    def from_week(year)
      return contract.start_date.cweek if year == contract.start_date.year

      1
    end

    def until_week(year)
      return contract.end_date.cweek if contract.end_date.year == year

      52
    end

    def calculate_when_start_week(year, cweek)
      Date.parse("#{year}W#{cweek}")
    end
  end
end
