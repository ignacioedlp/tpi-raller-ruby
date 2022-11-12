ActiveAdmin.register AdminUser do
  permit_params :email, :password, :branch_office_id, :username, :password_confirmation, :role_ids => []

  index do
    selectable_column
    id_column
    column "Correo", :email
    column "Nombre de usuario", :username
    column "Sucursal", :branch_office
    column "Roles", :roles
    column "Creacion", :created_at
    column "Actualizacion", :updated_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :username
      row :roles
      row :branch_office
      row :created_at
    end
  end


  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email, label: "Correo"
      f.input :username, label: "Nombre de usuario"
      f.input :branch_office , as: :select, collection: BranchOffice.all, label: "Sucursal"
      f.input :roles, as: :check_boxes, collection: Role.all, label: "Roles"
      if f.object.new_record? 
        f.input :password, label: "Contraseña"
        f.input :password_confirmation, label: "Confirmar contraseña"
      end
    end
    f.actions
  end

end
