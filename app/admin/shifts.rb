ActiveAdmin.register Shift do
  menu label: proc { I18n.t("active_admin.title.shifts") }
  decorate_with ShiftDecorator
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :day, :hour, :branch_office_id, :user_id, :reason, :status, :admin_user_id, :comment
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
    column "Dia", :name
    column "Hora", :hour
    column "Razon", :reason
    column "Atendido", :admin_user
    column "Estado", :status
    column "Creacion", :created_at
    column "Actualizacion", :updated_at
    actions
  end

  show :title => "Turno" do
    attributes_table  do
      row :branch_office
      row :user
      row :name
      row :hour
      row :reason
      row :admin_user
      row :status
      row :comment
      row :created_at
    end

  end

  # Custom update
  controller do
    # Solamente traer los shifts de la misma sucursal del empleado que son staff
    def scoped_collection
      if current_admin_user.has_role? :staff and not current_admin_user.has_role? :admin
        Shift.where(branch_office_id: current_admin_user.branch_office_id)
      else
        Shift.all
      end
    end

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
        redirect_to admin_admin_users_path, alert: "No tiene permisos para crear turnos"
      end
    end

    def update
      if current_admin_user.branch_office_id == Shift.find(params[:id]).branch_office_id
          super
      else 
          redirect_to admin_admin_users_path, alert: "No tiene permisos para editar turnos de otras sucursales"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para eliminar turnos"
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :branch_office, label: "Sucursal"
      f.input :user, label: "Usuario"
      f.input :admin_user, label: "Personal atencion", input_html: { value: current_admin_user.id }
      f.input :day, label: "Dia", as: :select, collection: Shift::DAYS

      f.input :hour, label: "Hora", as: :time_picker
      f.input :reason, label: "Razon"
      f.input :status, label: "Estado", as: :select, collection: Shift::STATUSES
      f.input :comment, label: "Comentario"
    end
    f.actions
  end
  
end
