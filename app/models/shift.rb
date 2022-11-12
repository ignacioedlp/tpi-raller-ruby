class Shift < ApplicationRecord

  #tiene un usuario y un admin asociado 
  belongs_to :user
  belongs_to :admin_user, optional: true
  belongs_to :branch_office, inverse_of: :shifts

  DAYS = {
        "Lunes" => 0,
        "Martes" => 1,
        "Miércoles" => 2,
        "Jueves" => 3,
        "Viernes" => 4,
        "Sábado" => 5,
        "Domingo" => 6
    }
  STATUSES = ["Pendiente", "Aceptado", "Rechazado"]

end