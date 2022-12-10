
puts "Iniciando carga de seeds"
sucursal_la_plata = BranchOffice.create!({name: "La Plata 1", address: "Calle falsa 123", phone: "12345678"})
sucursal_buenos_aires = BranchOffice.create!({name: "Buenos Aires 1", address: "Calle falsa 123", phone: "12345678"})
sucursal_rosario = BranchOffice.create!({name: "Rosario 1", address: "Calle falsa 123", phone: "12345678"})


puts "Sucursales cargadas 🚀"

for branch_office in BranchOffice.all
  for i in 1..7
    OpeningHour.create!({day: i, opens: "08:00", closes: "18:00", branch_office_id: branch_office.id})
  end
end

puts "Horarios cargados 🚀"

Role.create!({name: "admin"})
Role.create!({name: "staff"})

puts "Roles cargados 🚀"

administrador = AdminUser.create!({username: "admin", email: "admin@turno5.com", password: "password", password_confirmation: "password", roles: [Role.find_by(name: "admin")]})


operador_bancario_la_plata = AdminUser.create!({username: "operador_lp", email: "operoperador_lpador@turno5.com", password: "password", password_confirmation: "password", branch_office_id: sucursal_la_plata.id, roles: [Role.find_by(name: "staff")]})

operador_bancario_buenos_aires = AdminUser.create!({username: "operador_bsas", email: "operador_bsas@turno5.com", password: "password", password_confirmation: "password", branch_office_id: sucursal_buenos_aires.id, roles: [Role.find_by(name: "staff")]})

operador_bancario_rosario = AdminUser.create!({username: "operador_ros", email: "operador_ros@turno5.com", password: "password", password_confirmation: "password", branch_office_id: sucursal_rosario.id, roles: [Role.find_by(name: "staff")]})

puts "Empleados cargados 🚀"

ignacio = User.create!({username: "ignacio", email: "ignacio@gmail.com", password: "password", password_confirmation: "password"})

agus = User.create!({username: "agustin", email: "agustin@gmail.com", password: "password", password_confirmation: "password"})

juan = User.create!({username: "juan", email: "juan@gmail.com", password: "password", password_confirmation: "password"})

puts "Clientes cargados 🚀"

turno_1_ignacio = Shift.create!(date: "2022-12-12 10:00:00", branch_office_id: sucursal_la_plata.id, user_id: ignacio.id, reason: "Retiro de dinero")
turno_1_agus = Shift.create!(date: "2022-12-12 10:00:00", branch_office_id: sucursal_buenos_aires.id, user_id: agus.id, reason: "Problema con la tarjeta")
turno_1_juan = Shift.create!(date: "2022-12-12 10:00:00", branch_office_id: sucursal_rosario.id, user_id: juan.id, reason: "Problema con la cuenta")

puts "Turnos cargados pendientes 🚀"

puts "Seeds cargados 🚀"
