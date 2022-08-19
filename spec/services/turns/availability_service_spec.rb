describe Turns::AvailabilityService do
  before do
    @expert = FactoryBot.create(:user, role: User.roles[:expert])
    @turn = FactoryBot.create(:turn, availables: @expert.id.to_s)
    @availability = described_class.new(@turn)
  end
  describe '#compelete' do
    it 'return a boolean' do
      expect(@availability.complete?).to be_in([true, false])
    end
  end
  describe '#sort_availables' do
    it 'return an Array' do
      expect(@availability.sort_availables.class).to eq(Array)
    end
  end
end
