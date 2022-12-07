ActiveAdmin.register AdminUser do
  menu label: proc { I18n.t("active_admin.title.admin_users") }
  menu label: "Empleados", if: proc { current_admin_user.has_role? :admin }

  permit_params :email, :password, :branch_office_id, :username, :password_confirmation, :id, role_ids: []
  decorate_with AdminUserDecorator

  config.sort_order = "username_asc"

  config.remove_action_item :new
  config.remove_action_item :destroy

  action_item :new, only: :index do
    link_to "Crear empleado", new_admin_admin_user_path if current_admin_user.has_role? :admin
  end

  action_item :destroy, only: :show do
    link_to "Eliminar empleado", admin_admin_user_path, method: :delete, data: {confirm: "¿Está seguro que desea eliminar este empleado?"} if current_admin_user.has_role? :admin
  end

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :branch_office
    column :roles
    actions defaults: false do |admin_user|
      item "Ver", admin_admin_user_path(admin_user), class: "member_link"
      item "Editar", edit_admin_admin_user_path(admin_user), class: "member_link" if current_admin_user.has_role? :admin
      item "Eliminar", admin_admin_user_path(admin_user), method: :delete, data: {confirm: "¿Está seguro que desea eliminar esta sucursal?"}, class: "member_link" if current_admin_user.has_role? :admin
    end
  end

  show do
    attributes_table do
      row :email
      row :username
      row :roles
      row :branch_office
      row :created_at
    end
  end

  filter :email
  filter :username
  filter :branch_office
  filter :roles

  controller do

    def edit 
      if current_admin_user.has_role? :admin
        super
      elsif current_admin_user.id == params[:id].to_i
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para editar usuarios administradores"
      end
    end

    def create
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_admin_users_path, alert: "No tiene permisos para crear usuarios administradores"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        if params[:admin_user][:password].blank?
          params[:admin_user].delete("password")
        end
        super
      elsif current_admin_user.id == params[:id].to_i
        if params[:admin_user][:password].blank?
          params[:admin_user].delete("password")
        end
        params[:admin_user].delete("role_ids")
        params[:admin_user].delete("branch_office_id")
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
      f.input :email
      f.input :username
      f.input :branch_office, as: :select, collection: BranchOffice.all if current_admin_user.has_role? :admin
      f.input :roles, as: :check_boxes, collection: Role.all if current_admin_user.has_role? :admin
      f.input :password, required: f.object.new_record?
      if f.object.new_record?
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
