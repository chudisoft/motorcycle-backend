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
  role: "admin"
)

# Create a Regular User
User.create!(
  name: "Regular User",
  email: "user@domain.com",
  password: "User.1234",
  role: "user"
)

# Add 5 different greetings

puts 'Seeding completed successfully!'
