require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      name: 'Ghost',
      email: 'ghost@gmail.com',
      password: '1234567',
      password_confirmation: '1234567'
    )
  end
  before { user.save }
  context 'validity' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end
    it 'is not valid without a name' do
      expect(user.name).to eq('Ghost')
    end
    it 'shows the exact users email' do
      expect(user.email).to eq('ghost@gmail.com')
    end
    it 'shows the exact users password' do
      expect(user.password).to eq('1234567')
    end
    it 'shows the exact users password' do
      expect(user.password_confirmation).to eq('1234567')
    end
  end
  context 'invialidity:' do
    it 'is not valid when name is not present' do
      user.name = nil
      expect(user).not_to be_valid
    end
  end
end
