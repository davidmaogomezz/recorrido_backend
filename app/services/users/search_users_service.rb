module Users
  class SearchUsersService
    attr_reader :role

    def initialize(params)
      @role = params[:role]
    end

    def search
      User.where(role: role)
    rescue StandardError => _e
      []
    end
  end
end
