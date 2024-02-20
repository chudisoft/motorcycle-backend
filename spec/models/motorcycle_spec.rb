require 'rails_helper'

RSpec.describe Motorcycle, type: :model do
  let(:user) do
    User.new(
      name: 'Chris',
      email: 'chris@gmail.com',
      password: '1234567',
      password_confirmation: '1234567'
    )
  end
  let(:motorcycle) do
    Motorcycle.new(
      name: 'Power Byke',
      description: 'This is big ride and fast',
      price: 200,
      license_plate: 'AX220D',
      image: 'image1.jpg',
      user:
    )
  end
  before { user.save }
  before { motorcycle.save }
  context 'validity' do
    it 'is valid with valid attributes' do
      expect(motorcycle).to be_valid
    end
    it 'is not valid without motorcycle name' do
      expect(motorcycle.name).to eq('Power Byke')
    end
    it 'shows the exact motorcycle description' do
      expect(motorcycle.description).to eq('This is big ride and fast')
    end
    it 'shows the exact motorcycle price' do
      expect(motorcycle.price).to eq(200)
    end
    it 'shows the exact motorcycle image' do
      expect(motorcycle.image).to eq('image1.jpg')
    end
    it 'shows the exact motorcycle license_plate' do
      expect(motorcycle.license_plate).to eq('AX220D')
    end
  end
  context 'invialidity:' do
    it 'is not valid when name is not present' do
      motorcycle.name = nil
      expect(motorcycle).not_to be_valid
    end
    it 'is not valid when price is not present' do
      motorcycle.price = nil
      expect(motorcycle).not_to be_valid
    end
    it 'is not valid when image is not present' do
      motorcycle.image = nil
      expect(motorcycle).not_to be_valid
    end
    it 'is not valid when license_plate is not present' do
      motorcycle.license_plate = nil
      expect(motorcycle).not_to be_valid
    end
  end
end
