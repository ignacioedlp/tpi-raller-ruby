# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Loading seeds"
# Inserto los seeds solo en el caso en el que no exitan usuarios
if User.count == 0
  puts "Creating users admin, staff and client"

  users = User.create(
    [
      {username: "admin", email: "admin@tpi.com", password: "p4ssw0rd", password_confirmation: "p4ssw0rd"},
      {username: "staff", email: "staff@tpi.com", password: "p4ssw0rd", password_confirmation: "p4ssw0rd"},
      {username: "client", email: "client@tpi.com", password: "p4ssw0rd", password_confirmation: "p4ssw0rd"}
    ]
  )

  puts "Adding roles admin, staff"

  users[0].add_role(:admin)
  users[0].add_role(:staff)
  users[1].add_role(:staff)

else
  puts "Users already created"
end

puts "Finish loading seeds"
