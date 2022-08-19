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
      range = range_time
      turns = Turn.where(contract_id: contract_id, date_hour: range).order(date_hour: :asc)
      { turns: turns, range_time: range, message: "Se encontraron #{turns.size} turnos" }
    rescue StandardError => _e
      { turns: [], range_time: range, message: 'No se encontraron turnos' }
    end

    def range_time
      (start_week.beginning_of_day)..(end_week.end_of_day)
    end

    def calculate_period
      @start_week = Date.parse("#{year}W#{week}")
      @end_week = start_week.end_of_week
    end
  end
end
