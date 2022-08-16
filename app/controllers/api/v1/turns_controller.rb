module Api
  module V1
    class TurnsController < Api::V1::ApiController
      before_action :authenticate_user!
      after_action :verify_policy_scoped, except: %i[index]

      def index
        turns = Turns::SearchTurnsService.new(params).search
        render json: { turns: turns }, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: :error
      end
    end
  end
end
