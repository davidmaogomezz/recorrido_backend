# == Schema Information
#
# Table name: contracts
#
#  id              :bigint           not null, primary key
#  name            :string
#  start_date      :date
#  end_date        :date
#  start_wday      :integer
#  start_hour      :string
#  end_hour        :string
#  end_wday        :integer
#  requested_by_id :bigint
#  accepted_by_id  :bigint
#  state           :integer          default("generated")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_contracts_on_accepted_by_id   (accepted_by_id)
#  index_contracts_on_requested_by_id  (requested_by_id)
#
class Contract < ApplicationRecord
  ALLOWED_HOURS = 0.upto(23).map { |i| "#{i}:00" }

  has_many :turns, dependent: :destroy

  belongs_to :requested_by, class_name: 'User'
  belongs_to :accepted_by, class_name: 'User', optional: true

  enum state: { generated: 0, accepted: 1, refused: 2 }

  validates :name, :start_date, :end_date, :start_wday, :start_hour, :end_hour, :requested_by_id,
            :end_wday, presence: true

  validate :end_date_greater_or_equal_to_start_date?

  validates :start_wday, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }

  validates :start_hour, :end_hour, inclusion: ALLOWED_HOURS

  validate :end_hour_greater_or_equal_to_start_hour?

  validates :end_wday, numericality: { greater_than_or_equal_to: :start_wday,
                                       less_than_or_equal_to: 6 }

  after_update :create_turns, if: %i[can_create_turns?]

  def end_date_greater_or_equal_to_start_date?
    return unless end_date < start_date

    errors.add(:end_date, 'must be greather than or equal to start date')
  end

  def end_hour_greater_or_equal_to_start_hour?
    return unless ALLOWED_HOURS.find_index(end_hour) < ALLOWED_HOURS.find_index(start_hour)

    errors.add(:end_hour, 'must be greather than or equal to start hour')
  end

  def can_create_turns?
    state == Contract.states.keys[1] && turns.size.zero?
  end

  def create_turns
    Turns::GenerateTurnsService.new(self).generate
  end
end
