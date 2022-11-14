ActiveAdmin.register BranchOffice do
  menu label: proc { I18n.t("active_admin.title.branch_offices") }
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :phone
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :phone]
  #   permitted << :other if params[:action] == 'create' && current_user.has_role?(:admin)
  #   permitted
  # end

  index :title => I18n.t("active_admin.title.branch_offices") do
    selectable_column
    id_column
    column "Nombre", :name
    column "Direccion", :address
    column "Telefono", :phone
    column "Horarios de atencion", :opening_hours
    column "Creacion", :created_at
    column "Actualizacion", :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :phone
      row :opening_hours
      row :created_at
    end
  end

  filter :name
  filter :address
  filter :phone
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
      f.input :name, label: "Nombre"
      f.input :address, label: "Direccion"
      f.input :phone, label: "Telefono"
      f.input :opening_hours, label: "Horarios de atencion"
    end
    f.actions
  end
  
end
