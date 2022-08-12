# == Schema Information
#
# Table name: turns
#
#  id          :bigint           not null, primary key
#  contract_id :bigint           not null
#  date_hour   :datetime
#  availables  :string
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_turns_on_contract_id  (contract_id)
#  index_turns_on_user_id      (user_id)
#
FactoryBot.define do
  factory :turn do
    contract { FactoryBot.create(:contract) }
    date_hour { Faker::Date.between(from: '2022-08-12 00:00', to: '2022-08-12 23:59') }
    availables { '' }
    user { nil }
  end
end
