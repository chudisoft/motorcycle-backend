require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password')
    motorcycle = Motorcycle.create(make: 'Honda', price: 10_000, license_plate: 'AB1234', image: 'image_url')
    reservation = Reservation.new(user:, motorcycle:, reserve_time: '09:00', reserve_date: Date.today)
    expect(reservation).to be_valid
  end

  it 'is not valid without a reserve_time' do
    reservation = Reservation.new(reserve_date: Date.today)
    expect(reservation).not_to be_valid
  end

  it 'is not valid without a reserve_date' do
    reservation = Reservation.new(reserve_time: '09:00')
    expect(reservation).not_to be_valid
  end
end
