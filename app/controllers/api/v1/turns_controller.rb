module Api
  module V1
    class TurnsController < Api::V1::ApiController
      before_action :authenticate_user!
      before_action :set_turn, only: %i[update]

      def index
        search_turns = Turns::SearchTurnsService.new(params).search
        @turns = search_turns[:turns]
        @range_time = search_turns[:range_time]
      rescue StandardError => e
        render json: { message: e.message }, status: :error
      end

      def update
        availables = Turns::MakeAvailablesService.new(@turn, params).make
        if @turn.update(availables: availables)
          if Turns::AvailabilityService.new(@turn).complete?
            @turn = Turns::AssignService.new(@turn).assign
          end
        else
          render json: { message: @turn.errors }, status: :error
        end
      end

      private

      def set_turn
        @turn = Turn.find(params[:id])
      end
    end
  end
end
