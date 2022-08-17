module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :auth_user
      after_action :verify_policy_scoped, except: %i[index]

      def index
        users = Users::SearchUsersService.new(params).search
        render json: { users: users }, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: :error
      end

      def show; end

      def update
        current_user.update!(user_params)
        render :show
      end

      private

      def auth_user
        authorize current_user
      end

      def user_params
        params.require(:user).permit(:username, :first_name, :last_name, :email)
      end
    end
  end
end
