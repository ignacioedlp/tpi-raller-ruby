ActiveAdmin.register BranchOffice do
  menu label: proc { I18n.t("active_admin.title.branch_offices") }
  decorate_with BranchOfficeDecorator

  config.remove_action_item :new
  config.remove_action_item :destroy
  config.remove_action_item :edit

  action_item :new, only: :index do
    link_to "Crear sucursal", new_admin_branch_office_path if current_admin_user.has_role? :admin
  end

  action_item :edit, only: :show do
    link_to "Editar sucursal", edit_admin_branch_office_path if current_admin_user.has_role? :admin
  end

  action_item :destroy, only: :show do
    link_to "Eliminar sucursal", admin_branch_office_path, method: :delete, data: {confirm: "¿Está seguro que desea eliminar esta sucursal?"} if current_admin_user.has_role? :admin
  end

  permit_params :name,
    :address,
    :phone

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :phone
    column :shifts
    actions defaults: false do |branch_office|
      item "Ver", admin_branch_office_path(branch_office), class: "member_link"
      item "Editar", edit_admin_branch_office_path(branch_office), class: "member_link" if current_admin_user.has_role? :admin
      item "Eliminar", admin_branch_office_path(branch_office), method: :delete, data: {confirm: "¿Está seguro que desea eliminar esta sucursal?"}, class: "member_link" if current_admin_user.has_role? :admin
    end
  end

  show do
    attributes_table do
      row :name
      row :address
      row :phone
      row :created_at
    end

    panel "Horarios de atencion" do
      attributes_table_for branch_office.opening_hours.decorate do
        row :name
        row :opens
        row :closes
      end
    end
  end

  filter :name

  controller do
    def create
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para crear sucursales"
      end
    end

    def new 
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para crear sucursales"
      end
    end
    

    def edit
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para editar sucursales"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para editar sucursales"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        if resource.destroy
          redirect_to admin_branch_offices_path, notice: "Sucursal eliminada!"
        else
          redirect_to admin_branch_offices_path, alert: "No se puede eliminar una sucursal con turnos pendientes"
        end
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para eliminar sucursales"
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :phone
    end

    f.actions
  end
end
