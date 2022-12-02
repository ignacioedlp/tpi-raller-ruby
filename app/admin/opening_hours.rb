ActiveAdmin.register OpeningHour do
  menu label: proc { I18n.t("active_admin.title.opening_hours") }
  decorate_with OpeningHourDecorator
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

  index do
    selectable_column
    id_column
    column :branch_office
    column :name
    column :opens
    column :closes
    actions
  end

  show do
    attributes_table do
      row :branch_office
      row :name
      row :opens
      row :closes
    end
  end

  filter :branch_office

  controller do
    def create
      if current_admin_user.has_role? :admin
        params[:opening_hour][:day] = params[:opening_hour][:day].to_i
        super
      else
        redirect_to admin_opening_hours_path, alert: "No tiene permisos para crear horarios"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        params[:opening_hour][:day] = params[:opening_hour][:day].to_i
        super
      else
        redirect_to admin_opening_hours_path, alert: "No tiene permisos para editar horarios"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_opening_hours_path, alert: "No tiene permisos para eliminar horarios"
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :branch_office, as: :select, collection: BranchOffice.all
      f.input :day, as: :select, collection: OpeningHour::DAYS
      f.input :opens, as: :time_picker
      f.input :closes, as: :time_picker
    end
    f.actions
  end
end
