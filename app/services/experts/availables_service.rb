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
  end
end
