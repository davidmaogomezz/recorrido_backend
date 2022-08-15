describe Turns::GenerateTurnsService do
  let!(:contract) { FactoryBot.create(:contract) }
  describe '#create' do
    subject do
      described_class.new(contract).create
    end
    context 'When status contract is generated' do
      it 'number_contracts_created is equal to 0' do
        expect(subject[:number_contracts_created]).to eq(0)
      end
      it 'messages is qual to' do
        expect(subject[:message]).to eq('contract not accepted')
      end
    end
  end
end

