module Turns
  class SearchTurnsService
    attr_reader :contract_id, :week, :year, :start_week, :end_week, :turns_of_week

    def initialize(params)
      @contract_id = params[:contract_id]
      @week = params[:week]
      @year = params[:year]
      calculate_period
    end

    def search
      Turn.where('date_hour >= ? AND date_hour <= ? AND contract_id = ?',
                 start_week, end_week, contract_id).order(date_hour: :asc)
    rescue StandardError => _e
      []
    end

    def calculate_period
      @start_week = Date.parse("#{year}W#{week}")
      @end_week = start_week.end_of_week
    end
  end
end
