describe Turns::GenerateTurnsService do
  describe '#create' do
    context 'When status contract is generated' do
      before do
        @contract = FactoryBot.create(:contract)
        @generate_turns = described_class.new(@contract).generate
        @contract.reload
      end
      it 'number_turns_created is equal to 0' do
        expect(@generate_turns[:number_turns_created]).to eq(0)
      end
      it 'turns of contracts is eq to 0' do
        expect(@contract.turns.size).to eq(0)
      end
      it 'messages is qual to' do
        expect(@generate_turns[:message]).to eq('contract not accepted')
      end
    end
    context 'When status contract is accepted' do
      before do
        @contract = FactoryBot.create(:contract, state: 'accepted')
        @generate_turns = described_class.new(@contract).generate
        @contract.reload
      end
      it 'check number_turns_created is equal to 480' do
        expect(@generate_turns[:number_turns_created]).to eq(480)
      end
      it 'turns of contracts is eq to 480' do
        expect(@contract.turns.size).to eq(480)
      end
      it 'messages is qual to' do
        expect(@generate_turns[:message]).to eq('ok')
      end
    end
    context 'Check all days of 2023 in all turns' do
      before do
        @contract = FactoryBot.create(:contract, start_date: '2023-01-02', end_date: '2023-12-31',
                                                 state: 'accepted')
        @generate_turns = described_class.new(@contract).generate
        @contract.reload
      end
      it 'check number_turns_created is equal to 8736' do
        expect(@generate_turns[:number_turns_created]).to eq(8736)
      end
      it 'turns of contracts is eq to 8736' do
        expect(@contract.turns.size).to eq(8736)
      end
      it 'messages is qual to' do
        expect(@generate_turns[:message]).to eq('ok')
      end
    end
  end
end
