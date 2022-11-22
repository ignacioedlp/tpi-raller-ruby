# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Loading seeds"
# Inserto los seeds solo en el caso en el que no exitan usuarios

  puts "Creating users admin, staff and client"

  branch_office = BranchOffice.create!({name: "Sucursal 1", address: "Calle falsa 123", phone: "12345678"})
  branch_office2 = BranchOffice.create!({name: "Sucursal 2", address: "Calle falsa 123", phone: "12345678"})
  branch_office3 = BranchOffice.create!({name: "Sucursal 3", address: "Calle falsa 123", phone: "12345678"})
  branch_office4 = BranchOffice.create!({name: "Sucursal 4", address: "Calle falsa 123", phone: "12345678"})
  branch_office5 = BranchOffice.create!({name: "Sucursal 5", address: "Calle falsa 123", phone: "12345678"})
  


  lunes = OpeningHour.create!({day: 0, opens: "08:00", closes: "18:00", branch_office_id: branch_office.id})
  martes = OpeningHour.create!({day: 1, opens: "08:00", closes: "18:00", branch_office_id: branch_office.id})
  miercoles = OpeningHour.create!({day: 2, opens: "08:00", closes: "18:00", branch_office_id: branch_office.id})

  jueves = OpeningHour.create!({day: 3, opens: "08:00", closes: "18:00", branch_office_id: branch_office2.id})
  viernes = OpeningHour.create!({day: 4, opens: "08:00", closes: "18:00", branch_office_id: branch_office2.id})
  sabado = OpeningHour.create!({day: 5, opens: "08:00", closes: "18:00", branch_office_id: branch_office2.id})


  admin = AdminUser.create!({username: "administrador", email: "administrador@tpi.com", password: "password", password_confirmation: "password"})

  admin.add_role :admin

  operador_bancario = AdminUser.create!({username: "operador", email: "operador@tpi.com", password: "password", password_confirmation: "password", branch_office_id: branch_office.id})

  user = User.create!({username: "cliente", email: "cliente@tpi.com", password: "password", password_confirmation: "password"})

  turno = Shift.create!({user_id: user.id, branch_office_id: branch_office.id, day: 1, hour: "08:00"})
  turno2 = Shift.create!({user_id: user.id, branch_office_id: branch_office.id, day: 2, hour: "08:00"})
  turno3 = Shift.create!({user_id: user.id, branch_office_id: branch_office2.id, day: 3, hour: "08:00"})
  turno4 = Shift.create!({user_id: user.id, branch_office_id: branch_office2.id, day: 4, hour: "08:00"})
  turno5 = Shift.create!({user_id: user.id, branch_office_id: branch_office2.id, day: 5, hour: "08:00"})


puts "Finish loading seeds"