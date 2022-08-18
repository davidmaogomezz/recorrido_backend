module Turns
  class AssignService
    attr_reader :turn, :object_load

    def initialize(turn)
      @turn = turn
      @experts_availables = Experts::AvailablesService.new
      @object_load = @experts_availables.calculate_load(turn)
    end

    def assign
      lower_value = object_load.pluck(:load).sort.first
      users_with_minus_load = object_load.select { |user_load| user_load[:load] == lower_value }
      user = users_with_minus_load.sample[:user]
      turn.update(user_id: user.id)
      turn.reload
    rescue StandardError => _e
      turn.update(user_id: @experts_availables.show_ids.sample)
    end
  end
end
