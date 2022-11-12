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

  branch_office = BranchOffice.new({name: "Sucursal 1", address: "Calle falsa 123", phone: "12345678"})

  branch_office.save!

  admin = AdminUser.new({username: "superadmin", email: "superadmin@tpi.com", password: "p4ssw0rd", password_confirmation: "p4ssw0rd", branch_office_id: branch_office.id})

  admin.add_role :admin
  admin.save!

  operador_bancario = AdminUser.new({username: "operador", email: "operador@tpi.com", password: "p4ssw0rd", password_confirmation: "p4ssw0rd", branch_office_id: branch_office.id})

  operador_bancario.save!

  user = User.new(
    
      {username: "client", email: "client@tpi.com", password: "p4ssw0rd", password_confirmation: "p4ssw0rd"}
    
  )
  
  user.save!

  puts "Adding roles admin, staff"

else
  puts "Users already created"
end

puts "Finish loading seeds"