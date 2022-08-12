# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string           default("")
#  last_name              :string           default("")
#  username               :string           default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  tokens                 :json
#  role                   :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

describe User do
  describe 'validations' do
    subject { build :user }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }

    context 'when was created with regular login' do
      subject { build :user }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
      it { is_expected.to validate_presence_of(:email) }
    end
  end

  context 'when was created with regular login' do
    let!(:user) { create(:user, first_name: nil, last_name: nil) }
    let(:full_name) { user.full_name }

    it 'returns the correct name' do
      expect(full_name).to eq(user.username)
    end
  end

  context 'when user has first_name' do
    let!(:user) { create(:user, first_name: 'John', last_name: 'Doe') }

    it 'returns the correct name' do
      expect(user.full_name).to eq('John Doe')
    end
  end

  describe '.from_social_provider' do
    context 'when user does not exists' do
      let(:params) { attributes_for(:user) }

      it 'creates the user' do
        expect {
          User.from_social_provider('provider', params)
        }.to change { User.count }.by(1)
      end
    end

    context 'when the user exists' do
      let!(:user)  { create(:user, provider: 'provider', uid: 'user@example.com') }
      let(:params) { attributes_for(:user).merge('id' => 'user@example.com') }

      it 'returns the given user' do
        expect(User.from_social_provider('provider', params))
          .to eq(user)
      end
    end
  end

  context 'when user is created with an role' do
    describe 'when is created as admin' do
      let!(:user) { create(:user, role: User.roles[:admin]) }

      it 'return admin' do
        expect(user.role).to eq('admin')
      end

      it 'return the correct value' do
        expect(user.role_before_type_cast).to eq(User.roles[:admin])
      end
    end
    describe 'when is created as expert' do
      let!(:user) { create(:user, role: User.roles[:expert]) }

      it 'return expert' do
        expect(user.role).to eq('expert')
      end

      it 'return the correct value' do
        expect(user.role_before_type_cast).to eq(User.roles[:expert])
      end
    end
    describe 'when is created as client' do
      let!(:user) { create(:user, role: User.roles[:client]) }

      it 'return client' do
        expect(user.role).to eq('client')
      end

      it 'return the correct value' do
        expect(user.role_before_type_cast).to eq(User.roles[:client])
      end
    end
  end

  context 'check methods contracts' do
    describe '.requested_contracts' do
      let!(:user_admin) { create(:user, role: User.roles[:admin]) }
      let!(:user_expert) { create(:user, role: User.roles[:expert]) }
      let!(:user_client) { create(:user, role: User.roles[:client]) }

      it 'return an array blank' do
        expect(user_admin.requested_contracts).to eq([])
        expect(user_expert.requested_contracts).to eq([])
        expect(user_client.requested_contracts).to eq([])
      end
    end
    describe '.accepted_contracts' do
      let!(:user_admin) { create(:user, role: User.roles[:admin]) }
      let!(:user_expert) { create(:user, role: User.roles[:expert]) }
      let!(:user_client) { create(:user, role: User.roles[:client]) }

      it 'return an array blank' do
        expect(user_admin.accepted_contracts).to eq([])
        expect(user_expert.accepted_contracts).to eq([])
        expect(user_client.accepted_contracts).to eq([])
      end
    end
  end
end
