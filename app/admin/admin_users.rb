ActiveAdmin.register AdminUser do
  menu label: proc { I18n.t("active_admin.title.admin_users") }
  permit_params :email, :password, :branch_office_id, :username, :password_confirmation, :role_ids => []

  index :title => I18n.t("active_admin.title.admin_users") do
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

  show  do
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

  controller do
    def create
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para crear usuarios administradores"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para editar usuarios administradores"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para eliminar usuarios administradores"
      end
    end
  end


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
