ActiveAdmin.register Shift do
  menu label: proc { I18n.t("active_admin.title.shifts") }
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :day, :hour, :branch_office_id, :user_id, :reason, :status, :admin_user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:branch_office_id, :user_id, :day, :hour, :reason, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index :title => I18n.t("active_admin.title.shifts") do
    selectable_column
    id_column
    column "Sucursal", :branch_office
    column "Usuario", :user
    column "Dia", :day
    column "Hora", :hour
    column "Razon", :reason
    column "Atendido", :admin_user
    column "Estado", :status
    column "Creacion", :created_at
    column "Actualizacion", :updated_at
    actions
  end

  show do
    attributes_table do
      row :branch_office
      row :user
      row :day
      row :hour
      row :reason
      row :admin_user
      row :status
      row :created_at
    end
  end

  # Custom update
  controller do
    def update
      # Convert day to integer to save in database
      params[:shift][:day] = params[:shift][:day].to_i
      super
    end
    def create
      # Convert day to integer to save in database
      debugger
      params[:shift][:day] = params[:shift][:day].to_i
      super
    end
  end

  filter :branch_office
  filter :user
  filter :day
  filter :hour
  filter :reason
  filter :status
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
        # Solo los usuarios del mismo sucursal pueden editar
        if current_admin_user.branch_office_id == Shift.find(params[:id]).branch_office_id
          super
        else 
          redirect_to admin_admin_users_path, alert: "No tiene permisos para editar "
        end
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
      f.input :branch_office, label: "Sucursal"
      f.input :user, label: "Usuario"
      f.input :admin_user, label: "Personal atencion", input_html: { value: current_admin_user.id }
      f.input :day, label: "Dia", as: :select, collection: Shift::DAYS

      #  TODO: Add hours for each day
      f.input :hour, label: "Hora"
      f.input :reason, label: "Razon"
      f.input :status, label: "Estado", as: :select, collection: Shift::STATUSES
    end
    f.actions
  end
  
end
