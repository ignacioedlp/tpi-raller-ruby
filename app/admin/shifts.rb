ActiveAdmin.register Shift do
  menu label: proc { I18n.t("active_admin.title.shifts") }
  decorate_with ShiftDecorator
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :date, :branch_office_id, :user_id, :reason, :status, :admin_user_id, :comment
  #
  # or
  #
  # permit_params do
  #   permitted = [:branch_office_id, :user_id, :day, :hour, :reason, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :branch_office
    column :user
    column :name
    column :hour
    column :reason
    column :admin_user
    column :status
    actions
  end

  show title: "Turno" do
    attributes_table do
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
      if current_admin_user.has_role?(:staff) && (!current_admin_user.has_role? :admin)
        Shift.where(branch_office_id: current_admin_user.branch_office_id)
      else
        Shift.all
      end
    end
  end

  filter :user
  filter :date
  filter :status

  controller do
    def scoped_collection
      if current_admin_user.has_role?(:staff) && (!current_admin_user.has_role? :admin)
        Shift.where(branch_office_id: current_admin_user.branch_office_id)
      else
        Shift.all
      end
    end

    def create
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_shifts_path, alert: "No tiene permisos para crear turnos"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        super
      elsif current_admin_user.branch_office_id == Shift.find(params[:id]).branch_office_id
        super
      else
        redirect_to admin_shifts_path, alert: "No tiene permisos para actualizar turnos de otras sucursales"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_shifts_path, alert: "No tiene permisos para eliminar turnos"
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :branch_office
      f.input :user
      f.input :admin_user, input_html: {value: current_admin_user.id}
      f.input :date, as: :date_time_picker
      f.input :reason
      f.input :status, as: :select, collection: Shift::STATUSES
      f.input :comment
    end
    f.actions
  end
end
