ActiveAdmin.register Shift do
  menu label: proc { I18n.t("active_admin.title.shifts") }

  decorate_with ShiftDecorator

  permit_params :date, :branch_office_id, :user_id, :reason, :completed, :admin_user_id, :comment

  config.remove_action_item :new
  config.remove_action_item :destroy
  config.remove_action_item :edit

  action_item :edit, only: :show do
    link_to "Editar turno", edit_admin_shift_path if current_admin_user.has_role? :staff
  end

  action_item :destroy, only: :show do
    link_to "Eliminar turno", admin_shift_path, method: :delete, data: {confirm: "¿Está seguro que desea eliminar este turno?"} if current_admin_user.has_role? :staff
  end

  index do
    selectable_column
    id_column
    column :branch_office
    column :user
    column :name
    column :hour
    column :reason
    column :admin_user
    column :completed
    actions defaults: false do |shift|
      item "Ver", admin_shift_path(shift), class: "member_link"
      item "Editar", edit_admin_shift_path(shift), class: "member_link" if current_admin_user.has_role? :staff
      item "Eliminar", admin_shift_path(shift), method: :delete, data: {confirm: "¿Está seguro que desea eliminar este turno?"}, class: "member_link" if current_admin_user.has_role? :staff
    end
  end

  show title: "Turno" do
    attributes_table do
      row :branch_office
      row :user
      row :name
      row :hour
      row :reason
      row :admin_user
      row :completed
      row :comment
      row :created_at
    end
  end

  controller do
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
  filter :completed

  controller do
    def scoped_collection
      if current_admin_user.has_role?(:staff) && (!current_admin_user.has_role? :admin)
        Shift.where(branch_office_id: current_admin_user.branch_office_id)
      else
        Shift.all
      end
    end

    def new
      redirect_to admin_shifts_path, alert: "Los turnos solamente los crea un cliente!"
    end

    def create
      redirect_to admin_shifts_path, alert: "Los turnos solamente los crea un cliente!"
    end

    def update
      if current_admin_user.branch_office_id == Shift.find(params[:id]).branch_office_id && (current_admin_user.has_role? :staff)
        super
      else
        redirect_to admin_shifts_path, alert: "No tiene permisos para actualizar turnos de otras sucursales"
      end
    end

    def destroy
      if current_admin_user.branch_office_id == Shift.find(params[:id]).branch_office_id && (current_admin_user.has_role? :staff)
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
      f.input :admin_user, collection: AdminUser.where(branch_office_id: f.object.branch_office_id), input_html: {value: current_admin_user.id}
      f.input :date, as: :datetime_picker
      f.input :reason
      f.input :completed
      f.input :comment
    end
    f.actions
  end
end
