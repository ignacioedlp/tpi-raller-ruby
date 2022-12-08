ActiveAdmin.register OpeningHour do
  menu label: proc { I18n.t("active_admin.title.opening_hours") }
  decorate_with OpeningHourDecorator

  config.remove_action_item :new
  config.remove_action_item :destroy
  config.remove_action_item :edit

  action_item :new, only: :index do
    link_to "Crear horario", new_admin_opening_hour_path if current_admin_user.has_role? :admin
  end

  action_item :edit, only: :show do
    link_to "Editar horario", edit_admin_opening_hour_path if current_admin_user.has_role? :admin
  end

  action_item :destroy, only: :show do
    link_to "Eliminar horario", admin_opening_hour_path, method: :delete, data: {confirm: "¿Está seguro que desea eliminar este horario?"} if current_admin_user.has_role? :admin
  end

  permit_params do
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
    actions defaults: false do |opening_hour|
      item "Ver", admin_opening_hour_path(opening_hour), class: "member_link"
      item "Editar", edit_admin_opening_hour_path(opening_hour), class: "member_link" if current_admin_user.has_role? :admin
      item "Eliminar", admin_opening_hour_path(opening_hour), method: :delete, data: {confirm: "¿Está seguro que desea eliminar este horario?"}, class: "member_link" if current_admin_user.has_role? :admin
    end
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
    def edit
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_opening_hours_path, alert: "No tiene permisos para editar horarios"
      end
    end

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
      f.input :branch_office, as: :select, collection: BranchOffice.all, include_blank: false
      f.input :day, as: :select, collection: OpeningHour::DAYS, selected: f.object.day, include_blank: false
      f.input :opens, as: :time_picker
      f.input :closes, as: :time_picker
    end
    f.actions
  end
end
