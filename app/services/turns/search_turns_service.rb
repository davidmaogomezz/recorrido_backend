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
      @turns_of_week = Turn.where('date_hour >= ? AND date_hour <= ? AND contract_id = ?',
                                  start_week, end_week, contract_id).order(date_hour: :asc)
      group_by_day
    rescue StandardError => _e
      []
    end

    def calculate_period
      @start_week = Date.parse("#{year}W#{week}")
      @end_week = start_week.end_of_week
    end

    def group_by_day
      turns_of_week.group_by { |turn| turn.date_hour.strftime('%d/%m/%Y').to_s }
    end
  end
end
