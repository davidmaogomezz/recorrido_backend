describe Experts::AvailablesService do
  before do
    FactoryBot.create(:user, role: User.roles[:admin])
    FactoryBot.create(:user, role: User.roles[:expert])
    @availables_service = described_class.new
  end
  describe '#count' do
    it 'count is eq to 1' do
      expect(@availables_service.count).to eq(1)
    end
  end
  describe '#show_ids' do
    it 'eq to array of string' do
      expect(@availables_service.show_ids).to eq([User.where(role: 'expert').last.id])
    end
  end
  describe '#calculate_load' do
    before do
      @turn = FactoryBot.create(:turn)
      @calculate_load = @availables_service.calculate_load(@turn)
    end
    it 'size is eq to 1' do
      expect(@calculate_load.size).to eq(1)
    end
    it 'eq class to array' do
      expect(@calculate_load.class).to eq(Array)
    end
    it 'attribute user is eq to User' do
      expect(@calculate_load.first[:user].class).to eq(User)
    end
    it 'attribute load is eq to Integer' do
      expect(@calculate_load.first[:load].class).to eq(Integer)
    end
  end
  describe '#calculate_week' do
    before do
      @turn = FactoryBot.create(:turn)
      @calculate_week = @availables_service.calculate_cweek(@turn)
    end
    it 'week is integer' do
      expect(@calculate_week.class).to eq(Integer)
    end
  end
  describe '#calculate_start_week' do
    before do
      @turn = FactoryBot.create(:turn)
      @calculate_start_week = @availables_service.calculate_start_week(@turn)
    end
    it 'week is integer' do
      expect(@calculate_start_week.class).to eq(Date)
    end
  end
  describe '#extract_cweek' do
    before do
      @turn = FactoryBot.create(:turn)
      @extract_cweek = @availables_service.calculate_cweek(@turn)
    end
    it 'week is integer' do
      expect(@extract_cweek.class).to eq(Integer)
    end
  end
end
