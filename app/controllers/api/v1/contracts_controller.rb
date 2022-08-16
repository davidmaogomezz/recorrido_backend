module Api
  module V1
    class ContractsController < Api::V1::ApiController
      before_action :authenticate_user!
      after_action :verify_policy_scoped, except: %i[index]

      def index
        contracts = Contracts::SearchContractsService.new.search
        render json: { contracts: contracts }, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: :error
      end
    end
  end
end
