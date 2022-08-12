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
require 'rails_helper'

RSpec.describe Turn, type: :model do
  let!(:turn) { create(:turn) }

  context 'create a turn from factory with data valid' do
    it 'contract is an instance of turn' do
      expect(turn.class).to eq(Turn)
    end
  end
end
