module Contracts
  class SearchContractsService
    def search
      current_moment = Time.now
      contracts = Contract.where("start_date <= ? AND end_date >= ?", current_moment, current_moment).order(created_at: :asc)
    rescue StandardError => _e
      []
    end
  end
end
