module Turns
  class MakeAvailablesService
    attr_reader :params, :availables, :operation

    def initialize(turn, params)
      @params = params[:object_turn]
      @availables = turn&.availables&.split(',') || []
      @operation = params[:operation]
    end

    def make
      case operation
      when 'add'
        add
      when 'remove'
        remove
      end
      return if availables.empty?

      availables.join(',')
    end

    def add
      expert_id = params[:user_id]
      return if availables.include?(expert_id.to_s) || expert_id.blank?

      @availables.push(expert_id)
    end

    def remove
      expert_id = params[:user_id]
      @availables.delete(expert_id.to_s) if expert_id.present?
    end
  end
end
