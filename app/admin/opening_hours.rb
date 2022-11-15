ActiveAdmin.register OpeningHour do
  menu label: proc { I18n.t("active_admin.title.opening_hours") }
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :branch_office_id, :day, :opens, :closes
  #
  # or
  #
  permit_params do
    # Convert day to integer to save in database 
    permitted = [:branch_office_id, :day, :opens, :closes]
    permitted
  end

  index :title => I18n.t("active_admin.title.opening_hours") do
    selectable_column
    id_column
    column "Sucursal", :branch_office
    column "Dia", :days
    column "Abre", :opens
    column "Cierra", :closes
    column "Creacion", :created_at
    column "Actualizacion", :updated_at
    actions
  end

  show do
    attributes_table do
      row :branch_office
      row :day 
      row :opens
      row :closes
      row :created_at
    end

  end

  filter :branch_office
  filter :day
  filter :opens
  filter :closes
  filter :created_at

  controller do
    def create
      if current_admin_user.has_role? :admin
        params[:opening_hour][:day] = params[:opening_hour][:day].to_i
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para crear horarios"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        params[:opening_hour][:day] = params[:opening_hour][:day].to_i
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para editar horarios"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para eliminar horarios"
      end
    end
  end


  form do |f|
    f.inputs do
      f.input :branch_office, as: :select, collection: BranchOffice.all, label: "Sucursal"
      f.input :day, as: :select, collection: OpeningHour::DAYS, label: "Dia"
      f.input :opens, label: "Abre"
      f.input :closes, label: "Cierra"
    end
    f.actions
  end
  
end
