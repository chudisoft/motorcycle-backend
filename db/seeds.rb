# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all

# Create an Admin User
User.create!(
  name: "Admin User",
  email: "admin@domain.com",
  password: "Admin.1234",
  password_confirmation: "Admin.1234",
  role: :admin
)

# Create a Regular User
User.create!(
  name: "Regular User",
  email: "user@domain.com",
  password: "User.1234",
  password_confirmation: "User.1234",
  role: :user
)

Motorcycle.destroy_all

# Add 5 different greetings
motorcycles = [
  'M1',
  'M2',
  'M3',
]

motorcycles.each do |m|
  Motorcycle.create(
    name: m, license_plate: "ABC-123",
    color: "Black", price: 100.00, available: true,
    image: "https://via.placeholder.com/150",
    user: User.first
  )
end

puts 'Seeding completed successfully!'
