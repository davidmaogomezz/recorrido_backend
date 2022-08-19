describe Turns::MakeAvailablesService do
  before do
    @expert_one = FactoryBot.create(:user, role: User.roles[:expert])
    @expert_two = FactoryBot.create(:user, role: User.roles[:expert])
    @turn = FactoryBot.create(:turn, availables: @expert_one.id.to_s)
  end
  describe 'operation add' do
    before do
      Turns::MakeAvailablesService.new(@turn,
                                       { object_turn: { user_id: @expert_two.id,
                                                        operation: 'add' } }).make
      @turn.reload
    end
    it 'return a boolean' do
      expect(@turn.availables.class).to eq(String)
    end
  end
  describe 'operation remove' do
    before do
      Turns::MakeAvailablesService.new(@turn,
                                       { object_turn: { user_id: @expert_two.id,
                                                        operation: 'remove' } }).make
      @turn.reload
    end
    it 'return a boolean' do
      expect(@turn.availables.class).to eq(String)
    end
  end
end
