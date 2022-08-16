module Turns
  class GenerateTurnsService
    attr_reader :contract, :number_turns_created

    def initialize(contract)
      @contract = contract
      @number_turns_created = 0
    end

    def generate
      raise 'contract not accepted' unless contract.accepted?

      days_contracted.each { |day| create_turn(day) }
      { number_turns_created: number_turns_created, message: 'ok' }
    rescue StandardError => e
      { number_turns_created: number_turns_created, message: e.message }
    end

    def days_contracted
      range(contract.start_date, contract.end_date).select do |day|
        range(contract.start_wday, contract.end_wday).include?(day.wday)
      end
    end

    def range(start_date, end_date)
      start_date.upto(end_date).to_a
    rescue StandardError => _e
      []
    end

    def create_turn(date)
      extract_hours_turns.each do |hour|
        Turn.create!(contract_id: contract.id,
                     date_hour: date.to_datetime.change(hour: hour.split(':').first.to_i))
        @number_turns_created += 1
      end
    end

    def extract_hours_turns
      allowed_hours = Contract::ALLOWED_HOURS
      start_index = allowed_hours.find_index(contract.start_hour)
      end_index = allowed_hours.find_index(contract.end_hour)
      allowed_hours[start_index..end_index]
    end
  end
end
