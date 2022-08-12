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
FactoryBot.define do
  factory :contract do
    name { Faker::Name.unique.name }
    start_date { Faker::Date.between(from: '2022-08-12', to: '2022-08-12') }
    end_date { Faker::Date.between(from: '2022-08-12', to: '2022-12-31') }
    start_wday { rand(1..4) }
    start_hour { Contract::ALLOWED_HOURS.each_slice(12).to_a.first.sample }
    end_hour { Contract::ALLOWED_HOURS.each_slice(12).to_a.last.sample }
    end_wday { rand(5..7) }
    requested_by { FactoryBot.create(:user, role: User.roles[:client]) }
    accepted_by { FactoryBot.create(:user, role: User.roles[:admin]) }
  end
end
