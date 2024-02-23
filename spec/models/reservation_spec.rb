require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) do
    User.new(
      name: 'Chris',
      email: 'Chris@gmail.com',
      password: '1234567',
      password_confirmation: '1234567'
    )
  end
  let(:motorcycle) do
    Motorcycle.new(
      name: 'Power Byke',
      description: 'This is big ride and fast',
      price: 200,
      image: 'image1.jpg',
      license_plate: 'AX220D',
      user:
    )
  end
  let(:reservation) do
    Reservation.new(
      reserve_time: '14:15',
      reserve_date: '14-02-2023',
      user:,
      motorcycle:
    )
  end
  before { reservation.save }
  before { user.save }
  before { motorcycle.save }
  context 'validity' do
    it 'is valid with valid attributes' do
      expect(reservation).to be_valid
    end
    it 'is not valid without reservation time' do
      expect(reservation.reserve_time.strftime('%H:%M')).to eq('14:15')
    end
    it 'shows the exact reservation date' do
      expect(reservation.reserve_date.strftime('%d-%m-%Y')).to eq('14-02-2023')
    end
  end
  context 'invalidity:' do
    it 'is not valid when time is not present' do
      reservation.reserve_time = nil
      expect(reservation).not_to be_valid
    end
    it 'is not valid when date is not present' do
      reservation.reserve_date = nil
      expect(reservation).not_to be_valid
    end
  end
end
