module Turns
  class AssignService
    attr_reader :turn

    def initialize(turn)
      @turn = turn
      assign
      @turn.reload
    end

    def assign
      # TODO: Assign turn to expert according to load
      turn.update(user_id: 4)
    rescue StandardError => _e
      false
    end
  end
end
