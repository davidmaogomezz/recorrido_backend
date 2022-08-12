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
require 'rails_helper'

RSpec.describe Contract, type: :model do
  let!(:contract) { create(:contract) }

  context 'create a contract from factory with data valid' do
    it 'contract is an instance of Contract' do
      expect(contract.class).to eq(Contract)
    end
    it 'attribute name is present' do
      expect(contract.name.class).to eq(String)
    end
    it 'attribute start_date is Date' do
      expect(contract.start_date.class).to eq(Date)
    end
    it 'attribute end_date is Date' do
      expect(contract.end_date.class).to eq(Date)
    end
    it 'end_date is greater_than_or_equal_to start_date' do
      expect(contract.end_date).to be >= contract.start_date
    end
    it 'attribute start_wday is Integer' do
      expect(contract.start_wday.class).to eq(Integer)
    end
    it 'attribute start_hour is String' do
      expect(contract.start_hour.class).to eq(String)
    end
    it 'start_wday, end_wday are between 1 and 7' do
      expect(contract.start_wday).to be_between(1, 7)
      expect(contract.end_wday).to be_between(1, 7)
    end
    it 'end_wday is greater_than_or_equal_to start_wday' do
      expect(contract.end_wday).to be >= contract.start_wday
    end
    it 'attribute end_hour is String' do
      expect(contract.end_hour.class).to eq(String)
    end
    it 'end_hour is greater_than_or_equal_to start_hour' do
      index_end_hour = Contract::ALLOWED_HOURS.find_index(contract.end_hour)
      index_start_hour = Contract::ALLOWED_HOURS.find_index(contract.start_hour)
      expect(index_end_hour).to be >= index_start_hour
    end
    it 'attribute end_wday is Integer' do
      expect(contract.end_wday.class).to eq(Integer)
    end
    it 'attribute requested_by is an instance of User' do
      expect(contract.requested_by.class).to eq(User)
    end
    it 'attribute accepted_by is an instance of User' do
      expect(contract.accepted_by.class).to eq(User)
    end
    it 'attribute state is an instance of Integer' do
      expect(contract.state.class).to eq(String)
    end
    it 'attribute state is equal to generated' do
      expect(contract.state).to eq(Contract.states.keys.first)
    end
  end
end
