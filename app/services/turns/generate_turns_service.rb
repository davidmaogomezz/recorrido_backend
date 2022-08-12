module Turns
  class GenerateTurnsService
    attr_reader :contract

    def initialize(contract)
      @contract = contract
      @week_start = calculate_when_start_week(contract.start_date)
      @week_end = calculate_when_start_week(contract.end_date)
    end

    def create; end

    def calculate_when_start_week(date)
      Date.parse("#{date.year}W#{date.cweek}")
    end
  end
end
