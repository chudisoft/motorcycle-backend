# spec/models/motorcycle_spec.rb
require 'rails_helper'

RSpec.describe Motorcycle, type: :model do
  it 'is valid with valid attributes' do
    motorcycle = Motorcycle.new(make: 'Honda', price: 10_000, license_plate: 'AB1234', image: 'image_url')
    expect(motorcycle).to be_valid
  end

  it 'is not valid without a make' do
    motorcycle = Motorcycle.new(price: 10_000, license_plate: 'AB1234', image: 'image_url')
    expect(motorcycle).to_not be_valid
  end

  it 'is not valid with a price less than 0' do
    motorcycle = Motorcycle.new(make: 'Honda', price: -10_000, license_plate: 'AB1234', image: 'image_url')
    expect(motorcycle).to_not be_valid
  end

  it 'has many reservations' do
    association = Motorcycle.reflect_on_association(:reservations)
    expect(association.macro).to eq(:has_many)
  end
end
