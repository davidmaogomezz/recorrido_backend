module Api
  module V1
    class TurnsController < Api::V1::ApiController
      before_action :authenticate_user!
      before_action :set_turn, only: %i[update]

      def index
        turns = Turns::SearchTurnsService.new(params).search
        render json: { turns: turns }, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: :error
      end

      def update
        availables = Turns::MakeAvailablesService.new(@turn, params).make
        if @turn.update(availables: availables)
          render json: { turn: @turn }, status: :ok
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
