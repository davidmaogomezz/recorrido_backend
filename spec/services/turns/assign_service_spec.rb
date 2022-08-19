describe Turns::AssignService do
  before do
    FactoryBot.create(:user, role: User.roles[:expert])
    @turn = FactoryBot.create(:turn)
    @assign_service = described_class.new(@turn)
    @assign_service.assign
    @turn.reload
  end
  describe '#lower_value' do
    it 'attribute user_id is present' do
      expect(@turn.user_id.present?).to eq(true)
    end
  end
  describe '#lower_value' do
    it 'lower_value is 0' do
      expect(@assign_service.lower_value).to eq(0)
    end
  end
  describe '#lower_value' do
    it 'return array' do
      expect(@assign_service.users_with_minus_load.class).to eq(Array)
    end
  end
end
