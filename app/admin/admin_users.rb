ActiveAdmin.register AdminUser do
  menu label: proc { I18n.t("active_admin.title.admin_users") }
  permit_params :email, :password, :branch_office_id, :username, :password_confirmation, :id, role_ids: []

  config.sort_order = "username_asc"

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :branch_office
    column :roles
    column :created_at
    column :updated_at
    actions
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
      f.input :branch_office, as: :select, collection: BranchOffice.all
      f.input :roles, as: :check_boxes, collection: Role.all
      f.input :password, required: f.object.new_record?
      if f.object.new_record?
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
