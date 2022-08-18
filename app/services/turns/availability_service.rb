module Turns
  class AvailabilityService
    attr_reader :turn, :availables, :experts_availables

    def initialize(turn)
      @turn = turn
      @availables = turn&.availables&.split(',') || []
      @experts_availables = Experts::AvailablesService.new
    end

    def complete?
      availables.size == experts_availables.count && sort_availables == experts_availables.show_ids
    rescue StandardError => _e
      false
    end

    def sort_availables
      availables.map { |available| available.strip.to_i }.sort
    rescue StandardError => _e
      false
    end
  end
end
